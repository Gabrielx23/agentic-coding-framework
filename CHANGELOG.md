# Changelog

All notable changes to the Agentic Coding Framework are recorded here.

## [0.1.0] – 2026-11-02

### Breaking

- Split drop-in layout: `acf/` is framework-only; project data lives in `acf-project/`.
- Path renames for language files, decision records, architecture views, charter, and metrics.

### Added

- `acf/VERSION`, `acf/NOTICE.md`, root `CHANGELOG.md`, `CONTRIBUTING.md`.
- Skill and template indexes in `acf/AGENTS.md`.
- Root `AGENTS.md` non-negotiable rules for tools that load only the root file.
- Evidence, `unconfirmed`, `Proposed` ADR, and Approver rules for Define drafts.
- Examples under `examples/billing-service/` and `examples/subscription-service/`.
- Minimal `examples/ci/CODEOWNERS`.

### Changed

- Agents draft language, decision records, and C1/C2 views; people must confirm meaning and decisions.
- Tagline unified as "agent-written code".
