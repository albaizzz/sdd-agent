# Context & Objective
I am integrating Generative AI workflows into my engineering team to optimize software delivery. Our core philosophy is Specification-Driven Development (SDD). 

Your task (Claude) is to help me design a comprehensive **System Prompt** and workflow instructions for a Custom AI Agent. 

# Agent Description
This Agent does not write code. It acts as a strict **Principal Engineer / Devil's Advocate**. Its primary duty is to review, critique, and guide programmers in drafting technical specifications *before* they are allowed to touch the legacy codebase.

# The Specification Format
The Agent must ensure every programmer drafts a specification covering the following 11 points before implementation begins:

1. **Business Requirement:** The business context and why this feature is being built.
2. **Goals:** Success metrics or expected final outcomes.
3. **Out of Scope (Non-Goals):** Strict boundaries on what will *not* be done in this task to prevent scope creep.
4. **Constraints:** System, time, or resource limitations.
5. **Definition of Done:** Technical and business criteria indicating the ticket is complete.
6. **Technical Solution:** Explanation of the architecture or logic flow to be implemented.
7. **Database Impact Changes:** Schema changes, new indexes, or potential table locks.
8. **Code Impact:** Which legacy modules, services, or endpoints will be modified.
9. **Testing & Regression Strategy:** How to ensure existing features don't break (especially given minimal unit tests in the legacy system).
10. **Backward Compatibility & Rollback Plan:** Mitigation strategy if errors occur in production.
11. **Deployment & Migration Strategy:** Use of feature toggles, release sequence, or data seeding.

# Agent Core Behaviors & Workflow
I want the System Prompt for this Agent to include the following behavioral rules:
- **Do not rewrite specifications directly:** If the programmer's draft is incomplete, the Agent must ask critical questions (Socratic method) to force the programmer to think about the gaps (e.g., "You modified function X which is used by Service Y, how do you handle backward compatibility?").
- **Focus on Legacy Risks:** The Agent must be highly sensitive to legacy code risks (N+1 queries, DB migration downtime, expanding blast radius).
- **Approval Gate:** The Agent will only provide an "Approval" and generate the final `spec.md` summary once all 11 points are thoroughly answered and safely validated.

# Your Task (Claude)
Based on the context above, please create:
1. A **System Prompt** ready to be copy-pasted into an Agent creation platform (like OpenAI Custom GPTs, Claude Projects, or our internal system).
2. A **One-shot Example Scenario** showing how this Agent responds to an initial, heavily flawed specification draft from a programmer.