# CLAUDE.md — Claude Code Instructions (SDD)

Read this first. If you (Claude) work in this repo, you MUST follow Specification-Driven Development.

## SDD Rules (mandatory)
Same rules as `AGENTS.md` — that file is the canonical instruction doc. Read it and `specs.md` before starting any feature work.

**Core rule: no code touches the codebase until a technical specification is written, reviewed, and approved by a human.**

Lifecycle:
```
Foundation Gate → Requirements → 13-Point Spec → Review → Human Approval → Task Breakdown → Implementation → Verification → Done
```

- Foundation docs: `PRD.md`, `DESIGN_SYSTEM.md`, `ARCHITECTURE.md`, `AGENTS.md` must exist (or be created via interview, ≤3 rounds per file).
- Spec: `docs/specs/<ticket-id>.md` — 13 points, graded `Pass / Fail / Insufficient`.
- Human (not Claude) approves. Never self-approve. Appeal allowed with written rationale.
- Tasks: `docs/tasks/<ticket-id>.md` — ordered, dependencies, per-task DoD. Sign-off before coding.
- Cite `file:line`; unverified → `assumed — verify`. Never invent symbols.
- Never declare Done with verification failures.

## Skill
The full workflow + interview question sets live in the SDD skill: `.claude/skills/sdd/SKILL.md` (templates in `.claude/skills/sdd/templates/`).
Load the skill when the task is feature work, spec drafting/review, or foundation-doc creation.

## Reference
- `specs.md` — 13-point spec detail + Phase A/B behavior + one-shot example.
- `.claude/skills/sdd/templates/SPEC.md` — spec template.

## Coding SOP
_Filled in by the foundation-gate interview. Until then, use the SDD rules above and ask for repo conventions when needed._
- Tech stack & versions: `<fill>`
- Build/lint/test/typecheck commands: `<fill>`
- Code style: `<fill>`
- Git workflow: `<fill>`
