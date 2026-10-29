# Spec: `<TICKET-ID>` — `<FEATURE NAME>`

> Status: `Draft | In Review | Approved | In Implementation | Deployed | Done`
> Author: `<NAME>`
> Priority: `<P0 | P1 | P2>` | Deadline: `<DATE>`
> Updated: `<DATE>`

## 1. Business Requirement
Why is this feature being built? Business context.

## 2. Goals
Success metrics / expected final outcomes (measurable).

## 3. Out of Scope (Non-Goals)
What will NOT be done in this task — strict boundaries to prevent scope creep.

## 4. Constraints
System, time, or resource limitations.

## 5. Definition of Done
Checkable pass/fail criteria (not vague). Every item must be verifiable.

## 6. Technical Solution
- Architecture / data-flow sketch (ASCII or Mermaid)
- API contracts: request/response shape, status codes
- New dependencies (with justification)

### 6a. Security & Compliance
Authz/authn impact, PII handling, secrets management, compliance.
If not applicable: `N/A — no security impact.`

### 6b. Decision Record
Alternatives considered and why they were rejected (preserves the "why").

## 7. Database Impact Changes
Schema changes, new indexes, potential table locks.
If migration/backfill required: steps, idempotency, estimated downtime window.

## 8. Code Impact
Modules/services/endpoints modified, with `file:line` references.
Include blast radius — every caller of modified functions.

## 9. Testing & Regression Strategy
How existing features stay unbroken. Contract tests, smoke/manual regression checklist, who signs off.

## 10. Backward Compatibility & Rollback Plan
- Trigger criteria for rollback (error rate / p95 / SLA thresholds)
- Who decides, partial-failure handling

## 11. Deployment & Migration Strategy
Feature toggles, release sequence, canary/ramp percentages, data seeding.
Observability signals (logs, metrics) that validate a healthy deployment.

---
## Review Record
| Point | Grade (Pass/Fail/Insufficient) | Notes |
|-------|--------------------------------|-------|
| 1 | | |
| 2 | | |
| 3 | | |
| 4 | | |
| 5 | | |
| 6 | | |
| 6a | | |
| 6b | | |
| 7 | | |
| 8 | | |
| 9 | | |
| 10 | | |
| 11 | | |

**Open Risks:** <none or list>
**Approved by:** `<NAME>` | Date: `<DATE>`