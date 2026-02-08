# Execution Plan

**This document contains the current feature's execution plan broken into phases.**

This file is **temporary** - it exists while a feature is being implemented.

Once the feature is complete, this file is cleared for the next feature (or archived if you want to keep history).

**AI reads this to understand what phase to execute.**

**Humans read this to see what's happening and what's next.**

---

## How This Works

### Phases

Every feature is broken into **small, resumable phases**.

Each phase:
- Takes 1-4 hours to implement
- Has a clear goal
- Has specific scope (which files/components)
- Has tests to validate success
- Has a checkpoint (how to verify it worked)

### States

- **Pending** - Not started yet
- **In Progress** - Currently being executed
- **Completed** - Done and validated
- **Failed** - Encountered error, needs attention

### Resumability

If work stops (AI pauses, error occurs, user steps away):
- Completed phases stay completed
- Failed phase can be retried or revised
- Next phase starts from clean state

**You never lose progress.**

---

## Current Feature: [FEATURE NAME]

**Feature ID:** FEAT-XXX (from product-system.md)

**Status:** In Progress

**Started:** YYYY-MM-DD

**Target Completion:** YYYY-MM-DD

**Current Phase:** Phase N of M

---

## Phase Overview

| Phase | Name                  | Status      | Duration Est. |
|-------|-----------------------|-------------|---------------|
| 1     | [Phase 1 Name]        | Completed   | 1-2 hours     |
| 2     | [Phase 2 Name]        | Completed   | 2-3 hours     |
| 3     | [Phase 3 Name]        | In Progress | 2-3 hours     |
| 4     | [Phase 4 Name]        | Pending     | 1-2 hours     |
| 5     | [Phase 5 Name]        | Pending     | 1 hour        |
| 6     | [Phase 6 Name]        | Pending     | 1 hour        |

---

## Phase 1: [Phase Name]

**Status:** Completed ✅

**Goal:** [What this phase achieves - one sentence]

**Scope:**
- Files to be created: [list]
- Files to be modified: [list]
- Components affected: [list]

**Dependencies:**
- None (this is phase 1)

**Implementation Steps:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Tests:**
- Unit tests:
  - [Test description]
  - [Test description]
- Integration tests:
  - [Test description]

**Checkpoint:**
- [How to verify this phase succeeded]
- [What should work at this point]
- [Commands to run to validate]

**Estimated Complexity:** Low | Medium | High

**Actual Duration:** X hours

**Completed:** YYYY-MM-DD HH:MM

**Notes:**
- [Any important notes or learnings from this phase]

---

## Phase 2: [Phase Name]

**Status:** Completed ✅

**Goal:** [What this phase achieves]

**Scope:**
- Files to be created: [list]
- Files to be modified: [list]
- Components affected: [list]

**Dependencies:**
- Phase 1 must be complete
- [Any other dependencies]

**Implementation Steps:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Tests:**
- Unit tests:
  - [Test description]
- Integration tests:
  - [Test description]

**Checkpoint:**
- [How to verify success]
- [What should work now]

**Estimated Complexity:** Low | Medium | High

**Actual Duration:** X hours

**Completed:** YYYY-MM-DD HH:MM

**Notes:**
- [Notes]

---

## Phase 3: [Phase Name]

**Status:** In Progress 🔄

**Goal:** [What this phase achieves]

**Scope:**
- Files to be created: [list]
- Files to be modified: [list]
- Components affected: [list]

**Dependencies:**
- Phase 2 must be complete
- [Other dependencies]

**Implementation Steps:**
1. [Step 1] ✅
2. [Step 2] ✅
3. [Step 3] 🔄 (currently working on this)
4. [Step 4]
5. [Step 5]

**Tests:**
- Unit tests:
  - [Test description]
- Integration tests:
  - [Test description]

**Checkpoint:**
- [How to verify success]
- [What should work]

**Estimated Complexity:** Low | Medium | High

**Progress Notes:**
- [YYYY-MM-DD HH:MM]: Started phase 3
- [YYYY-MM-DD HH:MM]: Completed steps 1 and 2
- [YYYY-MM-DD HH:MM]: Working on step 3 (encountered issue with X, investigating)

---

## Phase 4: [Phase Name]

**Status:** Pending ⏸️

**Goal:** [What this phase achieves]

**Scope:**
- Files to be created: [list]
- Files to be modified: [list]
- Components affected: [list]

**Dependencies:**
- Phase 3 must be complete

**Implementation Steps:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Tests:**
- Unit tests:
  - [Test description]
- Integration tests:
  - [Test description]

**Checkpoint:**
- [How to verify success]

**Estimated Complexity:** Low | Medium | High

---

## Phase 5: [Phase Name]

**Status:** Pending ⏸️

**Goal:** [What this phase achieves]

**Scope:**
- Files to be created: [list]
- Files to be modified: [list]

**Dependencies:**
- Phase 4 must be complete

**Implementation Steps:**
1. [Step 1]
2. [Step 2]

**Tests:**
- Unit tests: [list]
- Integration tests: [list]

**Checkpoint:**
- [How to verify]

**Estimated Complexity:** Low | Medium | High

---

## Phase 6: Final Review & Deployment

**Status:** Pending ⏸️

**Goal:** Validate all acceptance criteria met, deploy feature

**Scope:**
- Review all changes
- Run full test suite
- Update documentation
- Deploy to production

**Dependencies:**
- All previous phases complete
- All tests passing
- User approval

**Implementation Steps:**
1. Review all acceptance criteria (from product-system.md)
2. Run full test suite
3. Update tech-spine documents (if needed)
4. Update product-system.md (mark feature complete)
5. Deploy to staging
6. Validate on staging
7. Deploy to production
8. Post-deployment validation
9. Capture lessons learned

**Tests:**
- All unit tests passing
- All integration tests passing
- Manual smoke test on staging
- Manual smoke test on production

**Checkpoint:**
- Feature is live in production
- All acceptance criteria validated
- No errors in logs

**Estimated Complexity:** Low

---

## Rollback Plan

**If something goes wrong during implementation:**

### Phase Failures

If Phase N fails:
1. Identify what went wrong
2. Fix the issue
3. Re-run phase tests
4. Validate checkpoint
5. Continue to next phase

If Phase N is unrecoverable:
1. Rollback code changes from Phase N
2. Keep completed phases (Phase 1 to N-1)
3. Revise execution plan
4. Retry Phase N with new approach

### Deployment Failures

If deployment fails:
1. Immediately rollback to previous version
2. Investigate failure
3. Fix issue in development
4. Re-test thoroughly
5. Re-deploy

**Rollback commands:**
```bash
# Example rollback commands (adjust to your deployment)
git revert HEAD
npm run deploy:rollback
```

---

## Tech Spine Updates Needed

**As phases complete, these tech-spine documents need updating:**

- [ ] `system-map.md` - [Describe what changed in architecture]
- [ ] `data-model.md` - [Describe new tables/columns]
- [ ] `service-map.md` - [Describe new services/endpoints]
- [ ] `decision-log.md` - [Log major technical decisions]
- [ ] `test-strategy.md` - [Update if testing approach changed]

**AI must update these before marking feature complete.**

---

## Acceptance Criteria Tracking

**From product-system.md FEAT-XXX:**

- [ ] [Acceptance criterion 1]
- [ ] [Acceptance criterion 2]
- [ ] [Acceptance criterion 3]
- [ ] [Acceptance criterion 4]
- [ ] [Acceptance criterion 5]

**All must be checked before feature is considered complete.**

---

## Lessons Captured (During Execution)

As phases complete, note lessons learned here. These will be added to `docs/learning/lessons.md` at the end.

**Lesson Candidates:**
1. [Date]: [What happened / what we learned]
2. [Date]: [What happened / what we learned]

---

## Example: Filled Template

Below is an example of what this document looks like when filled in for a real feature.

---

## Current Feature: User Authentication

**Feature ID:** FEAT-001

**Status:** In Progress

**Started:** 2025-01-15

**Target Completion:** 2025-01-20

**Current Phase:** Phase 3 of 6

---

## Phase Overview

| Phase | Name                          | Status      | Duration Est. |
|-------|-------------------------------|-------------|---------------|
| 1     | Database Schema               | Completed   | 1 hour        |
| 2     | Auth Service Implementation   | Completed   | 2-3 hours     |
| 3     | API Endpoints                 | In Progress | 2 hours       |
| 4     | Frontend Forms                | Pending     | 2-3 hours     |
| 5     | Integration Tests             | Pending     | 1-2 hours     |
| 6     | Deployment                    | Pending     | 1 hour        |

---

## Phase 1: Database Schema

**Status:** Completed ✅

**Goal:** Create users table in PostgreSQL

**Scope:**
- Files to be created:
  - `migrations/20250115_100000_create_users_table.sql`
- Files to be modified:
  - `docs/tech-spine/data-model.md` (add users table documentation)

**Dependencies:** None

**Implementation Steps:**
1. Create migration file ✅
2. Define users table schema (id, email, password_hash, created_at, updated_at, is_active) ✅
3. Add indexes (idx_users_email) ✅
4. Run migration on dev database ✅
5. Update data-model.md ✅

**Tests:**
- Database connection test
- Verify table exists
- Verify indexes created

**Checkpoint:**
- Run `SELECT * FROM users;` successfully
- Query by email uses index (explain plan)

**Estimated Complexity:** Low

**Actual Duration:** 45 minutes

**Completed:** 2025-01-15 11:30

**Notes:**
- Used UUID for id (better than integer for distributed systems)
- Added is_active flag for soft delete pattern

---

## Phase 2: Auth Service Implementation

**Status:** Completed ✅

**Goal:** Implement AuthService with signup, login, token generation

**Scope:**
- Files to be created:
  - `src/services/AuthService.js`
  - `tests/unit/services/AuthService.test.js`
- Dependencies to install:
  - bcrypt
  - jsonwebtoken

**Dependencies:** Phase 1 complete

**Implementation Steps:**
1. Install bcrypt and jsonwebtoken ✅
2. Create AuthService.signUp() method ✅
3. Create AuthService.login() method ✅
4. Create AuthService.validateToken() method ✅
5. Write unit tests ✅

**Tests:**
- Unit tests:
  - Test signUp with valid data
  - Test signUp with invalid data (validation)
  - Test login with correct credentials
  - Test login with wrong password
  - Test validateToken with valid token
  - Test validateToken with expired token

**Checkpoint:**
- All unit tests passing
- Can hash password and verify it
- Can generate and validate JWT tokens

**Estimated Complexity:** Medium

**Actual Duration:** 2.5 hours

**Completed:** 2025-01-15 15:00

**Notes:**
- Used bcrypt with 10 rounds (good balance of security and performance)
- JWT expires in 30 days
- Token includes userId and email claims

---

## Phase 3: API Endpoints

**Status:** In Progress 🔄

**Goal:** Create /api/auth/signup and /api/auth/login endpoints

**Scope:**
- Files to be created:
  - `src/routes/auth.js`
  - `src/controllers/AuthController.js`
  - `src/middleware/auth.js`
  - `tests/integration/api/auth.test.js`

**Dependencies:** Phase 2 complete

**Implementation Steps:**
1. Create auth routes file ✅
2. Create AuthController ✅
3. Implement POST /signup endpoint ✅
4. Implement POST /login endpoint 🔄 (working on this)
5. Add rate limiting middleware
6. Write integration tests

**Tests:**
- Integration tests:
  - Test POST /signup with valid data
  - Test POST /signup with duplicate email
  - Test POST /login with valid credentials
  - Test POST /login with invalid credentials
  - Test rate limiting (5 requests per 10 min)

**Checkpoint:**
- Can call /signup and create user
- Can call /login and get token
- Invalid requests return proper error codes

**Estimated Complexity:** Medium

**Progress Notes:**
- [2025-01-16 09:00]: Started phase 3
- [2025-01-16 10:30]: Completed signup endpoint, works correctly
- [2025-01-16 11:00]: Working on login endpoint, need to add rate limiting

---

*[Phases 4, 5, 6 remain as template above]*

---

## How to Use This Document

### As AI (Claude Code)

**When starting implementation:**
1. Read entire execution plan
2. Start with Phase 1
3. Execute each step
4. Write tests as you go
5. Validate checkpoint
6. Mark phase complete
7. Move to next phase

**When resuming work:**
1. Read execution plan
2. Find current phase (status: In Progress)
3. Check progress notes
4. Continue from last completed step

**When phase fails:**
1. Mark phase status as Failed
2. Add notes explaining what went wrong
3. Ask user how to proceed (retry, revise plan, skip)

**When all phases complete:**
1. Verify all acceptance criteria checked
2. Update all tech-spine documents
3. Mark feature complete in product-system.md
4. Propose lessons learned
5. Clear this file (or archive it)

### As User

**To check progress:**
- Look at Phase Overview table
- Read current phase details
- Check acceptance criteria tracking

**To resume work:**
- Tell AI: "Continue from current phase"
- AI will read this file and resume

**To change plan:**
- Tell AI what needs to change
- AI will revise phases and get your approval

---

This is your execution truth. Stay on track. Resume anytime.
