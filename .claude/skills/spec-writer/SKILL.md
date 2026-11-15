---
name: spec-writer
description: >
  Guides a human engineer to write a strong 13-point technical specification (docs/specs/<ticket-id>.md)
  before sdd review. Use when starting a new feature, bugfix, or refactor spec, when a draft spec is
  vague, or when the user says "tulis spec", "draft spec", "bantu spec". Scaffolds the template with
  stable requirement IDs (FR-, NFR-, AC-), interviews the author one section at a time, flags
  ambiguity, and never writes the final prose for the author. Output feeds the sdd review phase.
---

# SKILL: spec-writer

## Core Purpose
Help a human author write a specification that is precise, testable, and traceable. The human is the author. This skill asks questions, checks answers against a quality bar, and scaffolds the file. It does not replace the author's judgment and does not approve the spec. Approval belongs to `sdd` and the human approver.

## When to Run
- Before `sdd` Phase 2 when no draft exists, or when the draft fails the quality bar below.
- Before `sdd` Phase 3 review, to reduce Socratic rounds.

## Step 0 — Gate Check (prerequisite)
Run the Foundation Check from `foundation-gate` (`.opencode/skills/foundation-gate/SKILL.md`, Step 1 and Step 2).
- **PASS** → continue to Step 1.
- **BLOCK** → stop. Do not scaffold or write any spec. Say: *"Spec writing is blocked. Run `foundation-gate` first."* Then list the missing or empty files from the status table.

## Step 1 — Intake
Ask for, in one form:
1. Ticket ID (format: `<PROJECT>-<NUMBER>`, for example `ORD-142`). If none exists, ask the author to create one. Do not invent it.
2. Spec type: `feature | bugfix | refactor | spike`.
3. Priority (`P0 | P1 | P2`) and deadline.
4. One-paragraph description of what and why.
5. Affected area and any existing draft (optional).

If the description is vague, ask at most 3 targeted questions, then continue with `assumed — verify` markers.

## Step 2 — Scaffold
Create `docs/specs/<ticket-id>.md` from `templates/SPEC.md` in this skill folder. Fill only the header and the intake answers. Leave every other section as a guided placeholder. If the file already exists, show the diff and ask before overwriting.

## Step 3 — Guided Interview (one section per round)
Walk the author through the 13 points in order. For each section:
1. Ask the questions listed below.
2. Check the answer against the quality bar.
3. If the answer fails, say what is missing and ask one follow-up question. Maximum 2 follow-ups per section, then mark it `assumed — verify` and move on.
4. Write the author's own words into the section. Keep the author's wording where it is already clear.

### Section questions and quality bar

**1. Business Requirement**
- Q: What problem happens today, who feels it, and what does it cost (time, money, risk)?
- Bar: names a user or system, and a measurable cost. "Users want it" fails.

**2. Goals**
- Q: How will we know this worked, and by how much?
- Bar: each goal has a metric, a baseline, and a target. Assign IDs `G-01`.

**3. Out of Scope**
- Q: What tempting related work is explicitly NOT in this ticket?
- Bar: at least one item. An empty list fails for any feature larger than one endpoint.

**4. Constraints**
- Q: Deadline, team size, compatibility, regulatory, budget, or platform limits?
- Bar: each constraint is specific. "Must be fast" fails.

**5. Definition of Done**
- Q: What observable result proves this is finished?
- Bar: each item is pass/fail and testable. Write as acceptance criteria with IDs `AC-01` in Given/When/Then form.

**6. Technical Solution**
- Q: What is the request/data flow? What are the API request and response shapes and status codes? Any new dependency and why?
- Bar: has a flow sketch (ASCII or Mermaid), at least one example request/response, and an error-status table.

**6a. Security & Compliance**
- Q: Who may call or see this? Does it touch PII or secrets? Any compliance rule?
- Bar: states the authz rule explicitly, or writes `N/A — no security impact.` with a reason.

**6b. Decision Record**
- Q: What alternatives were considered, and why were they rejected?
- Bar: at least two options for any non-trivial decision. Use the form `Option | Pros | Cons | Decision`.

**7. Database Impact**
- Q: Which tables or columns change? Are there new indexes, locks, or backfills? How long is the downtime?
- Bar: names tables and columns. A migration needs steps, idempotency, and a downtime estimate. Write `N/A` if none.

**8. Code Impact**
- Q: Which modules, endpoints, and functions change? Who calls them?
- Bar: every changed symbol has `file:line` and a caller list. Mark unverified claims `assumed — verify`. Do not invent symbols. Use `codebase-impact` when it exists.

**9. Testing & Regression**
- Q: Which tests are new? Which existing behavior must not change? Who signs off?
- Bar: maps each AC-ID to at least one test. Names the regression checklist owner.

**10. Backward Compatibility & Rollback**
- Q: What breaks for existing clients? What metric triggers rollback, and who decides?
- Bar: rollback trigger is numeric (error rate, p95, SLA). Names a decision owner.

**11. Deployment & Migration**
- Q: Feature flag? Ramp plan (for example 1% → 10% → 100%)? What logs or metrics prove it is healthy?
- Bar: each ramp step has a stop condition. At least one observability signal is named.

## Step 4 — Requirement IDs and Traceability
- Functional requirements: `FR-01`, `FR-02`, … Put them in section 1 or 6.
- Non-functional requirements: `NFR-01`, … with a number and unit (for example `p95 < 300 ms at 500 rps`). Write `NFR` in section 4 or 6.
- Acceptance criteria: `AC-01`, … in section 5, each tied to one or more `FR`/`NFR` IDs.
- Every `FR` must have at least one `AC`. Every `AC` must map to a test in section 9.

## Step 5 — Ambiguity Check (run before handing off)
Flag these words unless they have a number or definition: `fast`, `secure`, `scalable`, `user-friendly`, `soon`, `easy`, `robust`, `appropriate`, `etc.`, `as needed`, `and/or`.

Also flag:
- Missing error case for every write operation.
- No empty or null state for list or detail views.
- No permission rule for any new endpoint.
- No owner for an open question.

## Step 6 — Hand-off
1. Run a placeholder check: no `<...>` left in the file, except fields the author marked `TBD` with an owner and date.
2. Write the Open Questions register and Assumptions register at the end of the spec. Each entry has an owner and a due date.
3. Set the header status to `Draft` and say: "Spec draft is ready. Run `sdd` review next. This skill does not approve."

## Rules
- Never write the final prose for the author. Propose wording only when the author asks, and label it as a suggestion.
- Never set status to `Approved`.
- Never invent ticket IDs, symbols, file paths, metrics, or owners.
- Cite `file:line` for every codebase claim, or mark it `assumed — verify`.
- Ask at most 2 follow-up questions per section before marking it `assumed — verify`.
- Keep the 13 section numbers and names exactly as in `specs.md`, so `sdd` review can grade them.

## Reference
- Template: `templates/SPEC.md` (this skill folder)
- 13-point definition: `specs.md`
- Review and approval: `sdd` skill (`.opencode/skills/sdd/SKILL.md`)
