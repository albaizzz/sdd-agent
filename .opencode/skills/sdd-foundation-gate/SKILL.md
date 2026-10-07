# SKILL: sdd-foundation-gate

## Core Purpose
Use this skill when a developer wants to start a new feature/task on a project, OR when the project may be missing its foundation documents.

## Trigger Keywords
- PRD, DESIGN_SYSTEM, ARCHITECTURE, AGENTS, SDD
- specification-driven development, foundation docs, gathering requirements, new feature

## Required Files
The project must contain the following 4 markdown files with substantive content:
1. `PRD.md` (Product Requirement Document)
2. `DESIGN_SYSTEM.md` (Design guidelines, components, theme)
3. `ARCHITECTURE.md` (Tech stack, database schema, API design, system flow)
4. `AGENTS.md` (AI Persona, system prompts, agent workflows)

## Execution Protocol (Strict Workflow)

### STEP 1: Foundation Check
- Scan the target project directory for the 4 required markdown files.
- Verify if any of the files are missing or empty/insufficient.

### STEP 2: The Gate (Blocking Mechanism)
- IF any of the 4 files are missing or empty:
  - IMMEDIATELY BLOCK the feature requirements gathering or code generation.
  - Inform the developer which specific foundation documents are missing.
  - Proceed to STEP 3.
- IF all 4 files exist with substantive content:
  - Bypass the gate and proceed directly to STEP 4.

### STEP 3: Foundation Generation (Interview Mode)
- Interview the developer to gather information for the missing documents.
- Focus on one missing document at a time to avoid overwhelming the developer.
- Ask targeted, concise questions about the project's vision, tech stack, design, or agent roles.
- Once the information is gathered, create/populate the missing `.md` files.
- Repeat until all 4 files are complete.

### STEP 4: Feature Requirements & SDD Spec
- Only after the foundation is fully secured, proceed to gather specific requirements for the new feature.
- Generate the SDD (Specification-Driven Development) spec for the requested task.

# SDD Foundation Gate

## Purpose
Before ANY feature requirements gathering starts on a target project, that project MUST have 4 foundation documents. They give the AI the context it needs to write precise specs and code:

| File | Purpose |
|------|---------|
| `PRD.md` | Product/business context — what & why the product is built, target users, KPIs |
| `DESIGN_SYSTEM.md` | UI/UX consistency — colors, typography, spacing, components, tokens |
| `ARCHITECTURE.md` | Technical structure — folder layout, data flow, services, DB schema |
| `AGENTS.md` | Coding SOP — tech stack, conventions, commands, rules the AI must obey |

**No foundation docs → no feature requirements → no code.** This is the gate.

## Target Project
The gate applies to the **project where the feature will be built** — the repository in the current working directory, or the repo the developer points to. NOT this skill's folder.

## Workflow

### Step 1 — Foundation Check (always run first)
Search the target project root for the 4 files. Check both `<root>/X.md` and `<root>/docs/X.md`.

Report a status table:

```
PRD.md            ✅ present (2.1 KB)
DESIGN_SYSTEM.md  ❌ missing
ARCHITECTURE.md   ✅ present (3.4 KB)
AGENTS.md         ❌ missing
```

A file counts as present only if it has **substantive content** (not empty, not a stub with only headers).

### Step 2 — Gate Decision
- **ALL 4 present → PASS.** Proceed to feature requirements gathering and the SDD spec flow (13-point spec, see `specs-v2.md`).
- **Any missing/empty → BLOCK.** Say clearly: *"Feature requirements gathering is blocked. Foundation docs incomplete."* Do NOT gather feature requirements or write feature code yet. Go to Step 3.

### Step 3 — Create Missing Foundation Docs (one at a time)
For each missing file, in the order `PRD.md → DESIGN_SYSTEM.md → ARCHITECTURE.md → AGENTS.md`:

1. Interview the developer with the **targeted question set** for that file (below).
2. Ask at most **3 rounds** of questions per file; after that fill gaps with `assumed — verify` markers instead of blocking.
3. Write the file from the matching template in `templates/`, replacing placeholders with the developer's answers.
4. Mark assumptions explicitly.
5. Re-run the Foundation Check. If all 4 present → **PASS** → now proceed to feature requirements + SDD spec.

If the developer is also building a NEW project from scratch, all 4 files will be missing — interview once for each, in order. Gather product answers for `PRD.md` first, because DESIGN_SYSTEM and ARCHITECTURE answers depend on product context.

## Question Sets per File

### PRD.md (business & feature context)
- What does this product/service do in one sentence?
- Who are the target users, and what problem does it solve for them?
- What are the top 3-5 features/functional areas?
- Business goals & KPIs (success metrics)?
- Who are the stakeholders? Any constraints (regulation, market)?
- Current state: greenfield or replacing/evolving an existing product?
- Non-goals for this product version?

### DESIGN_SYSTEM.md (UI consistency)
- Platform target (web/mobile/desktop) and UI framework (React/Tailwind/Flutter/…)?
- Primary brand color(s) + hex values? Semantic tokens (success/warning/error/info)?
- Typography: font families, scale (sizes/weights), line-height?
- Spacing & radius scale (grid unit, 4px/8px base)?
- Core components list (buttons, inputs, cards, modals, tables…)?
- Dark mode / accessibility requirements (contrast, focus states)?
- Existing design tool (Figma) or UI library reference?

### ARCHITECTURE.md (structure & data flow)
- Monolith or microservices? Main languages/frameworks?
- Folder/module structure — top-level layout?
- Data flow: request lifecycle from client → API → service → DB?
- Services/components and how they communicate (sync/REST/gRPC/events)?
- Database(s): type, schema naming, migrations approach?
- External dependencies (third-party APIs, message brokers, cache)?
- Deployment target (cloud/on-prem, container/CI-CD)?

### AGENTS.md (coding SOP)
- Tech stack & versions (language, framework, package manager)?
- Project structure conventions (folders, naming, file organization)?
- Code style rules (lint, formatting, types, error handling)?
- Test commands & testing conventions (unit/e2e)?
- Build/run commands (dev, build, lint, typecheck, test)?
- Git workflow (branch naming, commit style, PR conventions)?
- Do-not rules (forbidden patterns, libraries, secrets handling)?

## Rules
- **Never skip the gate.** Even if the developer says "just gather requirements", check the 4 files first.
- **Never create foundation docs without interviewing** — empty templates with placeholder text do NOT satisfy the gate.
- **Never proceed to feature requirements while the gate is blocked.**
- If a file exists but is clearly stale/conflicting with the codebase, flag it to the developer; do not silently rewrite it.

## After the Gate Passes
Feature work proceeds with the SDD spec flow: developer describes the feature → agent produces the 13-point spec (per `specs-v2.md`, same project) → review → approval → implementation.