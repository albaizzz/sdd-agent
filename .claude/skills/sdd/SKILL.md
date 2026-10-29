---
name: sdd
description: >
  Specification-Driven Development (SDD). Use when starting a new feature/task, gathering
  requirements, drafting/reviewing a technical specification, or when the project may be missing
  its foundation documents (PRD, DESIGN_SYSTEM, ARCHITECTURE, AGENTS). Enforces the full SDD loop:
  foundation gate → requirements → 13-point spec → strict review → human approval → task breakdown
  → implementation → verification against Definition of Done. No code touches the codebase before
  an approved spec.
---

# SKILL: sdd (Specification-Driven Development)

## Core Purpose
Drive every feature through the SDD lifecycle: **no implementation touches the codebase until a technical specification has been written, reviewed, and approved.** This skill gates work behind a project foundation, produces a 13-point spec, reviews it with a devil's-advocate mindset, and only implements after human approval.

## Trigger Keywords
- PRD, DESIGN_SYSTEM, ARCHITECTURE, AGENTS, SDD, specification-driven development
- foundation docs, gathering requirements, new feature, draft spec, spec review, feature ticket, task breakdown, task planning

## The SDD Lifecycle
```
Foundation Gate → Requirements → 13-Point Spec → Review → Human Approval → Task Breakdown → Implementation → Verification → Done
```

## PHASE 0 — Foundation Gate

### Required Files
The target project must contain 4 markdown files with **substantive content**:

| File | Purpose |
|------|---------|
| `PRD.md` | Product/business context — what & why, target users, KPIs |
| `DESIGN_SYSTEM.md` | UI/UX consistency — colors, typography, spacing, components, tokens |
| `ARCHITECTURE.md` | Technical structure — folder layout, data flow, services, DB schema |
| `AGENTS.md` | Coding SOP — tech stack, conventions, commands, rules the AI must obey. Also carries the SDD rules so **any** agent (opencode, Claude Code, Codex, GitHub Copilot) enforces this workflow |

### Step 1 — Foundation Check (always run first)
Search the target project root for the 4 files. Check both `<root>/X.md` and `<root>/docs/X.md`.

Report a status table:

```
PRD.md            ✅ present (2.1 KB)
DESIGN_SYSTEM.md  ❌ missing
ARCHITECTURE.md   ✅ present (3.4 KB)
AGENTS.md         ❌ missing
```

A file counts as present only if it has substantive content (not empty, not a stub with only headers).

### Step 2 — Gate Decision
- **ALL 4 present → PASS.** Proceed to PHASE 1.
- **Any missing/empty → BLOCK.** Say clearly: *"Feature requirements gathering is blocked. Foundation docs incomplete."* Do NOT gather feature requirements or write feature code yet. Go to Step 3.

### Step 3 — Create Missing Foundation Docs (one at a time)
For each missing file, in the order `PRD.md → DESIGN_SYSTEM.md → ARCHITECTURE.md → AGENTS.md`:

1. Interview the developer with the **targeted question set** for that file (below).
2. Ask at most **3 rounds** of questions per file; after that fill gaps with `assumed — verify` markers instead of blocking.
3. Write the file from the matching template in `templates/`, replacing placeholders with the developer's answers.
4. Mark assumptions explicitly.
5. Re-run the Foundation Check. If all 4 present → **PASS** → now proceed to PHASE 1.

If the developer is building a NEW project from scratch, all 4 files will be missing — interview once for each, in order. Gather product answers for `PRD.md` first, because DESIGN_SYSTEM and ARCHITECTURE answers depend on product context.

### Question Sets per File

**PRD.md** (business & feature context)
- What does this product/service do in one sentence?
- Who are the target users, and what problem does it solve for them?
- What are the top 3-5 features/functional areas?
- Business goals & KPIs (success metrics)?
- Who are the stakeholders? Any constraints (regulation, market)?
- Current state: greenfield or replacing/evolving an existing product?
- Non-goals for this product version?

**DESIGN_SYSTEM.md** (UI consistency)
- Platform target (web/mobile/desktop) and UI framework (React/Tailwind/Flutter/…)?
- Primary brand color(s) + hex values? Semantic tokens (success/warning/error/info)?
- Typography: font families, scale (sizes/weights), line-height?
- Spacing & radius scale (grid unit, 4px/8px base)?
- Core components list (buttons, inputs, cards, modals, tables…)?
- Dark mode / accessibility requirements (contrast, focus states)?
- Existing design tool (Figma) or UI library reference?

**ARCHITECTURE.md** (structure & data flow)
- Monolith or microservices? Main languages/frameworks?
- Folder/module structure — top-level layout?
- Data flow: request lifecycle from client → API → service → DB?
- Services/components and how they communicate (sync/REST/gRPC/events)?
- Database(s): type, schema naming, migrations approach?
- External dependencies (third-party APIs, message brokers, cache)?
- Deployment target (cloud/on-prem, container/CI-CD)?

**AGENTS.md** (coding SOP)
- Tech stack & versions (language, framework, package manager)?
- Project structure conventions (folders, naming, file organization)?
- Code style rules (lint, formatting, types, error handling)?
- Test commands & testing conventions (unit/e2e)?
- Build/run commands (dev, build, lint, typecheck, test)?
- Git workflow (branch naming, commit style, PR conventions)?
- Do-not rules (forbidden patterns, libraries, secrets handling)?

## PHASE 1 — Feature Requirements (Input Contract)
The developer supplies:
1. **Feature/Ticket Description** — what is being built and why.
2. **Affected Area (optional)** — module/service/endpoint names they suspect are involved.
3. **Priority** — P0/P1/P2 and any deadline.
4. **Existing Draft Spec (optional)** — a prior draft the agent should critique rather than start from scratch.

If the description is too vague to start, ask up to **3 targeted clarifying questions**, then proceed with clearly-marked assumptions. Never block on the absence of a draft — produce one.

## PHASE 2 — Draft the 13-Point Spec
Create `docs/specs/<ticket-id>.md` from the 13-point structure below (template in `templates/SPEC.md`). Write it in the agent's own words, citing the codebase:

1. **Business Requirement** — context and why this feature is built.
2. **Goals** — success metrics / expected outcomes.
3. **Out of Scope (Non-Goals)** — strict boundaries to prevent scope creep.
4. **Constraints** — system, time, or resource limitations.
5. **Definition of Done** — checkable pass/fail criteria (not vague).
6. **Technical Solution** — architecture/flow sketch, API contracts (request/response shape, status codes), new dependencies.
6a. **Security & Compliance** — authz/authn impact, PII handling, secrets. If N/A, state explicitly *"N/A — no security impact."*
6b. **Decision Record** — alternatives considered & why rejected.
7. **Database Impact Changes** — schema changes, indexes, table locks, migration steps + idempotency + downtime window.
8. **Code Impact** — modules/services/endpoints modified, with `file:line` references. Include blast radius — every caller of modified functions.
9. **Testing & Regression Strategy** — how existing features stay unbroken; contract tests, smoke/manual regression checklist, sign-off owner.
10. **Backward Compatibility & Rollback Plan** — trigger criteria for rollback (error rate / p95 / SLA), who decides, partial-failure handling.
11. **Deployment & Migration Strategy** — feature toggles, release sequence, canary/ramp %, data seeding; **observability signals** validating a healthy deployment.

## PHASE 3 — Spec Review (Phase A: Devil's Advocate)
- **Do not rewrite the spec directly.** Ask critical questions (Socratic method) to force the developer to close gaps. Example: *"You modified function X, called by Service Y. How do you handle backward compatibility for Y?"*
- **Focus on legacy risks:** N+1 queries, DB migration downtime, expanding blast radius, hidden callers.
- **Iteration cap:** max **3 Socratic rounds**. After that, stop asking and provide fillable hints/placeholders so the draft can progress.
- **Grade every point** `Pass / Fail / Insufficient`.
- **Approved** only when: all 13 points **Pass**, no **Open Risk** flagged, AND the human approver confirms.
- **Rejected** specs return a gap report: point number, what is missing, the question the developer must answer.

## PHASE 4 — Human Approval Gate
- **AI advises, humans decide.** The agent never unilaterally approves or blocks. The human approver (tech lead/reviewer) has final authority.
- If the agent rejects or approves incorrectly, the developer may **appeal** with a written rationale; a human reviews and overrides.

## PHASE 4.5 — Task Breakdown (only after Approval)
Break the approved spec into a small, ordered, testable task list. The developer reviews and can adjust it before implementation starts.

Create `docs/tasks/<ticket-id>.md` from the template (`templates/TASKS.md`):
1. **Read the approved spec** point 6 (Technical Solution) and point 8 (Code Impact) — these define the work surface.
2. Decompose the work into atomic tasks (each a single PR-sized chunk: schema migration, service method, endpoint, test, migration script).
3. For each task record: **id, title, description, target files** (`file:line`), **dependencies** (which tasks must finish first), **Definition of Done** (checkable), and **spec points covered**.
4. Order tasks respecting dependency graph — DB-layer first, service second, API third, UI/tests last.
5. Flag tasks that are blocking/blocked; no task may depend on one that is out of scope (Non-Goals, point 3).
6. Present the plan to the developer for confirmation before Phase 5. Adjustments expected; do not start coding until the developer says go.

## PHASE 5 — Implementation (Phase B, only after Approval)
- Execute tasks **one at a time, in dependency order** from the task list; do not jump ahead.
- Complete one task's DoD before starting the next.
- Generate code strictly within the spec's scope — respect Non-Goals (point 3).
- Deliver: changed files with `file:line`, a summary of changes per spec point, and verification steps (commands, tests).
- **No silent deviation.** Mark any deviation from the spec explicitly; deviations require re-approval.
- Provide traceability: link spec → tasks → PR → deploy.

## PHASE 6 — Verification
- Run the DoD checks from point 5; run the tests from point 9; run the per-task DoD from the task list.
- Report pass/fail per Definition of Done item. If any fail, fix or re-escalate to the approver — do not declare Done.

## Spec Lifecycle & Traceability
- `Draft → In Review → Approved → Task Breakdown → In Implementation → Deployed → Done`
- Tracked in the spec file header under `docs/specs/<ticket-id>.md` (version-controlled).
- A complete feature delivers: spec.md, task list, implementation PR(s) linking ticket + spec, verification result.

## Process Metrics (to measure SDD effectiveness)
Track per ticket: **time to spec**, **socratic rounds used**, **rework rate** (PRs rejected for reasons the spec should have caught), **defect leak** (production incidents traceable to a spec gap).

## Codebase Awareness Rules
- Prefer **targeted reads** over full-codebase scans to protect context budget: start from entry-point/index files and the developer's module pointers, then follow the call graph outward.
- **Every claim about the codebase must cite `file:line`.** If a symbol cannot be verified, mark it `assumed — verify`; never invent module/function names.
- Flag unknown or deprecated areas rather than guessing.

## Rules
- **Never skip the gate.** Even if the developer says "just gather requirements", check the 4 files first.
- **Never create foundation docs without interviewing** — empty templates with placeholder text do NOT satisfy the gate.
- **Never proceed to feature requirements while the gate is blocked.**
- **Never implement without an approved spec.** Phase B requires approval.
- **Never start coding without a confirmed task plan.** Get developer sign-off on the task list first.
- If a file exists but is clearly stale/conflicting with the codebase, flag it to the developer; do not silently rewrite it.

## Multi-Agent Support
This skill works across agent tools. Each tool loads SDD instructions via its own mechanism, all pointing at the same workflow:

| Tool | Entry point | Skill location |
|------|-------------|----------------|
| opencode | `AGENTS.md` + skill frontmatter | `.opencode/skills/sdd/SKILL.md` |
| Claude Code | `CLAUDE.md` + skill | `.claude/skills/sdd/SKILL.md` |
| Codex | `AGENTS.md` | skill folder (same workflow) |
| GitHub Copilot | `.github/copilot-instructions.md` + `AGENTS.md` | skill folder (same workflow) |

Ensure the generated `AGENTS.md` (foundation doc) always keeps its SDD rules section — that is what makes the gate machine-readable by any agent.