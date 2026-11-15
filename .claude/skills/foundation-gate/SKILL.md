---
name: foundation-gate
description: >
  Foundation Gate for SDD projects. Use when checking or creating the project foundation docs
  (PRD.md, DESIGN_SYSTEM.md, ARCHITECTURE.md, AGENTS.md), when a new repo has no SDD setup, or when
  the user says "foundation", "gate", "constitution", "setup project", or "buat PRD/ARCHITECTURE".
  Runs once per project before any feature spec. Checks substantive content, interviews the developer
  one file at a time (max 3 rounds per file), and writes files from templates. Never writes feature specs.
---

# SKILL: foundation-gate

## Core Purpose
Make sure every project has the four foundation documents before any feature work begins. These documents give every AI agent the project context it needs. This skill runs once per project. It does not write feature requirements or specs. Those belong to `spec-writer` and `sdd`.

## Required Files
The target project must contain 4 markdown files with **substantive content**:

| File | Purpose |
|------|---------|
| `PRD.md` | Product/business context: what and why, target users, KPIs |
| `DESIGN_SYSTEM.md` | UI/UX consistency: colors, typography, spacing, components, tokens |
| `ARCHITECTURE.md` | Technical structure: folder layout, data flow, services, DB schema |
| `AGENTS.md` | Coding SOP: tech stack, conventions, commands, rules the AI must obey. Also carries the SDD rules so any agent enforces the workflow |

Templates are in `templates/` in this skill folder.

## Step 1 — Foundation Check (always run first)
Search the project root for the 4 files. Check both `<root>/X.md` and `<root>/docs/X.md`.

Report a status table:

```
PRD.md            ✅ present (2.1 KB)
DESIGN_SYSTEM.md  ❌ missing
ARCHITECTURE.md   ✅ present (3.4 KB)
AGENTS.md         ❌ missing
```

A file counts as present only if it has substantive content. An empty file or a stub with only headers does not count.

## Step 2 — Gate Decision
- **All 4 present → PASS.** Say so and stop. Feature work may start with `spec-writer`.
- **Any missing or empty → BLOCK.** Say: *"Feature requirements gathering is blocked. Foundation docs incomplete."* Go to Step 3.

## Step 3 — Create Missing Foundation Docs (one at a time)
For each missing file, in the order `PRD.md → DESIGN_SYSTEM.md → ARCHITECTURE.md → AGENTS.md`:

1. Interview the developer with the question set for that file (below).
2. Ask at most **3 rounds** per file. After that, fill gaps with `assumed — verify` markers instead of blocking.
3. Write the file from the matching template, replacing placeholders with the developer's answers.
4. Mark every assumption explicitly.
5. Re-run Step 1. When all 4 are present, the gate is **PASS**.

For a new project, all 4 files are missing. Interview once per file, in order. Product answers come first because the design and architecture answers depend on them.

## Question Sets per File

**PRD.md** (business and feature context)
- What does this product or service do, in one sentence?
- Who are the target users, and what problem does it solve for them?
- What are the top 3–5 features or functional areas?
- Business goals and KPIs (success metrics)?
- Who are the stakeholders? Any constraints (regulation, market)?
- Current state: greenfield, or replacing or evolving an existing product?
- Non-goals for this version?

**DESIGN_SYSTEM.md** (UI consistency)
- Platform (web, mobile, desktop) and UI framework (React, Tailwind, Flutter, …)?
- Primary brand color(s) with hex values? Semantic tokens (success, warning, error, info)?
- Typography: font families, scale (sizes, weights), line height?
- Spacing and radius scale (grid unit, 4px or 8px base)?
- Core components (buttons, inputs, cards, modals, tables, …)?
- Dark mode and accessibility requirements (contrast, focus states)?
- Design tool (Figma) or UI library reference?

**ARCHITECTURE.md** (structure and data flow)
- Monolith or microservices? Main languages and frameworks?
- Top-level folder and module layout?
- Request lifecycle: client → API → service → DB?
- Services and components, and how they communicate (sync REST, gRPC, events)?
- Database: type, naming, migration approach?
- External dependencies (third-party APIs, brokers, cache)?
- Deployment target (cloud or on-prem, container, CI/CD)?

**AGENTS.md** (coding SOP)
- Tech stack and versions (language, framework, package manager)?
- Project structure conventions (folders, naming, file organization)?
- Code style rules (lint, formatting, types, error handling)?
- Test commands and testing conventions (unit, e2e)?
- Build and run commands (dev, build, lint, typecheck, test)?
- Git workflow (branch naming, commit style, PR conventions)?
- Do-not rules (forbidden patterns, libraries, secrets handling)?

## Codebase Awareness
- For an existing repo, derive answers from code first: entry points, manifests (`package.json`, `go.mod`, `pyproject.toml`), and CI config. Cite `file:line` for each claim. Unverified claims are marked `assumed — verify`.
- If an existing file conflicts with the codebase, flag it to the developer. Do not silently rewrite it.

## Rules
- **Never skip the gate.** Check the 4 files first, even if the developer says "just gather requirements".
- **Never create foundation docs without interviewing.** Empty templates with placeholder text do not pass the gate.
- **Never write feature specs here.** Hand off to `spec-writer`.
- **Keep the SDD rules section in `AGENTS.md`.** It is what makes the gate machine-readable for every agent.

## Reference
- Feature workflow: `sdd` skill
- Feature spec drafting: `spec-writer` skill
