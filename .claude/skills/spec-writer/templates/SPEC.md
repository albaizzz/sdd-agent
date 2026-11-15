# Spec: `<TICKET-ID>` — `<FEATURE NAME>`

> Type: `feature | bugfix | refactor | spike`
> Status: `Draft | In Review | Approved | In Implementation | Deployed | Done`
> Author: `<NAME>`
> Priority: `<P0 | P1 | P2>` | Deadline: `<DATE>`
> Updated: `<DATE>`

## 1. Business Requirement
Problem today, who feels it, and its cost (time, money, risk).

**Functional requirements**

| ID | Requirement | Traces to (section 5) |
|----|-------------|------------------------|
| FR-01 | `<what the system must do>` | AC-01 |

## 2. Goals
| ID | Goal | Metric | Baseline | Target |
|----|------|--------|----------|--------|
| G-01 | `<goal>` | `<metric>` | `<value>` | `<value + unit>` |

## 3. Out of Scope (Non-Goals)
- `<item explicitly not in this ticket>`

## 4. Constraints
- `<deadline, compatibility, regulatory, platform limits>`

**Non-functional requirements**

| ID | Category | Requirement with number and unit |
|----|----------|----------------------------------|
| NFR-01 | Performance | `p95 < <N> ms at <N> rps` |
| NFR-02 | Availability | `<N>% monthly` |

## 5. Definition of Done (Acceptance Criteria)

| ID | Given | When | Then | Traces to |
|----|-------|------|------|-----------|
| AC-01 | `<precondition>` | `<action>` | `<observable result>` | FR-01 |

## 6. Technical Solution
- Flow sketch (ASCII or Mermaid):
- Request / response example:
- Error status table:

| Status | Condition | Response body |
|--------|-----------|---------------|
| 400 | `<condition>` | `<shape>` |

- New dependencies (with justification):

### 6a. Security & Compliance
- Authz rule: `<who may call or see this>`
- PII / secrets:
- Compliance:
- Or: `N/A — no security impact.` (reason: `<reason>`)

### 6b. Decision Record

| Option | Pros | Cons | Decision |
|--------|------|------|----------|
| `<A>` | | | Chosen / Rejected because `<reason>` |
| `<B>` | | | Chosen / Rejected because `<reason>` |

## 7. Database Impact
- Tables / columns changed:
- Indexes and locks:
- Migration steps, idempotency, downtime estimate:
- Or: `N/A`

## 8. Code Impact

| Symbol / endpoint | `file:line` | Change | Callers (`file:line`) |
|-------------------|-------------|--------|------------------------|
| `<name>` | `<path:line>` | `<change>` | `<path:line>` |

Unverified claims are marked `assumed — verify`.

## 9. Testing & Regression Strategy

| AC / FR | Test (type + location) | Owner |
|---------|-------------------------|-------|
| AC-01 | `<unit / contract / e2e>` `<path>` | `<NAME>` |

- Regression checklist (existing behavior that must not change):
- Sign-off owner:

## 10. Backward Compatibility & Rollback
- Breaking changes for existing clients:
- Rollback trigger: `<metric> > <threshold> for <duration>`
- Decision owner:
- Partial-failure handling:

## 11. Deployment & Migration
- Feature flag:
- Ramp plan: `1% → 10% → 100%`, stop condition per step:
- Observability signals (logs, metrics, dashboards):

---

## Open Questions

| ID | Question | Owner | Due |
|----|----------|-------|-----|
| Q-01 | `<question>` | `<NAME>` | `<DATE>` |

## Assumptions

| ID | Assumption | Verify by | Status |
|----|------------|-----------|--------|
| A-01 | `<assumption>` | `<NAME / DATE>` | `assumed — verify` |

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

**Open Risks:** `<none or list>`
**Approved by:** `<NAME>` | Date: `<DATE>`
