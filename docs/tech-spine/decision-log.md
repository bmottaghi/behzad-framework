# Decision Log

**This document captures major technical decisions and their rationale.**

This is an Architecture Decision Record (ADR) system.

**Why this matters:**
- Future you will understand why decisions were made
- AI can learn from past decisions
- New team members can understand context
- Prevents revisiting settled decisions

**Keep this updated.** Every significant technical decision should be recorded here.

---

## How to Use This Document

### Decision Template

```markdown
## Decision [ID]: [Short Title]

**Date:** YYYY-MM-DD
**Status:** Accepted | Rejected | Deprecated | Superseded
**Deciders:** [Who made this decision]
**Tags:** [relevant tags for searchability]

### Context

[What is the situation? What problem are we solving?]

### Options Considered

**Option 1: [Name]**
- Pros: [Benefits]
- Cons: [Drawbacks]

**Option 2: [Name]**
- Pros: [Benefits]
- Cons: [Drawbacks]

### Decision

[What was chosen and why?]

### Consequences

**Positive:**
- [Good outcomes]

**Negative:**
- [Trade-offs or limitations]

**Neutral:**
- [Other implications]

### Related Decisions

- Links to related ADRs
```

---

## Active Decisions

### Decision 001: Use PostgreSQL for Primary Database

**Date:** 2025-01-10
**Status:** Accepted
**Deciders:** Technical Lead
**Tags:** database, architecture, backend

#### Context

Need to choose a database for storing user and task data.

Requirements:
- Reliable data persistence
- ACID compliance (for user accounts and tasks)
- Good query performance
- Mature ecosystem
- Easy to host (AWS RDS available)

#### Options Considered

**Option 1: PostgreSQL**
- Pros:
  - ACID compliant
  - Excellent JSON support (for future flexibility)
  - Mature, battle-tested
  - AWS RDS support
  - Great tooling and community
  - Scales well for our size
- Cons:
  - Slightly more complex than simpler databases
  - Requires schema management

**Option 2: MongoDB**
- Pros:
  - Schemaless (flexible)
  - Good for rapid prototyping
  - JSON-native
- Cons:
  - Not ACID compliant by default
  - Overkill for our simple relational data
  - Less mature tooling for Node.js

**Option 3: MySQL**
- Pros:
  - Simple, well-known
  - AWS RDS support
- Cons:
  - Less advanced features than PostgreSQL
  - Weaker JSON support

#### Decision

**Chose PostgreSQL.**

**Rationale:**
- Our data is relational (users → tasks)
- ACID compliance important for user accounts
- PostgreSQL's JSON support gives flexibility without going schemaless
- AWS RDS makes hosting simple
- Team has experience with it

#### Consequences

**Positive:**
- Strong data integrity guarantees
- Excellent query performance for our use case
- Easy to add complex queries later if needed

**Negative:**
- Requires migration management
- Schema changes need careful planning

**Neutral:**
- Need to learn PostgreSQL-specific features (vs generic SQL)

#### Related Decisions
- Decision 003: Use pg library for database access

---

### Decision 002: Use JWT for Authentication

**Date:** 2025-01-12
**Status:** Accepted
**Deciders:** Technical Lead
**Tags:** authentication, security, backend

#### Context

Need to implement user authentication and session management.

Requirements:
- Secure authentication
- Stateless (to enable horizontal scaling)
- Works with frontend SPA
- Industry-standard approach

#### Options Considered

**Option 1: JWT (JSON Web Tokens)**
- Pros:
  - Stateless (no server-side session storage needed initially)
  - Works great with SPAs
  - Industry standard
  - Can include claims (userId, email, etc.)
  - Easy to validate
- Cons:
  - Can't revoke tokens (until expiration)
  - Token size larger than session ID

**Option 2: Session Cookies**
- Pros:
  - Simple to implement
  - Easy to revoke sessions
  - Smaller size (just session ID)
- Cons:
  - Requires session storage (Redis or database)
  - Harder to scale horizontally
  - Less suitable for API-first architecture

**Option 3: OAuth2 (third-party)**
- Pros:
  - Offloads auth to provider (Google, GitHub)
  - Users don't need new password
- Cons:
  - Vendor dependency
  - More complex setup
  - Doesn't fit "simple" principle for MVP

#### Decision

**Chose JWT for MVP.**

**Rationale:**
- Stateless fits our architecture
- Works perfectly with React SPA
- Can add session storage later for revocation if needed
- Industry standard, well-understood
- Libraries (jsonwebtoken) are mature

**Future:** If we need session revocation, we'll add a sessions table and track JWTs in database/Redis.

#### Consequences

**Positive:**
- Simple to implement
- No session storage needed initially
- Easy to scale backend horizontally
- Frontend can store token in localStorage

**Negative:**
- Can't revoke tokens before expiration (accept for MVP, add session tracking later)
- Slightly larger payload than session cookie

**Neutral:**
- Need to handle token expiration on frontend
- Token lifetime is 30 days (balance between security and UX)

#### Related Decisions
- Decision 004: Use bcrypt for password hashing

---

### Decision 003: Use bcrypt for Password Hashing

**Date:** 2025-01-12
**Status:** Accepted
**Deciders:** Technical Lead
**Tags:** security, authentication, passwords

#### Context

Need to securely store user passwords.

Requirements:
- Industry-standard security
- Resistant to brute force attacks
- Easy to implement in Node.js

#### Options Considered

**Option 1: bcrypt**
- Pros:
  - Industry standard
  - Deliberately slow (resists brute force)
  - Mature library for Node.js
  - Automatic salt generation
- Cons:
  - Slower than alternatives (this is a feature for security)

**Option 2: argon2**
- Pros:
  - Winner of Password Hashing Competition
  - More secure than bcrypt theoretically
- Cons:
  - Less widespread adoption
  - Slightly more complex configuration

**Option 3: PBKDF2**
- Pros:
  - Standard, included in Node.js crypto
- Cons:
  - Requires more careful implementation
  - Less recommended than bcrypt/argon2

#### Decision

**Chose bcrypt with 10 rounds.**

**Rationale:**
- Industry standard, battle-tested
- Mature library (bcryptjs for Node.js)
- Simple to use correctly
- 10 rounds balances security and performance

#### Consequences

**Positive:**
- Passwords are securely hashed
- Automatic salt generation
- Resistant to brute force

**Negative:**
- Login/signup slightly slower (acceptable trade-off)

**Neutral:**
- 10 rounds takes ~100ms (acceptable for auth operations)

#### Related Decisions
- Decision 002: Use JWT for authentication

---

### Decision 004: Use React for Frontend

**Date:** 2025-01-11
**Status:** Accepted
**Deciders:** Technical Lead
**Tags:** frontend, framework

#### Context

Need to choose a frontend framework for the task management SPA.

Requirements:
- Fast development
- Good developer experience
- Large ecosystem
- Easy to hire for (if needed)

#### Options Considered

**Option 1: React**
- Pros:
  - Huge ecosystem
  - Mature, stable
  - Easy to hire developers
  - Great tooling (Vite, etc.)
- Cons:
  - Slightly more boilerplate than newer frameworks

**Option 2: Vue**
- Pros:
  - Simpler learning curve
  - Less boilerplate
  - Good performance
- Cons:
  - Smaller ecosystem than React
  - Less widespread adoption

**Option 3: Svelte**
- Pros:
  - Very simple, elegant
  - Great performance
  - Less boilerplate
- Cons:
  - Smaller ecosystem
  - Less mature tooling
  - Harder to hire for

#### Decision

**Chose React.**

**Rationale:**
- Team has experience with React
- Huge ecosystem means solutions exist for any problem
- Vite makes React development fast
- Easier to hire React developers if needed

#### Consequences

**Positive:**
- Fast development with mature libraries
- Excellent community support
- Easy to find solutions to problems

**Negative:**
- Slightly more verbose than newer frameworks
- Need to choose state management approach

**Neutral:**
- Using React Context for state (simple, built-in)

#### Related Decisions
- Decision 005: Use Vite for build tool

---

### Decision 005: Use Vite for Build Tool

**Date:** 2025-01-11
**Status:** Accepted
**Deciders:** Technical Lead
**Tags:** frontend, tooling, build

#### Context

Need a build tool for React application.

Requirements:
- Fast development server
- Fast builds
- Good developer experience
- Modern

#### Options Considered

**Option 1: Vite**
- Pros:
  - Extremely fast dev server (ESM-based)
  - Fast builds (esbuild)
  - Great DX
  - Modern, actively maintained
- Cons:
  - Newer (less battle-tested than webpack)

**Option 2: Create React App (CRA)**
- Pros:
  - Official React tooling
  - Battle-tested
  - Zero config
- Cons:
  - Slow dev server
  - Slow builds
  - Less actively maintained

**Option 3: webpack**
- Pros:
  - Mature, powerful
  - Highly configurable
- Cons:
  - Complex configuration
  - Slower than Vite
  - Overkill for our needs

#### Decision

**Chose Vite.**

**Rationale:**
- Speed matters for developer productivity
- Simple configuration
- Modern approach (ESM)
- Great out-of-the-box support for React

#### Consequences

**Positive:**
- Dev server starts in < 1 second
- Hot Module Replacement is instant
- Production builds are fast
- Great developer experience

**Negative:**
- Slightly less battle-tested than webpack

**Neutral:**
- Works perfectly for our use case

---

## Deprecated Decisions

*None yet.*

---

## Rejected Decisions

### Rejected 001: Use MongoDB Instead of PostgreSQL

**Date:** 2025-01-10
**Status:** Rejected
**Tags:** database

#### Why Rejected

Our data is inherently relational (users → tasks).

MongoDB's schemaless nature doesn't provide value for our use case.

ACID compliance is important for user accounts.

PostgreSQL's JSON support gives us flexibility if we need it without going fully schemaless.

---

### Rejected 002: Use GraphQL Instead of REST

**Date:** 2025-01-13
**Status:** Rejected
**Tags:** api, backend

#### Why Rejected

GraphQL adds complexity that isn't justified for MVP.

Our frontend needs are simple (fetch tasks, create task, etc.).

REST is simpler to implement and test.

Can reconsider GraphQL post-MVP if frontend queries become complex.

---

## How to Add New Decisions

**When to add a decision:**
- Choosing a technology (database, framework, library)
- Choosing an architecture pattern (monolith vs microservices, REST vs GraphQL)
- Choosing a deployment strategy
- Making a trade-off that impacts future work

**When NOT to add a decision:**
- Small implementation details (which variable name to use)
- Temporary workarounds
- Decisions that are easily reversible

**Process:**
1. Use the template above
2. Fill in all sections (Context, Options, Decision, Consequences)
3. Assign a decision ID (next number in sequence)
4. Add tags for searchability
5. Link related decisions

**Keep decisions concise but complete.**

Explain **why** you chose something, not just **what** you chose.

---

## For AI: Reading This Document

**Before planning a feature:**
1. Read all active decisions
2. Understand constraints and patterns
3. Don't propose solutions that violate accepted decisions
4. If a decision seems wrong, propose superseding it (don't ignore it)

**When making a new technical decision:**
1. Check if similar decision already exists
2. Propose the decision using the template
3. Present options clearly
4. Explain trade-offs
5. Get user approval
6. Add to this document

**If you notice an outdated decision:**
- Propose marking it as "Deprecated"
- Create a new decision that supersedes it
- Link them together

---

This is your decision truth. Every choice has context. Preserve it.
