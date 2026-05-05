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
    --json number,title,state,labels,assignees,url,body,reactionGroups)
fi

# Status labels we render in their own dedicated columns/sections — hide them
# from the generic "Labels" column so it shows only the interesting tags.
STATUS_LABELS='["available","needs-discussion","claimed","in-progress","done"]'

# Render a markdown table for issues matching a jq boolean expression.
# Falls back to "_(none)_" when no issues match.
filter_to_table() {
  local expr="$1"
  local rows
  rows=$(printf '%s' "$ISSUES" | jq -r --argjson hide "$STATUS_LABELS" "
    def clean(s): (s // \"\")
      | gsub(\"\r\"; \"\")
      | gsub(\"\n+\"; \" \")
      | gsub(\"\\\\|\"; \"\\\\|\")
      | gsub(\" +\"; \" \")
      | sub(\"^ +\"; \"\")
      | sub(\" +\$\"; \"\");
    def truncate(s; n):
      if (s | length) > n then (s[0:n] | sub(\" +[^ ]*\$\"; \"\")) + \"…\" else s end;
    def thumbs:
      ((.reactionGroups // [])
        | map(select(.content == \"THUMBS_UP\"))
        | map(.users.totalCount // .reactions.totalCount // 0)
        | (.[0] // 0));
    def labelnames: (.labels | map(.name));
    def visible_labels: labelnames | map(select(. as \$n | \$hide | index(\$n) | not));
    def labels_md:
      visible_labels
      | if length == 0 then \"—\"
        else map(\"\`\" + . + \"\`\") | join(\" \") end;
    def assignees_md:
      if (.assignees | length) == 0 then \"—\"
      else (.assignees | map(\"@\" + .login) | join(\", \")) end;
    map(select($expr))
    | sort_by(-thumbs, .number)
    | .[]
    | \"| [#\(.number)](\(.url)) | \(clean(.title)) | \(truncate(clean(.body); 140)) | \(labels_md) | \(thumbs) | \(assignees_md) |\"
  ")
  if [[ -z "$rows" ]]; then
    printf '_(none)_'
  else
    printf '| # | Title | Description | Labels | 👍 | Assignees |\n'
    printf '|---|-------|-------------|--------|----|-----------|\n'
    printf '%s' "$rows"
  fi
}

has()   { printf '(.labels | map(.name) | index("%s")) != null' "$1"; }
lacks() { printf '(.labels | map(.name) | index("%s")) == null' "$1"; }

now=$(date -u +"%Y-%m-%d %H:%M UTC")

NL=$'\n'
DOC="# Ideas — live snapshot${NL}${NL}"
DOC+="Auto-regenerated from [the issues](https://github.com/${REPO}/issues) on every change.${NL}"
DOC+="Don't edit this file by hand — edit the issues instead.${NL}${NL}"
DOC+="Within each section, ideas are sorted by 👍 reactions (highest first). React on the issue itself to vote!${NL}${NL}"
DOC+="Last refresh: ${now}${NL}${NL}"

DOC+="## Available${NL}${NL}"
DOC+="$(filter_to_table ".state == \"OPEN\" and $(has available) and $(lacks needs-discussion)")${NL}${NL}"

DOC+="## Needs discussion${NL}${NL}"
DOC+="$(filter_to_table ".state == \"OPEN\" and $(has needs-discussion)")${NL}${NL}"

DOC+="## Claimed${NL}${NL}"
DOC+="$(filter_to_table ".state == \"OPEN\" and $(has claimed)")${NL}${NL}"

DOC+="## In progress${NL}${NL}"
DOC+="$(filter_to_table ".state == \"OPEN\" and $(has in-progress)")${NL}${NL}"

DOC+="## Done${NL}${NL}"
DOC+="$(filter_to_table ".state == \"CLOSED\" or $(has done)")${NL}"

printf '%s' "$DOC" > IDEAS.md

echo "Wrote IDEAS.md"
