# Task Breakdown: `<TICKET-ID>` — `<FEATURE NAME>`

> Spec: `docs/specs/<ticket-id>.md`
> Status: `Pending Review | Confirmed | In Implementation | Done`
> Owner: `<NAME>` | Updated: `<DATE>`

## Execution Order
Tasks must run in this order (respect dependency graph). Do not start a task until its dependencies are done.

| # | Task ID | Title | Target Files | Depends On | DoD (checkable) | Spec Points |
|---|---------|-------|--------------|-----------|-----------------|-------------|
| 1 | T1 | `<short title>` | `file:line` | — | `<pass/fail criteria>` | 6, 7 |
| 2 | T2 | `<short title>` | `file:line` | T1 | `<pass/fail criteria>` | 6, 8 |
| ... | | | | | | |

## Task Details

### T1 — `<title>`
- **Description:** what is built and how
- **Target files:** `path/to/file.go:line`
- **Depends on:** —
- **Definition of Done:**
  - [ ] `<checkable criterion 1>`
  - [ ] `<checkable criterion 2>`
- **Covered spec points:** 6, 7
- **Verification:** `<command to run>`

### T2 — `<title>`
- **Description:** ...
- **Target files:** `...`
- **Depends on:** T1
- **Definition of Done:**
  - [ ] ...
- **Covered spec points:** ...
- **Verification:** `...`

## Notes / Blockers
- `<any flag, open risk, or blocker; out-of-scope items forbidden by Non-Goals point 3>`
