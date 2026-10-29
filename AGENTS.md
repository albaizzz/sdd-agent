# AGENTS.md — Repository Instructions (SDD)

Read this first. It governs every AI agent (opencode, Claude Code, Codex, GitHub Copilot) working in this repo.

## Specification-Driven Development (MANDATORY)

This project follows **SDD: no code touches the codebase until a technical specification is written, reviewed, and approved by a human.**

### Lifecycle
```
Foundation Gate → Requirements → 13-Point Spec → Review → Human Approval → Task Breakdown → Implementation → Verification → Done
```

1. **Foundation Gate** — `PRD.md`, `DESIGN_SYSTEM.md`, `ARCHITECTURE.md`, `AGENTS.md` must exist with substantive content (also checked in `docs/`). Missing → create them by interviewing the developer, one at a time, ≤3 rounds per file, mark unknowns `assumed — verify`. Templates live in the SDD skill folder (see Reference).
2. **Requirements** — collect feature description, affected area (optional), priority P0/P1/P2, existing draft (optional). If vague, ask ≤3 clarifying questions, then proceed with assumptions.
3. **13-Point Spec** — write `docs/specs/<ticket-id>.md`. Points:
   1 Business Requirement, 2 Goals, 3 Out of Scope, 4 Constraints, 5 Definition of Done, 6 Technical Solution, 6a Security & Compliance, 6b Decision Record, 7 Database Impact, 8 Code Impact (with `file:line`), 9 Testing & Regression, 10 Backward Compatibility & Rollback, 11 Deployment & Migration.
4. **Review (devil's advocate)** — grade every point `Pass / Fail / Insufficient`, ≤3 Socratic rounds, reject → gap report (point, what's missing, the question).
5. **Human Approval** — **the human, not the agent, approves.** AI advises.
6. **Task Breakdown** — write `docs/tasks/<ticket-id>.md`: ordered atomic tasks, dependencies, target files, per-task Definition of Done. Get developer sign-off before coding.
7. **Implementation** — execute tasks one at a time in dependency order. No silent deviation.
8. **Verification** — run spec DoD + tests; report pass/fail per item. Never declare Done with failures.

### Hard Rules
- Never implement without an approved spec. Never self-approve.
- Every codebase claim cites `file:line`. Unverified → `assumed — verify`. Never invent symbols or filenames.
- Spec lifecycle: `Draft → In Review → Approved → Task Breakdown → In Implementation → Deployed → Done`.

## Reference
- Full workflow + interview question sets: the SDD skill at `.opencode/skills/sdd/SKILL.md` (or `.claude/skills/sdd/SKILL.md`).
- Process detail + one-shot example: `specs.md`.
- Templates: `.opencode/skills/sdd/templates/` — `PRD.md`, `DESIGN_SYSTEM.md`, `ARCHITECTURE.md`, `AGENTS.md`, `SPEC.md`, `TASKS.md`.

## Coding SOP
_Filled in by interview when the foundation gate runs. Until then, this file carries only the SDD process rules above._
- Tech stack & versions: `<fill>`
- Build/lint/test/typecheck commands: `<fill>`
- Code style: `<fill>`
- Git workflow: `<fill>`
