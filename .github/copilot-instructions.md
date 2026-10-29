# Copilot Instructions — Specification-Driven Development

This repository follows **Specification-Driven Development (SDD)**. GitHub Copilot (chat, edit, and code review) MUST follow these rules.

## Hard Rule
**No code touches the codebase until a technical specification is written, reviewed, and approved by a human.** Never write implementation code, migrations, or test scaffolding before an approved spec exists.

## Lifecycle
```
Foundation Gate → Requirements → 13-Point Spec → Review → Human Approval → Task Breakdown → Implementation → Verification → Done
```

1. **Foundation Gate** — `PRD.md`, `DESIGN_SYSTEM.md`, `ARCHITECTURE.md`, `AGENTS.md` must exist with substantive content. Missing → help create via interview (≤3 rounds per file, mark unknowns `assumed — verify`).
2. **Requirements** — collect feature description, affected area, priority (P0/P1/P2), existing draft.
3. **13-Point Spec** — `docs/specs/<ticket-id>.md` (Business Requirement, Goals, Out of Scope, Constraints, Definition of Done, Technical Solution, Security & Compliance, Decision Record, Database Impact, Code Impact with `file:line`, Testing & Regression, Backward Compatibility & Rollback, Deployment & Migration).
4. **Review** — flag gaps in the draft (devil's advocate). Human approves — Copilot never self-approves.
5. **Task Breakdown** — `docs/tasks/<ticket-id>.md`: ordered tasks, dependencies, target files, per-task DoD.
6. **Implementation & Verification** — code within spec scope, cite `file:line`, verify against DoD.

## Behavior Rules
- Suggest the **spec process itself** when asked to implement directly without one — point to `specs.md` and the SDD skill.
- Cite `file:line` for any codebase claim; unverified → `assumed — verify`. Never invent symbols.
- Do not silently deviate from the approved spec. Flag deviations for re-approval.
- Review PRs against the spec's Definition of Done, not just the code diff.

## Reference
- Full workflow: `AGENTS.md`, `specs.md`.
- Skill + templates: `.opencode/skills/sdd/` and `.claude/skills/sdd/` — `templates/SPEC.md`, `templates/TASKS.md`, `templates/PRD.md`, etc.
