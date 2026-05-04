#!/usr/bin/env bash
# Regenerate IDEAS.md from the live GitHub issues.
# Run automatically by .github/workflows/refresh-ideas.yml on any issue change.
# Local usage: cd into a clone of umbraco/Umbraco.Hackathon.Ideas, then: bash scripts/regenerate-ideas.sh

set -euo pipefail

REPO="${GITHUB_REPOSITORY:-umbraco/Umbraco.Hackathon.Ideas}"

# Allow tests to inject fake issue data
if [[ -n "${ISSUES_JSON_FILE:-}" ]]; then
  ISSUES=$(cat "$ISSUES_JSON_FILE")
else
  ISSUES=$(gh issue list -R "$REPO" --state all --limit 500 \
    --json number,title,state,labels,assignees,url)
fi

# Filter expression takes one argument: a jq boolean expression.
# Returns markdown bullet lines, or "_(none)_" if no matches.
filter_to_markdown() {
  local expr="$1"
  local result
  result=$(printf '%s' "$ISSUES" | jq -r "
    map(select($expr))
    | sort_by(.number)
    | .[]
    | \"- [#\\(.number) \\(.title)](\\(.url))\"
      + (if (.assignees | length) > 0
           then \" — assigned to \" + (.assignees | map(\"@\" + .login) | join(\", \"))
           else \"\" end)
  ")
  if [[ -z "$result" ]]; then
    printf '_(none)_'
  else
    printf '%s' "$result"
  fi
}

has()   { printf '(.labels | map(.name) | index("%s")) != null' "$1"; }
lacks() { printf '(.labels | map(.name) | index("%s")) == null' "$1"; }

now=$(date -u +"%Y-%m-%d %H:%M UTC")

# Build the whole document into one variable, then write it in a single op.
NL=$'\n'
DOC="# Ideas — live snapshot${NL}${NL}"
DOC+="Auto-regenerated from [the issues](https://github.com/${REPO}/issues) on every change.${NL}"
DOC+="Don't edit this file by hand — edit the issues instead.${NL}${NL}"
DOC+="Last refresh: ${now}${NL}${NL}"

DOC+="## Available${NL}${NL}"
DOC+="$(filter_to_markdown ".state == \"OPEN\" and $(has available) and $(lacks needs-discussion)")${NL}${NL}"

DOC+="## Needs discussion${NL}${NL}"
DOC+="$(filter_to_markdown ".state == \"OPEN\" and $(has needs-discussion)")${NL}${NL}"

DOC+="## Claimed${NL}${NL}"
DOC+="$(filter_to_markdown ".state == \"OPEN\" and $(has claimed)")${NL}${NL}"

DOC+="## In progress${NL}${NL}"
DOC+="$(filter_to_markdown ".state == \"OPEN\" and $(has in-progress)")${NL}${NL}"

DOC+="## Done${NL}${NL}"
DOC+="$(filter_to_markdown ".state == \"CLOSED\" or $(has done)")${NL}"

printf '%s' "$DOC" > IDEAS.md

echo "Wrote IDEAS.md"
