# Umbraco Hackathon Ideas
A consolidated list of Umbraco package ideas — for any hackathon (Spark, Codegarden community days, retreats, your local meetup). Pick an idea, team up, build something demoable.

## What is this?
A hackathon is a build-something event where you grab a small team (1–3 people), pick an idea, and ship a demoable package by the end. This repo is the list of ideas.
The current theme has a strong **AI angle** — either *using* AI to build the package or *adding* AI to help editors in Umbraco — but other Umbraco-related ideas are welcome too.

## How to claim an idea
You don't need write access. Here's the flow:
1. Browse the [open issues](https://github.com/umbraco/Umbraco.Hackathon.Ideas/issues) — each one is an idea. Filter by [`available`](https://github.com/umbraco/Umbraco.Hackathon.Ideas/issues?q=is%3Aissue+is%3Aopen+label%3Aavailable) to see what's still up for grabs.
2. Found one? **Comment "I'm claiming this"** — include who you are and (rough) who you're teaming with.
3. A maintainer will assign you and switch the label from `available` to `claimed`.
4. When you start coding, drop a link to your repo in the issue. We'll move it to `in-progress`.
5. Demo when it's ready. We'll close the issue with `done` and a link to the package.

If life happens and you can't finish, comment on the issue so it can go back to `available`. No drama.

## How to propose a new idea
Open an issue using the **"Propose a new idea"** template. A maintainer will tag it with the right theme labels and mark it `available`.

## Inspiration
For a quick overview grouped by status (available / claimed / in-progress / done), see **[IDEAS.md](IDEAS.md)** — it's auto-regenerated from the live issues on every change.

Before claiming, check whether something already exists. Known AI-adjacent (and adjacent-adjacent) Umbraco packages worth knowing about.

### AI & AI-adjacent

*Built on [Umbraco.AI](https://marketplace.umbraco.com/package/umbraco.ai):*
- **[AI Log Analyser](https://marketplace.umbraco.com/package/umbraco.community.ai.loganalyser)** (Justin Neville) — sends Umbraco log entries through an LLM for explanation + suggested fixes.
- **[Browser AI Provider](https://marketplace.umbraco.com/package/umbraco.community.ai.browserprovider)** (Filip Bech-Larsen) — an in-browser AI provider integration for Umbraco.AI.
- **[Chatbot](https://marketplace.umbraco.com/package/umbraco.community.ai.chatbot)** (Filip Bech-Larsen) — a chatbot for Umbraco built on Umbraco.AI.
- **[Legal Review](https://marketplace.umbraco.com/package/umbraco.community.legalreview)** (Filip Bech-Larsen) — AI-assisted legal review of content, built on Umbraco.AI.
- **[Umbraco.AI.Search](https://mattbrailsford.dev/introducing-umbraco-ai-search)** (Matt Brailsford / Umbraco) — semantic vector search built on Umbraco.AI / Umbraco.Cms.Search.
- **[Alchemy](https://marketplace.umbraco.com/package/kraftvaerk.umbraco.alchemy)** (Kaspar Boel Kjeldsen / Kraftvaerk) — AI-assisted descriptions and labels for property types and blocks.
- **[MetaMate AI](https://marketplace.umbraco.com/package/metamateai)** (Tobias Dokken) — AI helper for editors in the backoffice.
- **[ProWorks Umbraco.AI Page Evaluator](https://marketplace.umbraco.com/package/proworks.umbraco.ai.pageevaluator)** (ProWorks) — evaluates pages with AI: structured quality report, scored checks, suggestions.

*Other AI-powered:*
- **[AltTextAI Integration](https://marketplace.umbraco.com/package/blendinteractive.umbraco.alttextai)** (Joe Kepley / Blend Interactive) — AI alt-text and image caption generation.
- **[umContentCreator](https://marketplace.umbraco.com/package/umcontentcreator)** (Kyrylo Osadchuk / OSKI solutions) — AI-powered content generation including alt text.
- **[Complete site importer](https://www.youtube.com/watch?v=0z4E444nBPs)** (Paul Seal) — AI-assisted site/content importer. Video demo for now; not yet packaged.

*AI-adjacent (structured data for AI consumers):*
- **[SchemeWeaver](https://marketplace.umbraco.com/package/umbraco.community.schemeweaver)** (Oliver Picton) — map Umbraco Content Types to schema.org schemas and emit JSON-LD on the public site, so AI bots and search engines can read your structured data.
- **[Growcreate Schema Generator](https://marketplace.umbraco.com/package/growcreate.schemagenerator)** (James Dimmer / GrowCreate) — generate schema.org structured data for Umbraco content.

### Other Umbraco packages worth knowing about

- **[UpDoc](https://marketplace.umbraco.com/package/umbraco.community.updoc)** (Dean Leigh) — generates Umbraco pages from imported PDFs.
- **[Favourites](https://marketplace.umbraco.com/package/umbraco.community.favourites)** (Luke Hook, Gregory Dove, Sam Forrest / Gibe Digital) — pin favourite nodes to the top of the content tree.
- **[Delivery API Model Mapper](https://marketplace.umbraco.com/package/umbraco.community.deliveryapimodelmapper)** (Tristan Thompson / Gibe Digital) — define custom models returned by the Delivery API, with auto-generated TypeScript definitions via the Swagger schema (v13 & v17).

For the underlying framework these build on, see [Umbraco.AI](https://marketplace.umbraco.com/package/umbraco.ai) (HQ) and the [AI category on the Marketplace](https://marketplace.umbraco.com/category/artificial-intelligence) for the full picture.
If your idea looks similar to one of these, consider building on top of it or contributing to it instead.

## Labels
| Label | Meaning |
|---|---|
| `available` | Free to claim |
| `claimed` | Someone has put their hand up |
| `in-progress` | Code is being written |
| `done` | Demoed, package shipped (or close enough) |
| `ai` | Has an AI angle |
| `editor-ux` | Backoffice / editor experience |
| `delivery-api` | Touches the Delivery API |
| `integration` | Connects Umbraco to a third party |
| `framework` | Foundational / plumbing — useful base for other packages |
| `needs-discussion` | Idea isn't ready for claim yet — talk first |


## Handy links

- **[ Setting Up a New Umbraco Package Dev Environment with Umbraco.AI ](https://dev.to/cultiv/setting-up-a-new-umbraco-package-dev-environment-with-umbracoai-3iac)**  — (Sebastiaan Janssen / Umbraco HQ)