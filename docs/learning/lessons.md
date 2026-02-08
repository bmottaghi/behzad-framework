# Lessons Learned

**This document captures lessons from past feature deliveries.**

Every feature delivery should add at least one lesson.

**AI must read this before planning new work.**

**Humans should review this periodically to ensure lessons stay relevant.**

---

## Why This Matters

**Without systematic learning:**
- You make the same mistakes repeatedly
- Knowledge lives in people's heads, not documents
- New team members don't benefit from past experience
- Mistakes compound over time

**With systematic learning:**
- Mistakes are documented and prevented
- Knowledge is preserved and shared
- Each feature gets easier
- Quality improves continuously

**This is your continuous improvement system.**

---

## How to Use This Document

### Lesson Structure

```markdown
## Lesson [ID]: [Short Title]

**Date:** YYYY-MM-DD
**Context:** [What was the situation? What feature or task were you working on?]
**What happened:** [What went wrong or right? Be specific.]
**Rule for the future:** [What should you do next time? Actionable advice.]
**Tags:** [tag1, tag2, tag3] (for searchability)
```

### Writing Good Lessons

**Good lessons are:**
- **Specific** - "Add rate limiting to auth endpoints" not "Be careful with security"
- **Actionable** - Clear what to do next time
- **Concise** - 2-5 sentences total
- **Relevant** - Will actually help in future work

**Bad lessons are:**
- **Vague** - "Do better testing"
- **Blame-focused** - "X person made a mistake"
- **Too detailed** - Long paragraphs of implementation details
- **Outdated** - No longer relevant to current system

---

## Active Lessons

These lessons are current and should be applied to new work.

---

### Lesson 001: Always Add Indexes for Foreign Keys

**Date:** 2025-01-15
**Context:** Creating tasks table with user_id foreign key
**What happened:** Forgot to add index on user_id. Query to fetch user's tasks was slow (100ms for 1000 tasks).
**Rule for the future:** When adding a foreign key column, always add an index on that column. Queries filtering by foreign key are common and need indexes.
**Tags:** database, performance, indexes

---

### Lesson 002: Rate Limiting Prevents Abuse

**Date:** 2025-01-15
**Context:** Implementing login endpoint
**What happened:** Initially deployed without rate limiting. Noticed brute force attempts in logs.
**Rule for the future:** All authentication endpoints (login, signup, password reset) must have rate limiting. Use Redis counters, limit to 5 requests per 10 minutes per IP.
**Tags:** security, authentication, rate-limiting

---

### Lesson 003: Validate Password Strength Early

**Date:** 2025-01-15
**Context:** User signup flow
**What happened:** Users could create weak passwords (e.g., "password"), discovered during testing.
**Rule for the future:** Validate password strength on both frontend AND backend. Requirements: min 8 chars, at least one number, at least one special character. Frontend for UX, backend for security.
**Tags:** security, validation, passwords

---

### Lesson 004: Test Database Constraints

**Date:** 2025-01-16
**Context:** User signup
**What happened:** Unique constraint on email worked in PostgreSQL, but error handling was generic and confusing to users.
**Rule for the future:** Test database constraint violations (unique, not null, foreign key). Ensure error messages are user-friendly. Example: "Email already exists" not "Database error 23505".
**Tags:** database, error-handling, testing

---

### Lesson 005: Use Transactions for Multi-Step Operations

**Date:** 2025-01-16
**Context:** Creating user and initial setup data
**What happened:** User was created but initial data insert failed. User existed but in broken state.
**Rule for the future:** When an operation involves multiple database writes that must all succeed or all fail, use a transaction. If any step fails, rollback all changes.
**Tags:** database, transactions, data-integrity

---

### Lesson 006: Mock External Services in Tests

**Date:** 2025-01-17
**Context:** Testing email sending functionality
**What happened:** Integration tests were calling actual SendGrid API, causing tests to fail when offline or quota exceeded.
**Rule for the future:** Always mock external services (email, payment, etc.) in tests. Only test integration with real services in dedicated integration test environment.
**Tags:** testing, mocking, external-services

---

### Lesson 007: Document Environment Variables

**Date:** 2025-01-17
**Context:** Setting up development environment
**What happened:** New developer couldn't run the project because env vars weren't documented.
**Rule for the future:** Maintain a `.env.example` file with all required environment variables (with dummy values). Document what each variable does in README or tech-spine/system-map.md.
**Tags:** documentation, environment, setup

---

### Lesson 008: Log Authentication Failures

**Date:** 2025-01-18
**Context:** Security monitoring
**What happened:** Didn't notice brute force attempts until reviewing code, had no logs.
**Rule for the future:** Log all authentication failures (wrong password, invalid email, rate limit hit) with timestamp and IP. Helps detect attacks and debug issues.
**Tags:** security, logging, authentication

---

### Lesson 009: Frontend Validation ≠ Security

**Date:** 2025-01-18
**Context:** Task creation validation
**What happened:** Frontend validated task title length, but backend didn't. User bypassed frontend validation via API directly.
**Rule for the future:** Always validate on backend, even if frontend validates. Frontend validation is for UX, backend validation is for security and data integrity.
**Tags:** security, validation, frontend, backend

---

### Lesson 010: Keep Migration Files Immutable

**Date:** 2025-01-19
**Context:** Database schema change
**What happened:** Edited an old migration file instead of creating a new one. Broke other developer's database who had already run the old version.
**Rule for the future:** Never edit migration files that have been run in any environment (dev, staging, prod). Always create a new migration file for changes.
**Tags:** database, migrations, process

---

## Deprecated Lessons

These lessons were relevant at one time but are no longer applicable (architecture changed, tech changed, etc.).

Keeping them here for history, but they shouldn't influence new work.

---

### Lesson [DEPRECATED-001]: Use localStorage for Tokens

**Date:** 2025-01-15
**Status:** Deprecated as of 2025-02-01
**Reason:** Switched to httpOnly cookies for better security

**Original Lesson:**
Store JWT tokens in localStorage for easy access from JavaScript.

**Why Deprecated:**
Moved to httpOnly cookies to prevent XSS attacks from stealing tokens. localStorage is no longer used for auth tokens.

---

## How to Add New Lessons

### During Feature Delivery

**AI should propose lessons after feature completion:**
1. Review what happened during implementation
2. Identify what went well or poorly
3. Extract actionable lessons
4. Propose adding them to this document

**User approves or edits lessons before they're added.**

---

### Lesson Writing Process

**Step 1: Identify the lesson**
- What specific thing did you learn?
- Is it actionable and specific?
- Will it help in future work?

**Step 2: Write it clearly**
- Use the template above
- Keep it short (2-5 sentences)
- Make the "Rule for the future" clear and actionable

**Step 3: Tag appropriately**
- Add 2-5 tags for searchability
- Common tags: security, database, testing, frontend, backend, performance, error-handling

**Step 4: Add to Active Lessons**
- Assign next lesson ID
- Add to "Active Lessons" section

---

## How to Use Lessons

### For AI (Before Planning)

**When planning a new feature:**
1. Read all active lessons
2. Filter by relevant tags (e.g., if feature involves auth, read lessons tagged "authentication")
3. Apply rules from lessons to the plan

**Example:**

User wants to add "password reset" feature.

AI reads lessons and finds:
- Lesson 002: Rate limiting on auth endpoints
- Lesson 003: Validate password strength
- Lesson 006: Mock external services (email)
- Lesson 008: Log authentication failures

AI's plan includes:
- Rate limiting on password reset endpoint
- Password validation when setting new password
- Mocked email service in tests
- Logging of password reset attempts

**Lessons prevent repeating mistakes automatically.**

---

### For Humans (Periodic Review)

**Every month or after major milestone:**
1. Read through all active lessons
2. Identify lessons that are no longer relevant
3. Move outdated lessons to "Deprecated Lessons"
4. Ensure remaining lessons are still specific and actionable

**Keep this document clean and useful.**

Too many lessons = noise. Curate actively.

---

## Common Tags

Use these tags for consistency (add new ones as needed):

**Technical Areas:**
- database, frontend, backend, api, devops
- security, authentication, authorization
- testing, performance, caching

**Processes:**
- validation, error-handling, logging, monitoring
- deployment, migrations, environment

**Practices:**
- code-quality, documentation, review

---

## Metrics

### Lesson Application Rate

Track how often lessons prevent mistakes:

**Example:**
- Lesson 002 (rate limiting) applied to 3 subsequent auth features
- Lesson 004 (database constraints) applied to 5 new tables
- Lesson 009 (backend validation) applied to 10 new endpoints

**This proves the learning system is working.**

---

## Anti-Patterns to Avoid

### Don't Write Lessons That Are Too General

**Bad:**
```markdown
## Lesson: Write Good Code

**What happened:** Code was messy
**Rule:** Write cleaner code next time
**Tags:** code-quality
```

**Why Bad:** Not specific, not actionable

---

### Don't Blame People

**Bad:**
```markdown
## Lesson: Developer X Made a Mistake

**What happened:** X forgot to add tests
**Rule:** X should be more careful
```

**Why Bad:** Blame-focused, not systematic

**Good:**
```markdown
## Lesson: Tests Are Part of Definition of Done

**What happened:** Feature was marked complete without tests, bugs appeared in production
**Rule:** No feature is complete without passing tests. Add test checklist to definition of done.
```

---

### Don't Over-Document

**Bad:**
```markdown
## Lesson: How to Implement JWT Auth (50 paragraphs of code)
```

**Why Bad:** This is a tutorial, not a lesson. Lessons are concise rules.

---

## Integration with Other Documents

### Lessons → Execution Plans

When creating execution plan (execution-plan.md):
- AI reads relevant lessons
- Incorporates rules into planned phases
- Prevents repeating documented mistakes

### Lessons → Decision Log

When lessons reveal repeated patterns:
- Consider making an architecture decision
- Add to decision-log.md
- Example: If multiple lessons say "validate on backend", add decision to always use backend validation

### Lessons → Test Strategy

When lessons reveal testing gaps:
- Update test-strategy.md
- Example: Lesson about mocking external services → update test-strategy.md with mocking guidelines

---

## Example: Full Lesson Lifecycle

**Day 1: Feature Delivery**
- Feature implemented
- Noticed that forgot to add index, queries were slow
- AI proposes Lesson 001 about indexes

**Day 2: User Approves**
- User reviews and approves lesson
- Added to this document

**Day 5: New Feature**
- New feature involves foreign key
- AI reads Lesson 001
- AI adds index automatically in plan
- Mistake prevented

**Week 4: Review**
- User reviews lessons
- Lesson 001 still relevant
- Stays in active lessons

**Month 6: Architecture Change**
- Switched from PostgreSQL to DynamoDB (hypothetical)
- Lesson 001 no longer relevant
- Moved to deprecated lessons

**This is continuous learning in action.**

---

## Future Enhancements

**Planned:**
1. **Lesson Search** - Command to search lessons by tag or keyword
2. **Lesson Analytics** - Track how often each lesson is applied
3. **Lesson Suggestions** - AI suggests relevant lessons during planning based on feature description

**Nice to Have:**
1. **Cross-Project Learning** - Share anonymized lessons across multiple projects
2. **Lesson Templates** - Pre-filled templates for common lesson types

---

## How to Update This Document

**When to update:**
- After every feature delivery (add new lessons)
- Monthly (review and deprecate outdated lessons)
- When architecture changes (deprecate relevant lessons)

**What to update:**
- Add new lessons to Active Lessons
- Move outdated lessons to Deprecated Lessons
- Update tags if needed
- Keep lessons concise and actionable

**What NOT to include:**
- Implementation code (that goes in codebase)
- Detailed tutorials (that goes in documentation)
- Temporary notes (that goes in execution plans)

---

## For AI: Reading This Document

**Before planning any feature:**
1. Read all active lessons
2. Filter by relevant tags based on feature description
3. Apply rules to execution plan
4. Reference specific lessons in plan (e.g., "Per Lesson 002, add rate limiting")

**After completing a feature:**
1. Review what happened during implementation
2. Identify learnings (what went well, what didn't)
3. Propose 1-3 new lessons using the template
4. Present to user for approval
5. Add approved lessons to this document

**If a lesson seems outdated:**
- Ask user if it should be deprecated
- Don't ignore lessons without user approval

---

This is your learning truth. Capture lessons. Apply them. Improve continuously.
