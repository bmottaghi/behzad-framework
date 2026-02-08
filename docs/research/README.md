# Research

**This folder contains external research that should influence feature planning and implementation.**

When you have deep research about a technology, pattern, or approach, place it here.

**AI treats files in this folder as mandatory context when told to.**

---

## What Goes Here

### Good Candidates for Research Files

**Technical Research:**
- Comparison of libraries or frameworks (e.g., "JWT vs Session Cookies.md")
- API documentation for third-party services (e.g., "Stripe API Guide.md")
- Security best practices for specific features (e.g., "Password Reset Security.md")
- Performance analysis or benchmarks (e.g., "PostgreSQL Query Optimization.md")
- Design patterns for complex features (e.g., "Real-time Updates Patterns.md")

**Product Research:**
- User research findings
- Competitor analysis
- Market research
- Usability studies

**Architectural Research:**
- Evaluation of architectural approaches
- Scalability analysis
- Infrastructure research

---

## What Does NOT Go Here

**Don't put these in research:**
- Implementation code (goes in codebase)
- Live documentation (goes in tech-spine/ or product-system.md)
- Lessons learned (goes in docs/learning/lessons.md)
- Temporary notes (goes in execution plans or comments)

**Research is for deep, reusable knowledge** that informs decisions but isn't part of the system itself.

---

## How to Structure Research Files

### File Naming

Use descriptive, specific names:

**Good:**
- `authentication-strategies-comparison.md`
- `stripe-payment-integration-guide.md`
- `database-indexing-best-practices.md`

**Bad:**
- `research.md` (too generic)
- `notes.md` (not descriptive)
- `stuff.md` (unclear)

---

### File Template

```markdown
# [Research Topic]

**Date:** YYYY-MM-DD
**Author:** [Who did this research]
**Status:** Active | Archived | Superseded
**Relevant to:** [Which features or decisions this impacts]

---

## Summary

[2-3 sentence summary of key findings]

---

## Context

[Why was this research done? What problem are we solving?]

---

## Key Findings

1. [Finding 1]
2. [Finding 2]
3. [Finding 3]

---

## Recommendations

[What should we do based on this research?]

---

## Details

[In-depth analysis, comparisons, benchmarks, etc.]

---

## Sources

- [Link to external docs]
- [Link to article]
- [Link to tutorial]

---

## Related Decisions

- Links to decision-log.md entries that used this research

---
```

---

## How Research Works in the Framework

### 1. You Create Research File

You find or create deep research about a topic (e.g., OAuth2 best practices).

You save it in `docs/research/oauth2-implementation-guide.md`.

---

### 2. You Reference Research During Feature Planning

When starting a feature that needs this research:

**You tell AI:**
```
I want to implement OAuth2 authentication.
Review docs/research/oauth2-implementation-guide.md before planning.
```

**AI then:**
1. Reads the research file
2. Uses findings to inform the plan
3. Ensures plan aligns with research recommendations
4. Asks clarifying questions if research conflicts with current architecture

---

### 3. AI Treats Research as Mandatory Context

Unlike code documentation (which can drift), research files are **explicit knowledge injection**.

**AI must:**
- Read research files when told to
- Incorporate findings into plans
- Surface conflicts clearly if research contradicts current system
- Ask questions if research is unclear or incomplete

---

## Example Research Files

### Example 1: Authentication Strategy

**File:** `docs/research/authentication-strategies-comparison.md`

```markdown
# Authentication Strategies Comparison

**Date:** 2025-01-10
**Author:** Technical Lead
**Status:** Active
**Relevant to:** User authentication features

---

## Summary

Evaluated JWT, session cookies, and OAuth2 for our authentication needs.
JWT is simplest for MVP, but session cookies are more secure long-term.
OAuth2 adds complexity we don't need yet.

---

## Context

Choosing authentication strategy for MVP. Need to support:
- User login/signup
- Stateless API (for horizontal scaling)
- Frontend SPA (React)
- Security best practices

---

## Options Evaluated

### Option 1: JWT (JSON Web Tokens)

**Pros:**
- Stateless (no server-side storage needed)
- Works great with SPAs
- Industry standard
- Easy to implement

**Cons:**
- Can't revoke tokens (until expiration)
- Token size larger than session ID
- Vulnerable to XSS if stored in localStorage

**Use Case:** Best for stateless APIs, short-lived tokens

---

### Option 2: Session Cookies

**Pros:**
- Can revoke sessions instantly
- Smaller size (just session ID)
- More secure (httpOnly cookies prevent XSS)

**Cons:**
- Requires session storage (Redis or database)
- Harder to scale horizontally
- CSRF protection needed

**Use Case:** Best for traditional web apps, long-lived sessions

---

### Option 3: OAuth2 (Third-party)

**Pros:**
- Offloads auth to provider
- Users don't need new password
- Handles password resets, 2FA, etc.

**Cons:**
- Vendor dependency
- More complex setup
- Less control over user experience

**Use Case:** Best when users already have accounts elsewhere (Google, GitHub)

---

## Recommendations

**For MVP:**
- Use JWT for simplicity
- Store in localStorage (accept XSS risk for MVP)
- 30-day expiration
- Add session tracking later if needed

**Post-MVP:**
- Migrate to httpOnly cookies
- Add session storage (Redis)
- Enable session revocation
- Consider OAuth2 for social login

---

## Security Considerations

1. **Token Storage:** localStorage is vulnerable to XSS. Sanitize all user input.
2. **Token Expiration:** 30 days balances UX and security for MVP.
3. **HTTPS Only:** Tokens must only be sent over HTTPS.
4. **Rate Limiting:** Auth endpoints must have rate limiting to prevent brute force.

---

## Implementation Notes

**Libraries:**
- `jsonwebtoken` for JWT generation/validation
- `bcrypt` for password hashing

**Token Payload:**
```json
{
  "userId": "uuid",
  "email": "user@example.com",
  "iat": 1234567890,
  "exp": 1234567890
}
```

---

## Sources

- [JWT.io](https://jwt.io/)
- [OWASP Authentication Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html)
- [Session vs Token Authentication](https://example.com/article)

---

## Related Decisions

- Decision 002: Use JWT for Authentication (decision-log.md)

---
```

---

### Example 2: Database Indexing

**File:** `docs/research/database-indexing-best-practices.md`

```markdown
# Database Indexing Best Practices

**Date:** 2025-01-12
**Author:** Technical Lead
**Status:** Active
**Relevant to:** Database performance, schema design

---

## Summary

Indexes dramatically improve query performance but have trade-offs.
Always index foreign keys and columns used in WHERE clauses.
Avoid over-indexing (slows down writes).

---

## Key Findings

1. **Indexes speed up reads, slow down writes**
   - Each index must be updated on INSERT/UPDATE/DELETE
   - Balance is key

2. **Always index these:**
   - Primary keys (automatic in PostgreSQL)
   - Foreign keys (queries often filter by parent)
   - Columns used in WHERE clauses frequently
   - Columns used in JOIN conditions

3. **Consider indexing these:**
   - Columns used in ORDER BY frequently
   - Columns with high cardinality (many unique values)

4. **Don't index these:**
   - Columns with low cardinality (e.g., boolean, status with 3 values)
   - Columns rarely queried
   - Very large columns (TEXT, BLOB)

---

## Recommendations

**For Our System:**

1. **Foreign Keys:** Always add index
   - `user_id` in tasks table → `idx_tasks_user_id`

2. **Common Queries:** Index columns in WHERE clauses
   - If we query `WHERE email = ?` → index email
   - If we query `WHERE is_completed = ?` AND `due_date` → composite index

3. **Naming Convention:**
   - `idx_{table}_{column}`
   - Example: `idx_users_email`, `idx_tasks_user_id`

4. **Monitor Performance:**
   - Use `EXPLAIN ANALYZE` to verify indexes are used
   - Remove unused indexes

---

## Examples

### Good Index Usage

```sql
-- Tasks belong to users, we query by user_id often
CREATE INDEX idx_tasks_user_id ON tasks(user_id);

-- We query tasks by email for login
CREATE INDEX idx_users_email ON users(email);
```

### Composite Index (Multiple Columns)

```sql
-- We often query: WHERE user_id = ? AND is_completed = ?
CREATE INDEX idx_tasks_user_completed ON tasks(user_id, is_completed);
```

### Partial Index (Conditional)

```sql
-- We only query incomplete tasks often
CREATE INDEX idx_tasks_incomplete ON tasks(user_id) WHERE is_completed = false;
```

---

## Trade-offs

**Storage:** Each index uses disk space (~10-20% of table size typically)

**Write Performance:** Each index slows down writes slightly

**Read Performance:** Queries can be 10-100x faster with right indexes

**Our Scale:** At MVP scale (< 10,000 tasks), indexes matter less, but good habits prevent problems later.

---

## Sources

- [Use The Index, Luke](https://use-the-index-luke.com/)
- [PostgreSQL Index Types](https://www.postgresql.org/docs/current/indexes-types.html)

---

## Related Lessons

- Lesson 001: Always Add Indexes for Foreign Keys

---
```

---

## Using Research in Practice

### Scenario 1: Planning a New Feature

**User:** "I want to add real-time notifications."

**AI:**
1. Checks if research exists: `docs/research/realtime-notifications.md`
2. If exists: Reads it, incorporates into plan
3. If not exists: Asks user if research should be done first

**User can say:**
- "Yes, research WebSockets vs Server-Sent Events first" → AI creates research file
- "No, just use WebSockets" → AI proceeds without research

---

### Scenario 2: Research Conflicts with Current Architecture

**Research says:** "Use PostgreSQL for transactions"

**Current system:** Uses MongoDB

**AI:**
1. Reads research
2. Detects conflict
3. Asks user: "Research recommends PostgreSQL, but we use MongoDB. Should we proceed with MongoDB or reconsider?"

**AI doesn't ignore research. It surfaces conflicts.**

---

### Scenario 3: Research is Outdated

**Research from 2023** says use Library X.

**Library X is deprecated** in 2025.

**User notices during review:**
- User marks research file as `Status: Archived`
- User creates new research with updated recommendations

**Research files have lifecycle.**

---

## Research Lifecycle

### 1. Creation

You or AI creates research file based on deep investigation.

### 2. Active Use

Research informs feature planning and implementation.

### 3. Update

As technology evolves, research is updated or superseded.

### 4. Archival

When research is no longer relevant (tech changed, architecture changed), mark as `Status: Archived`.

**Don't delete archived research.** It provides historical context.

---

## Tips for Good Research

### Be Specific

**Bad:**
```markdown
# Authentication

There are many ways to do auth.
```

**Good:**
```markdown
# JWT vs Session Cookies for SPA Authentication

For single-page applications with stateless APIs:
- JWT: Simple, stateless, can't revoke
- Session Cookies: More secure, requires session storage
- Recommendation: JWT for MVP, migrate to cookies later
```

---

### Include Sources

Always link to:
- Official documentation
- Articles or tutorials you found helpful
- Benchmarks or comparisons

This allows future you (or others) to verify and expand research.

---

### Keep it Current

**Add date and status** to every research file.

Review periodically and update or archive as needed.

---

## Common Research Topics

**Authentication & Security:**
- Password hashing strategies
- OAuth2 flows
- API security patterns
- HTTPS configuration

**Database & Performance:**
- Indexing strategies
- Query optimization
- Caching approaches
- Database scaling

**Frontend:**
- State management patterns
- Performance optimization
- Accessibility guidelines
- UI framework comparisons

**DevOps:**
- Deployment strategies
- CI/CD best practices
- Monitoring and logging
- Infrastructure as code

---

## Integration with Other Documents

### Research → Decision Log

When research leads to a decision:
1. Make the decision
2. Log it in decision-log.md
3. Reference the research file

**Example:**
```markdown
## Decision 002: Use JWT for Authentication

...
### Context
Based on research in docs/research/authentication-strategies-comparison.md,
we need to choose between JWT, session cookies, and OAuth2.
...
```

---

### Research → Execution Plans

When planning a feature that requires research:
1. AI reads relevant research files
2. AI incorporates findings into execution plan
3. AI references research in plan

**Example in execution-plan.md:**
```markdown
## Phase 2: Implement Authentication

Based on docs/research/authentication-strategies-comparison.md:
- Using JWT for stateless auth
- Storing in localStorage for MVP (will migrate to httpOnly cookies post-MVP)
- 30-day expiration
```

---

## For AI: Reading Research

**When user says "review docs/research/{file}.md":**
1. Read the entire research file
2. Understand the summary and recommendations
3. Incorporate findings into your plan
4. If research conflicts with current system, surface the conflict
5. Reference the research in your plan (e.g., "Per authentication research, using JWT")

**If research is unclear:**
- Ask clarifying questions
- Don't make assumptions

**If research is missing:**
- Ask if research should be done first
- Offer to help create research file if user wants

---

## Example: Full Research Lifecycle

**Week 1:**
- User researches OAuth2 strategies
- Creates `docs/research/oauth2-guide.md`
- Status: Active

**Week 2:**
- Planning "User Login" feature
- AI reads oauth2-guide.md
- AI incorporates OAuth2 best practices into plan

**Month 3:**
- Architecture changes from OAuth2 to custom JWT
- Research file marked `Status: Archived`
- New research file created: `jwt-implementation-guide.md`

**Month 6:**
- New feature needs OAuth2 again (for third-party integration)
- Read archived oauth2-guide.md for context
- Create new research specific to integration use case

**Research files preserve knowledge even when not actively used.**

---

## Quick Reference

**When to create research:**
- Deep investigation needed before decision
- Comparing multiple approaches
- Learning new technology or pattern
- Documenting external API or library

**When to read research:**
- Planning features related to researched topic
- Making architectural decisions
- Onboarding new team members
- Revisiting old decisions

**When to update research:**
- New information discovered
- Technology evolved
- Recommendations changed

**When to archive research:**
- No longer relevant to current system
- Superseded by newer research
- Architecture changed fundamentally

---

This folder is your knowledge base. Use it. Trust it. Keep it current.
