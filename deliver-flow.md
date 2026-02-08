# Deliver Flow

**This is the main workflow of behzad-framework.**

When you say "I want to deliver this feature," this is what happens.

This document describes the complete pipeline from vague idea to deployed feature.

---

## Overview

The deliver flow has **9 phases**:

1. **Requirement Clarification** - Understand what you actually want
2. **Feature Definition** - Document it clearly in product-system.md
3. **Technical Impact Analysis** - Understand what will change
4. **Execution Planning** - Break work into safe, resumable phases
5. **Implementation** - Build it phase by phase with tests
6. **Pre-Release Review** - Validate before deployment
7. **Deployment** - Release to production
8. **Post-Deployment Validation** - Verify it works
9. **Learning Capture** - Document lessons learned

**Each phase has clear inputs, outputs, and decision gates.**

---

## Phase 1: Requirement Clarification

### Purpose

Transform your vague intent into clear understanding.

You might say: "I want search."

But what does that mean? Full-text search? Filter by tags? Search tasks or users? What if no results?

**This phase asks the right questions.**

---

### Who Does This

**AI acts as Product Manager**

---

### Input

Your initial intent (could be vague):
- "Add user authentication"
- "I want search functionality"
- "Users should be able to share tasks"

---

### Process

**AI asks clarifying questions** across these dimensions:

#### 1. **Who** - Users and Roles
- Who will use this feature?
- Are there different user types?
- What permissions do they need?

#### 2. **What** - Functionality
- What exactly should happen?
- What are the edge cases?
- What should NOT happen?

#### 3. **Why** - Purpose
- Why do users need this?
- What problem does it solve?
- What's the success metric?

#### 4. **When** - Timing and Triggers
- When does this feature activate?
- What triggers it?
- Are there time constraints?

#### 5. **Where** - Context
- Where in the UI does this appear?
- Which parts of the system are affected?

#### 6. **How** - User Experience
- How do users interact with it?
- What happens on success?
- What happens on error?

#### 7. **Constraints** - Limitations
- Are there technical constraints?
- Performance requirements?
- Security requirements?
- Budget constraints?

---

### Example Questions

**User says:** "I want user authentication"

**AI asks:**
1. What authentication method? (email/password, social login, magic link?)
2. Do users need to verify their email?
3. What password requirements? (length, complexity?)
4. Should we support password reset?
5. How long should sessions last?
6. What happens if login fails multiple times?
7. Should we track login history?
8. Any compliance requirements? (GDPR, etc.)

**Each answer clarifies requirements.**

---

### Output

**Clear understanding documented as notes**, ready for Feature Definition phase.

Example output:
```
Feature: User Authentication (Email/Password)

Clarifications:
- Method: Email + Password (no social login for MVP)
- Email verification: Not required for MVP
- Password requirements: Min 8 chars, must include number and special char
- Password reset: Yes, via email link
- Session duration: 30 days
- Failed login handling: Rate limiting (5 attempts per 10 min)
- Login history: Not for MVP
- Compliance: Basic GDPR (users can delete account)
```

---

### Decision Gate

**None** - This is information gathering. No approval needed yet.

---

## Phase 2: Feature Definition

### Purpose

Create a clear, reviewable feature specification in product-system.md.

This becomes the **source of truth** for what we're building.

---

### Who Does This

**AI acts as Product Manager**

---

### Input

Clarified requirements from Phase 1

---

### Process

AI creates or updates feature entry in `docs/product-system.md`:

**Feature structure:**
- Feature ID (e.g., FEAT-001)
- Title
- Description (what it is)
- Requirements (numbered list of what it must do)
- Acceptance Criteria (how to verify it's done)
- Priority
- Dependencies (what must be done first)
- Status (starts as "In Planning")

**Requirements are specific:**
- "User can log in with email and password" ✅
- "Auth works well" ❌ (too vague)

**Acceptance Criteria are testable:**
- "Login form accepts valid credentials and returns JWT token" ✅
- "Login is secure" ❌ (not testable)

---

### Example Output

Added to product-system.md:

```markdown
### FEAT-001: User Authentication

**Status:** In Planning
**Priority:** P0

**Description:**
Allow users to create accounts and log in with email and password.

**Requirements:**
1. Users can sign up with email and password
2. Email must be valid format
3. Password must be >= 8 chars, include number and special char
4. Users can log in with email and password
5. Users can log out
6. Sessions last 30 days
7. Failed login attempts are rate-limited (max 5 per 10 minutes)

**Acceptance Criteria:**
- [ ] Sign up form creates user in database
- [ ] Email validation prevents invalid emails
- [ ] Password validation enforces requirements
- [ ] Login with correct credentials succeeds
- [ ] Login with wrong credentials fails with clear error
- [ ] Logout clears session
- [ ] Rate limiting prevents brute force
```

---

### Decision Gate ✋

**"Does this match what you want?"**

AI presents the feature definition.

**You review:**
- Are requirements complete?
- Are acceptance criteria clear?
- Is anything missing?
- Is anything wrong?

**You respond:**
- ✅ **Approve**: Continue to next phase
- ❌ **Revise**: AI adjusts based on feedback, presents again
- ⏸️ **Pause**: Save progress, resume later

**Why this gate matters:**
If you build the wrong thing, you waste time. Confirm upfront.

---

## Phase 3: Technical Impact Analysis

### Purpose

Understand what needs to change technically.

Identify risks before implementation.

---

### Who Does This

**AI acts as System Architect**

---

### Input

- Feature definition from product-system.md
- Current tech-spine/ documents
- Lessons from lessons.md

---

### Process

**AI reads:**
1. `docs/tech-spine/system-map.md` - Current architecture
2. `docs/tech-spine/data-model.md` - Current data structures
3. `docs/tech-spine/service-map.md` - Current services and APIs
4. `docs/tech-spine/decision-log.md` - Past decisions
5. `docs/tech-spine/test-strategy.md` - Testing requirements
6. `docs/learning/lessons.md` - Past lessons (filtered by relevant tags)

**AI analyzes:**
- What components are affected?
- What new components are needed?
- What data structures change?
- What dependencies are needed?
- What risks exist?
- What lessons apply?

---

### Example Analysis

For FEAT-001 (User Authentication):

```
Technical Impact Analysis

Architecture Changes:
- New AuthService needed (service layer)
- New /api/auth routes needed (API layer)
- Frontend: Login and Signup forms needed

Data Model Changes:
- New 'users' table required:
  - id (UUID, primary key)
  - email (unique, indexed)
  - password_hash
  - created_at, updated_at
  - is_active (for soft delete)

Service Changes:
- AuthService methods: signUp(), login(), validateToken(), logout()
- AuthController for API endpoints
- Auth middleware for protecting routes

External Dependencies:
- bcrypt library (password hashing)
- jsonwebtoken library (JWT tokens)
- Redis (for session storage and rate limiting)

Tests Required:
- Unit tests: AuthService methods
- Integration tests: API endpoints
- Security tests: Rate limiting, token validation

Risks:
- Password security (mitigation: use bcrypt with 10 rounds)
- Brute force attacks (mitigation: rate limiting)
- Token theft (mitigation: HTTPS only, short expiration)

Relevant Lessons:
- Lesson 002: Rate limiting on auth endpoints
- Lesson 003: Validate passwords on backend
- Lesson 007: Document environment variables (JWT_SECRET)

Estimated Complexity: Medium
Estimated Duration: 6-8 hours (across multiple phases)
```

---

### Output

**Technical Impact Summary** - Clear understanding of what changes.

This informs the execution plan in next phase.

---

### Decision Gate

**None** - This is analysis. Planning comes next.

---

## Phase 4: Execution Planning

### Purpose

Break the work into small, safe, resumable phases.

Create `docs/execution/execution-plan.md`.

---

### Who Does This

**AI acts as Senior Engineer + Project Manager**

---

### Input

- Feature definition
- Technical impact analysis

---

### Process

**AI creates phased plan:**

Each phase should:
- Take 1-4 hours
- Have clear goal
- Have specific scope (which files)
- Have tests
- Have checkpoint (how to verify success)
- Leave system in working state

**Phases are sequential** but can be paused between phases.

---

### Example Execution Plan

For FEAT-001 (User Authentication):

```
Phase 1: Database Schema (1 hour)
- Create users table migration
- Update data-model.md
- Checkpoint: Table exists, indexed correctly

Phase 2: Auth Service Implementation (2-3 hours)
- Create AuthService with signUp, login, validateToken
- Write unit tests
- Checkpoint: All unit tests pass

Phase 3: API Endpoints (2 hours)
- Create /api/auth/signup and /api/auth/login
- Add rate limiting middleware
- Write integration tests
- Checkpoint: API endpoints work, tests pass

Phase 4: Frontend Forms (2-3 hours)
- Create Signup component
- Create Login component
- Integrate with API
- Checkpoint: Can sign up and log in via UI

Phase 5: Integration Testing (1-2 hours)
- End-to-end tests for auth flow
- Security testing (rate limiting, validation)
- Checkpoint: All tests pass

Phase 6: Deployment (1 hour)
- Deploy to staging
- Validate on staging
- Deploy to production
- Post-deployment validation
- Checkpoint: Feature live and working
```

**Total: 9-12 hours across 6 phases**

---

### Decision Gate ✋

**"Should I proceed with this plan?"**

AI presents the execution plan.

**You review:**
- Are phases small enough?
- Are tests included?
- Does the approach make sense?
- Any phases that seem risky?

**You respond:**
- ✅ **Approve**: Start implementation
- ❌ **Revise**: Suggest changes, AI adjusts
- ⏸️ **Pause**: Think about it, decide later

**Why this gate matters:**
Bad plans lead to wasted work. Good plans make execution smooth.

---

## Phase 5: Implementation (Phase by Phase)

### Purpose

Build the feature, one phase at a time, with tests.

---

### Who Does This

**AI acts as Senior Engineer + QA**

---

### Input

Approved execution plan from execution-plan.md

---

### Process

**For each phase:**

1. **AI announces phase start**
   - "Starting Phase 1: Database Schema"

2. **AI implements the phase**
   - Creates/modifies files as defined in phase scope
   - Writes tests alongside code
   - Updates tech-spine documents if needed

3. **AI runs tests**
   - Unit tests for this phase
   - Integration tests if applicable

4. **AI validates checkpoint**
   - Runs checkpoint commands
   - Verifies phase succeeded

5. **AI updates execution-plan.md**
   - Marks phase as completed
   - Notes any issues or learnings

6. **(Optional) Decision Gate: "Ready for next phase?"**
   - If you want tight control, approve each phase
   - If you trust the plan, let AI continue automatically

7. **AI moves to next phase**
   - Repeats process

---

### Handling Failures

**If phase fails:**

AI stops and reports:
```
Phase 3 failed: Integration tests are failing

Error: Rate limiting middleware not working correctly
- Expected: 429 status after 5 requests
- Actual: Requests continue past 5

Options:
1. Debug and retry phase
2. Revise phase approach
3. Pause and investigate
```

**You decide:** Fix and retry, or revise plan.

**Completed phases remain completed.** No lost progress.

---

### Tech-Spine Updates

As implementation progresses, AI updates tech-spine documents:

- New table? → Update data-model.md
- New service? → Update service-map.md
- New API? → Update service-map.md
- Architecture change? → Update system-map.md
- Major decision? → Add to decision-log.md

**Tech-spine stays current automatically.**

---

### Output

- Feature implemented
- All tests passing
- Tech-spine updated
- execution-plan.md shows all phases complete

---

### Decision Gate

**None during phases** (unless you requested per-phase approval)

**Gate comes after all phases complete** (Pre-Release Review)

---

## Phase 6: Pre-Release Review

### Purpose

Validate everything before deployment.

Ensure all acceptance criteria met.

---

### Who Does This

**AI acts as QA + Tech Lead**

---

### Input

- Completed implementation
- Feature definition (acceptance criteria)
- Test results

---

### Process

**AI performs final review:**

1. **Verify Acceptance Criteria**
   - Check each item from product-system.md
   - Run manual tests if needed
   - Mark each criterion as ✅ or ❌

2. **Run Full Test Suite**
   - All unit tests
   - All integration tests
   - Check test coverage

3. **Review Tech-Spine Updates**
   - Confirm all documents updated
   - No missing documentation

4. **Security Check**
   - Verify security requirements met
   - Check for common vulnerabilities

5. **Performance Check**
   - Verify performance requirements met
   - Check for obvious bottlenecks

---

### Example Review

```
Pre-Release Review: FEAT-001 User Authentication

Acceptance Criteria:
✅ Sign up form creates user in database
✅ Email validation prevents invalid emails
✅ Password validation enforces requirements
✅ Login with correct credentials succeeds
✅ Login with wrong credentials fails with clear error
✅ Logout clears session
✅ Rate limiting prevents brute force

Test Results:
✅ Unit tests: 24 passed, 0 failed
✅ Integration tests: 12 passed, 0 failed
✅ Code coverage: 92% (above 85% target)

Tech-Spine Updates:
✅ data-model.md updated (users table documented)
✅ service-map.md updated (AuthService documented)
✅ system-map.md updated (auth flow added)
✅ decision-log.md updated (Decision 002: Use JWT)
✅ test-strategy.md current (no changes needed)

Security:
✅ Passwords hashed with bcrypt
✅ Rate limiting enabled
✅ JWT tokens expire in 30 days
✅ HTTPS enforced

Performance:
✅ Login < 150ms (bcrypt hashing)
✅ Signup < 200ms

Ready for deployment: YES
```

---

### Decision Gate ✋

**"Ready to deploy?"**

AI presents the pre-release review.

**You review:**
- Are all acceptance criteria met?
- Are tests passing?
- Is documentation complete?
- Any concerns?

**You respond:**
- ✅ **Approve**: Deploy to production
- ❌ **Revise**: Fix issues, review again
- 🔄 **Deploy to staging first**: Test in staging environment

**Why this gate matters:**
Deploying broken features is costly. Validate first.

---

## Phase 7: Deployment

### Purpose

Release the feature to production.

---

### Who Does This

**AI acts as DevOps Engineer**

---

### Input

- Approved pre-release review
- Deployment configuration

---

### Process

**AI deploys systematically:**

1. **Create Release Tag**
   - Version bump (e.g., v1.1.0 → v1.2.0)
   - Git tag with release notes

2. **Deploy to Staging (if applicable)**
   - Deploy code to staging environment
   - Run smoke tests
   - Validate feature works

3. **Get Final Approval**
   - "Staging validated. Ready to deploy to production?"

4. **Deploy to Production**
   - Deploy code to production
   - Run database migrations (if needed)
   - Restart services

5. **Monitor Deployment**
   - Watch logs for errors
   - Check health endpoints
   - Monitor performance metrics

---

### Rollback Plan

**If deployment fails:**

AI immediately:
1. Rollback to previous version
2. Check system health
3. Report what went wrong

**You decide:** Fix and retry, or investigate.

---

### Output

- Feature live in production
- Release tagged
- Deployment logged

---

### Decision Gate ✋

**"Ready to deploy to production?"**

(This gate happens before production deploy)

AI shows:
- Staging test results
- What will be deployed
- Risk assessment

**You approve or cancel.**

**Why this gate matters:**
Production is critical. Final confirmation prevents mistakes.

---

## Phase 8: Post-Deployment Validation

### Purpose

Verify the feature actually works in production.

---

### Who Does This

**AI acts as DevOps Engineer + QA**

---

### Input

- Deployed feature
- Acceptance criteria
- Monitoring data

---

### Process

**AI validates in production:**

1. **Health Check**
   - Hit health endpoint
   - Verify services running

2. **Smoke Tests**
   - Test critical paths manually or automatically
   - For auth: Sign up, log in, log out

3. **Check Logs**
   - Look for errors
   - Verify no unexpected issues

4. **Monitor Metrics**
   - Response times acceptable?
   - Error rate normal?
   - Database performance OK?

5. **User Validation** (if possible)
   - Test as actual user
   - Verify UI works correctly

---

### Example Validation

```
Post-Deployment Validation: FEAT-001

Health Check:
✅ API responding: 200 OK
✅ Database connected
✅ Redis connected

Smoke Tests:
✅ User signed up successfully (user ID: xyz123)
✅ User logged in successfully (received token)
✅ User logged out successfully

Logs:
✅ No errors in last 5 minutes
✅ Auth requests logging correctly

Metrics:
✅ Average login time: 142ms (within target)
✅ Error rate: 0%
✅ Database queries fast

User Validation:
✅ Tested signup flow manually: Works
✅ Tested login flow manually: Works

Deployment Status: SUCCESS ✅
```

---

### Output

**Deployment Confirmation** - Feature is live and working.

---

### Decision Gate

**None** - This is validation. If problems found, they're addressed immediately.

---

## Phase 9: Learning Capture

### Purpose

Document what you learned.

Improve for next time.

---

### Who Does This

**AI acts as Project Historian**

---

### Input

- Complete feature delivery experience
- What went well
- What went wrong
- Observations

---

### Process

**AI reviews the entire delivery:**

1. **Identify Lessons**
   - What was learned?
   - What mistakes were made?
   - What should be done differently?

2. **Draft Lessons**
   - Write in lesson format:
     - Context
     - What happened
     - Rule for the future
   - Keep short and actionable

3. **Propose to User**
   - Present drafted lessons
   - Explain why each is valuable

---

### Example Lessons

After FEAT-001 delivery:

```
Proposed Lessons:

Lesson 011: Test Rate Limiting Early
Context: Implementing auth with rate limiting
What happened: Wrote rate limiting middleware but didn't test it until integration tests. Had to debug and fix, wasted 30 minutes.
Rule: When adding rate limiting, test it immediately with manual requests. Don't wait for integration tests.
Tags: testing, rate-limiting, auth

Lesson 012: Document JWT Secret in Setup
Context: Setting up auth in new environment
What happened: Forgot to document JWT_SECRET environment variable. New developer couldn't run the project.
Rule: When adding new env vars, immediately update .env.example and document in system-map.md.
Tags: documentation, environment, setup
```

---

### Decision Gate ✋

**"Should I add these lessons?"**

AI presents proposed lessons.

**You review:**
- Are lessons useful?
- Are they specific enough?
- Should any be edited?

**You respond:**
- ✅ **Approve all**: Add to lessons.md
- ✏️ **Edit**: Refine lessons, then approve
- ❌ **Skip**: Don't add these lessons

**Why this gate matters:**
Lessons must be valuable. Bad lessons create noise.

---

### Output

- Lessons added to `docs/learning/lessons.md`
- Feature marked "Completed" in product-system.md
- execution-plan.md cleared (or archived)

---

## Completion

**Feature delivery is complete.**

The full cycle:
- Clear requirements ✅
- Defined feature ✅
- Planned execution ✅
- Implemented with tests ✅
- Validated before release ✅
- Deployed to production ✅
- Verified working ✅
- Lessons captured ✅

**Product-system.md is updated. Tech-spine is current. Lessons are captured.**

**Ready for next feature.**

---

## Summary: All Decision Gates

The flow has **5 decision gates** where you approve or reject:

1. **After Feature Definition** - "Does this match what you want?"
2. **After Execution Planning** - "Should I proceed with this plan?"
3. **(Optional) Before Each Phase** - "Ready for next phase?"
4. **Before Production Deploy** - "Ready to deploy to production?"
5. **After Learning Capture** - "Should I add these lessons?"

**Gates give you control without micromanagement.**

---

## Handling Pauses and Resumes

### Pausing

At any decision gate:
- You can say "pause" or "let me think about it"
- Current progress is saved
- All documents are current
- execution-plan.md shows current phase

### Resuming

When you return:
- Tell AI: "Continue with FEAT-001"
- AI reads execution-plan.md
- AI finds current phase
- AI continues from where it stopped

**No progress is lost.**

---

## Quick Reference

### Starting a Feature

```
You: I want to deliver [feature description]

AI: [Asks clarifying questions]
You: [Answer questions]

AI: [Creates feature definition in product-system.md]
AI: "Does this match what you want?"
You: Approve

AI: [Analyzes technical impact]
AI: [Creates execution plan]
AI: "Should I proceed with this plan?"
You: Approve

AI: [Implements phase by phase]
AI: [All phases complete]
AI: [Pre-release review]
AI: "Ready to deploy?"
You: Approve

AI: [Deploys to production]
AI: [Validates deployment]
AI: [Proposes lessons]
AI: "Should I add these lessons?"
You: Approve

Done!
```

---

### Resuming a Feature

```
You: Continue with FEAT-001

AI: [Reads execution-plan.md]
AI: "Resuming from Phase 3. Last checkpoint: Phase 2 completed."
AI: [Continues implementation]
```

---

### Checking Status

```
You: What's the status of FEAT-001?

AI: [Reads product-system.md and execution-plan.md]
AI: "FEAT-001 is in progress. Currently on Phase 3 of 6. Phases 1 and 2 completed. Estimated 4-6 hours remaining."
```

---

## Best Practices

### For Users

1. **Answer questions thoroughly** - Better requirements = better features
2. **Review at decision gates** - Don't just approve blindly
3. **Pause if unsure** - Better to think than to build the wrong thing
4. **Trust the process** - The gates ensure quality

### For AI

1. **Ask specific questions** - "What should happen when X?" not "Any other requirements?"
2. **Keep phases small** - 1-4 hours each
3. **Update documents continuously** - Don't batch updates
4. **Test as you go** - Don't write all code then all tests

---

## Common Issues

### Issue: Requirements Keep Changing

**Problem:** User keeps changing what they want during implementation.

**Solution:**
- Pause implementation
- Go back to Feature Definition phase
- Update requirements
- Create new execution plan
- Get approval
- Resume with new plan

**Don't try to accommodate changes mid-phase.** Reset and restart with clear requirements.

---

### Issue: Phase Takes Too Long

**Problem:** Phase estimated 2 hours, actually taking 6 hours.

**Solution:**
- Pause current phase
- Split phase into smaller phases
- Complete what's done
- Plan remaining work as new phases
- Continue

**Don't push through long phases.** Break them down.

---

### Issue: Tests Keep Failing

**Problem:** Written code but tests won't pass.

**Solution:**
- Mark phase as "Failed"
- Analyze why tests are failing
- Fix the code or fix the tests
- Re-run tests
- If tests pass, mark phase "Completed"
- Continue

**Don't skip tests to move forward.** Fix them.

---

### Issue: Deployed but Not Working

**Problem:** Passed all gates but feature broken in production.

**Solution:**
1. **Immediate:** Rollback to previous version
2. **Investigate:** What's different in production?
3. **Fix:** Address the issue
4. **Test:** Validate fix in staging
5. **Redeploy:** Go through deployment again
6. **Learn:** Add lesson about what was missed

**Always have rollback plan.**

---

## Next Steps

Now that you understand the deliver flow:

1. Read [decision-gates.md](decision-gates.md) - Deeper dive into each decision gate
2. Read [usage.md](usage.md) - How to actually use this with Claude Code
3. Read [examples/feature-delivery-example.md](examples/feature-delivery-example.md) - See a complete example

**The flow is simple. The value is in consistent execution.**
