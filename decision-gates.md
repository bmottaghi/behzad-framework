# Decision Gates

**Decision gates are intentional pause points where AI stops and waits for your approval.**

They give you control without requiring you to watch every step.

This document explains each gate: when it happens, why it matters, and how to respond.

---

## Philosophy

### Why Gates Exist

**Without gates:**
- AI might build the wrong thing
- You discover problems late (expensive to fix)
- You feel out of control
- Trust is hard

**With gates:**
- You confirm direction before major work
- Problems are caught early (cheap to fix)
- You stay in control at key moments
- Trust is built through transparency

**Gates balance autonomy with control.**

AI works independently between gates. You approve at critical junctions.

---

## The 5 Decision Gates

| Gate | When | Question | Why |
|------|------|----------|-----|
| 1 | After Feature Definition | "Does this match what you want?" | Prevent building wrong thing |
| 2 | After Execution Planning | "Should I proceed with this plan?" | Prevent bad approach |
| 3 | Before Each Phase (optional) | "Ready for next phase?" | Maximum control if needed |
| 4 | Before Production Deploy | "Ready to deploy to production?" | Prevent deploying broken code |
| 5 | After Learning Capture | "Should I add these lessons?" | Keep lessons valuable |

---

## Gate 1: Feature Definition Approval

### When This Happens

After AI has:
- Asked clarifying questions
- Created feature definition in product-system.md
- Documented requirements and acceptance criteria

### What AI Presents

```
Feature Definition Complete: FEAT-001 User Authentication

I've created the feature definition in docs/product-system.md.

Requirements:
1. Users can sign up with email and password
2. Email must be valid format
3. Password must be >= 8 chars, include number and special char
4. Users can log in with email and password
5. Users can log out
6. Sessions last 30 days
7. Failed login attempts are rate-limited (max 5 per 10 minutes)

Acceptance Criteria:
- Sign up form creates user in database
- Email validation prevents invalid emails
- Password validation enforces requirements
- Login with correct credentials succeeds
- Login with wrong credentials fails with clear error
- Logout clears session
- Rate limiting prevents brute force

Does this match what you want?
```

### What to Check

**Requirements completeness:**
- Is anything missing?
- Is anything unclear?
- Are edge cases covered?

**Acceptance criteria clarity:**
- Can you imagine how to test each one?
- Are they specific enough?
- Do they cover failure cases?

**Priority and scope:**
- Is this the right scope for this feature?
- Should anything be split out?
- Is priority correct?

### Your Options

#### ✅ Approve

Say: "Yes, proceed" or "Approved" or "Looks good"

**What happens next:**
- Feature status → "In Planning"
- AI moves to Technical Impact Analysis
- AI will create execution plan
- You'll see next gate after planning

**When to approve:**
- Requirements are complete and clear
- Acceptance criteria are testable
- You're confident this is what you want

---

#### ❌ Request Changes

Say: "Change [X]" or "Add [Y]" or "This isn't quite right"

**What happens next:**
- AI updates feature definition
- AI presents revised version
- You review again
- Loop until you approve

**Example:**
```
You: "Add a requirement for password reset functionality"

AI: [Updates product-system.md]
AI: "I've added requirement 8: Users can reset forgotten passwords via email.
     And added acceptance criterion: Password reset email sent and link works.
     Does this match what you want now?"
```

**When to request changes:**
- Something is missing
- Something is wrong
- Scope needs adjustment

---

#### ⏸️ Pause

Say: "Let me think about this" or "Pause for now"

**What happens next:**
- Current state saved
- Feature status remains "In Planning"
- You can resume later with "Continue FEAT-001"

**When to pause:**
- Need to discuss with stakeholders
- Need more time to think
- Unsure about requirements
- Waiting on external input

---

### Why This Gate Matters

**Cost of fixing later:**
- Fix here: 0 hours wasted
- Fix during implementation: 2-4 hours wasted (redo work)
- Fix after deployment: 10+ hours wasted (rollback, fix, redeploy)

**This gate prevents building the wrong thing.**

---

## Gate 2: Execution Plan Approval

### When This Happens

After AI has:
- Analyzed technical impact
- Created phased execution plan
- Estimated duration and complexity

### What AI Presents

```
Execution Plan Ready: FEAT-001 User Authentication

I've created a 6-phase execution plan in docs/execution/execution-plan.md.

Phase Overview:
- Phase 1: Database Schema (1 hour)
- Phase 2: Auth Service Implementation (2-3 hours)
- Phase 3: API Endpoints (2 hours)
- Phase 4: Frontend Forms (2-3 hours)
- Phase 5: Integration Testing (1-2 hours)
- Phase 6: Deployment (1 hour)

Total Estimated Duration: 9-12 hours

Technical Impact:
- New users table in database
- New AuthService
- New /api/auth endpoints
- Frontend login/signup forms
- Dependencies: bcrypt, jsonwebtoken

Risks Identified:
- Password security (mitigated with bcrypt)
- Brute force attacks (mitigated with rate limiting)

Relevant Lessons Applied:
- Lesson 002: Rate limiting on auth endpoints
- Lesson 003: Backend password validation

Should I proceed with this plan?
```

### What to Check

**Phase structure:**
- Are phases small enough? (1-4 hours each)
- Do phases have clear checkpoints?
- Can you resume between phases?

**Technical approach:**
- Does the approach make sense?
- Are there better alternatives?
- Are risks identified and mitigated?

**Tests included:**
- Does each phase include tests?
- Is test coverage adequate?

**Lessons applied:**
- Are relevant lessons incorporated?
- Are past mistakes being avoided?

**Duration estimate:**
- Does the estimate seem reasonable?
- Is it aligned with your timeline?

### Your Options

#### ✅ Approve

Say: "Yes, proceed" or "Start implementation" or "Approved"

**What happens next:**
- AI starts Phase 1
- execution-plan.md is active
- AI implements phase by phase
- Next gate is Pre-Release Review (unless you enable per-phase gates)

**When to approve:**
- Plan makes sense
- Phases are appropriately sized
- Risks are acceptable
- Approach aligns with your expectations

---

#### ❌ Request Changes

Say: "Split Phase 2 into smaller phases" or "Use different approach for X"

**What happens next:**
- AI revises execution plan
- AI presents revised version
- You review again

**Example:**
```
You: "Phase 4 seems too big. Split frontend into separate phases for signup and login."

AI: [Revises plan]
AI: "I've split Phase 4 into:
     - Phase 4A: Signup Form (1-2 hours)
     - Phase 4B: Login Form (1-2 hours)
     Each now has clear checkpoint. Should I proceed with this revised plan?"
```

**When to request changes:**
- Phases too large
- Better approach exists
- Missing important steps
- Risks not adequately addressed

---

#### 🤔 Ask Questions

Say: "Why did you choose JWT over session cookies?" or "What's the risk of X?"

**What happens next:**
- AI explains reasoning
- AI references decision-log or research if applicable
- You can then approve, request changes, or ask more questions

**When to ask:**
- Approach is unclear
- Want to understand trade-offs
- Need more context

---

#### ⏸️ Pause

Say: "Let me review the plan in detail" or "Pause for now"

**What happens next:**
- Plan saved in execution-plan.md
- Feature status remains "In Planning"
- You can resume when ready

**When to pause:**
- Plan is complex, need time to review
- Want to consult with team
- Need to align timeline

---

### Why This Gate Matters

**Cost of bad plan:**
- Good plan: Smooth execution, 9-12 hours
- Bad plan: Rework, debugging, wasted effort, 20+ hours

**This gate prevents wasted implementation time.**

---

## Gate 3: Per-Phase Approval (Optional)

### When This Happens

Before AI starts each phase (if you enabled this).

**By default, this gate is OFF.** AI executes all phases after plan approval.

**Enable it when:**
- Feature is risky or complex
- You want maximum control
- You're learning the process
- You don't fully trust the plan yet

### What AI Presents

```
Phase 2 Complete: Auth Service Implementation

Completed:
✅ Created AuthService with signUp, login, validateToken methods
✅ Wrote 18 unit tests (all passing)
✅ Code coverage: 95%
✅ Checkpoint validated: All service methods work correctly

Next: Phase 3: API Endpoints (estimated 2 hours)

Ready for Phase 3?
```

### What to Check

**Current phase results:**
- Did phase complete successfully?
- Are tests passing?
- Is checkpoint validated?

**Ready for next phase:**
- Is system in good state?
- Are you ready to continue?

### Your Options

#### ✅ Continue

Say: "Yes, continue" or "Proceed" or "Go"

**What happens next:**
- AI starts next phase immediately

---

#### 🔍 Review

Say: "Let me check the code first" or "Show me what changed"

**What happens next:**
- You review code changes
- You run tests locally if desired
- You approve or request fixes

---

#### ⏸️ Pause

Say: "Pause here" or "Let's stop for now"

**What happens next:**
- Progress saved
- execution-plan.md shows current phase complete
- You resume later with "Continue FEAT-001"

---

### How to Enable/Disable

**Enable:** Say "Approve each phase before continuing"

**Disable:** Say "Continue all phases automatically"

---

### Why This Gate Exists

**For tight control:**
- Catch issues immediately
- Review code incrementally
- Learn the process

**Trade-off:**
- Slower (you must approve each phase)
- More interruptions

**Most users should leave this OFF.**

Only enable if you need maximum control.

---

## Gate 4: Production Deployment Approval

### When This Happens

After AI has:
- Completed all implementation phases
- Passed pre-release review
- Validated on staging (if applicable)

### What AI Presents

```
Pre-Release Review Complete: FEAT-001 User Authentication

Acceptance Criteria:
✅ All 7 criteria verified

Test Results:
✅ Unit tests: 24 passed, 0 failed
✅ Integration tests: 12 passed, 0 failed
✅ Code coverage: 92%

Tech-Spine Updates:
✅ All documents updated

Security:
✅ Passwords hashed with bcrypt
✅ Rate limiting enabled
✅ JWT tokens expire in 30 days

Staging Validation:
✅ Feature tested on staging
✅ All flows work correctly
✅ No errors in logs

Ready to deploy to production?
```

### What to Check

**Acceptance criteria:**
- Are all checked?
- Did you verify critical ones yourself?

**Tests:**
- All passing?
- Coverage adequate?

**Documentation:**
- Tech-spine updated?
- Deployment notes clear?

**Staging validation:**
- Does it work on staging?
- Any issues observed?

**Timing:**
- Is now a good time to deploy?
- Any conflicts with other work?

### Your Options

#### ✅ Deploy

Say: "Yes, deploy" or "Go to production" or "Deploy"

**What happens next:**
- AI deploys to production
- AI runs post-deployment validation
- AI confirms success
- Next gate is Learning Capture

**When to deploy:**
- All checks pass
- You're confident
- Timing is good

---

#### 🧪 Deploy to Staging First

Say: "Deploy to staging first" or "Let me test on staging"

**What happens next:**
- AI deploys to staging
- You test manually
- AI waits for your approval
- You approve production deploy when ready

**When to do this:**
- Want to test personally
- Feature is high-risk
- First time using framework

---

#### ❌ Don't Deploy

Say: "Don't deploy yet" or "I see an issue with X"

**What happens next:**
- AI doesn't deploy
- You explain issue
- AI fixes or investigates
- Pre-release review runs again
- You approve when ready

**When to do this:**
- Noticed a problem
- Not confident yet
- Need more testing

---

#### ⏸️ Pause

Say: "Let me review" or "Pause before deploy"

**What happens next:**
- Everything ready but not deployed
- You can review at your pace
- Resume with "Deploy FEAT-001"

**When to pause:**
- Need to coordinate timing
- Want to review code thoroughly
- Waiting for maintenance window

---

### Why This Gate Matters

**Production is critical.**

Bad deployments:
- Break user experience
- Cause data issues
- Damage trust
- Are expensive to fix

**This gate is your final safety check.**

---

### Rollback Plan

If you deploy and something breaks:

```
You: "Rollback FEAT-001"

AI: [Rolls back to previous version]
AI: "Rolled back to v1.1.0. Feature disabled. System stable."
```

**Always have rollback ready.**

---

## Gate 5: Learning Capture Approval

### When This Happens

After AI has:
- Completed deployment
- Validated feature in production
- Reviewed entire delivery experience

### What AI Presents

```
Feature Delivery Complete: FEAT-001 User Authentication

Feature is live and working in production.

I've identified 2 lessons to capture:

Lesson 011: Test Rate Limiting Early
Context: Implementing auth with rate limiting
What happened: Wrote rate limiting middleware but didn't test until integration tests. Had to debug and fix, wasted 30 minutes.
Rule: When adding rate limiting, test immediately with manual requests before writing integration tests.
Tags: testing, rate-limiting, auth

Lesson 012: Document Environment Variables Immediately
Context: Added JWT_SECRET environment variable
What happened: Forgot to document it initially. Wasted time later when setting up new environment.
Rule: When adding new env var, immediately update .env.example and document in system-map.md before continuing.
Tags: documentation, environment, setup

Should I add these lessons to docs/learning/lessons.md?
```

### What to Check

**Lesson quality:**
- Are they specific and actionable?
- Will they help in future work?
- Are they clear?

**Lesson quantity:**
- Too many lessons? (keep it focused)
- Too few lessons? (missing learnings)

**Tags:**
- Are tags appropriate?
- Will lessons be findable later?

### Your Options

#### ✅ Approve All

Say: "Yes, add both" or "Approved" or "Add them"

**What happens next:**
- Lessons added to lessons.md
- Feature marked "Completed" in product-system.md
- execution-plan.md cleared
- Feature delivery complete

---

#### ✏️ Edit Lessons

Say: "Lesson 011 looks good, but revise Lesson 012 to be more specific"

**What happens next:**
- AI revises specified lessons
- AI presents revised versions
- You approve or request more edits

---

#### ➕ Add More Lessons

Say: "Also add a lesson about X"

**What happens next:**
- AI drafts additional lesson
- AI presents all lessons
- You approve or edit

---

#### ❌ Skip Lessons

Say: "Skip these lessons" or "Not needed"

**What happens next:**
- Lessons not added
- Feature marked complete
- Move on

**When to skip:**
- Lessons aren't valuable
- Already covered by existing lessons
- Too generic or obvious

---

### Why This Gate Matters

**Lessons are your continuous improvement system.**

Good lessons:
- Prevent repeated mistakes
- Make future features faster
- Build institutional knowledge

Bad lessons:
- Create noise
- Waste time
- Get ignored

**This gate keeps lessons high quality.**

---

## Gate Workflow Patterns

### Normal Flow (Most Common)

```
1. Feature Definition → Approve
2. Execution Plan → Approve
3. [Implementation happens automatically]
4. Production Deploy → Approve
5. Learning Capture → Approve

Total interaction: 4 approvals
Total time: 2-5 minutes of your time
```

---

### Tight Control Flow

```
1. Feature Definition → Approve
2. Execution Plan → Approve
3. Phase 1 Complete → Approve
4. Phase 2 Complete → Approve
5. Phase 3 Complete → Approve
   ... (continue for each phase)
N. Production Deploy → Approve
N+1. Learning Capture → Approve

Total interaction: 4 + number of phases
```

---

### Cautious Flow

```
1. Feature Definition → Request changes → Approve
2. Execution Plan → Ask questions → Approve
3. [Implementation]
4. Production Deploy → Deploy to staging first
5. [Test on staging]
6. Production Deploy → Approve
7. Learning Capture → Edit lessons → Approve

Total interaction: 7+ interactions
```

---

## Best Practices

### For Users

**Do:**
- Read what AI presents carefully
- Ask questions if unclear
- Request changes when needed
- Approve when confident

**Don't:**
- Blindly approve without reading
- Skip gates to save time (defeats the purpose)
- Get annoyed by gates (they prevent bigger problems)

---

### For AI

**Do:**
- Present information clearly
- Explain reasoning
- Wait patiently for response
- Accept feedback gracefully

**Don't:**
- Present too much information (keep it scannable)
- Assume approval (always wait)
- Argue with user decisions
- Proceed without approval

---

## Gate Communication

### Clear Presentation

**Good:**
```
Feature Definition Complete

Requirements: [clear numbered list]
Acceptance Criteria: [clear list]

Does this match what you want?
Options: Approve / Request Changes / Pause
```

**Bad:**
```
I did the thing. Here's a bunch of text [walls of text]. Ok?
```

---

### Clear Response

**Good:**
```
You: "Approved"
You: "Change requirement 3 to say X instead of Y"
You: "Pause for now"
```

**Bad:**
```
You: "maybe ok I guess"
You: "idk do whatever"
```

---

## Handling Disagreements

**If you disagree with AI's approach:**

```
You: "I don't think JWT is the right choice here. Use session cookies instead."

AI: "Understood. I'll revise the execution plan to use session cookies instead of JWT.
     This will require adding session storage (Redis) and changing the auth middleware.
     Let me update the plan..."

AI: [Revises plan]
AI: "Here's the revised plan using session cookies. Should I proceed?"
```

**AI should accept your decisions** and adjust accordingly.

---

## When to Skip Gates (Never)

**Gates are not optional.**

Even if you're confident, gates serve these purposes:
1. Force you to think before acting
2. Create documentation trail
3. Build discipline
4. Prevent rushing

**If gates feel tedious, the problem isn't the gates.** The problem is unclear requirements or bad planning.

Fix the root cause, don't skip gates.

---

## Common Questions

### "Can I automate approvals?"

**No.**

Gates require human judgment. Automating defeats the purpose.

If you trust AI completely, you can enable fewer gates (e.g., disable per-phase gates).

But don't automate the core gates (feature definition, deployment).

---

### "What if I'm not available at a gate?"

AI waits. Work is paused at that gate.

When you return, AI presents the gate again, you approve, work continues.

**This is a feature, not a bug.** Important decisions shouldn't be rushed.

---

### "Can I approve multiple gates at once?"

**No.**

Each gate happens at its own time.

You can't pre-approve future gates because you don't know what will be presented yet.

---

### "What if I make a mistake at a gate?"

**You can reverse.**

Example: Approved deployment but it's broken.

```
You: "Rollback deployment"
AI: [Rolls back]
```

Or: Approved plan but realized better approach.

```
You: "Stop. Revise the plan to use X instead of Y"
AI: [Revises plan]
```

**Gates aren't irreversible.** But reversal is more expensive than getting it right the first time.

---

## Summary

**5 gates keep you in control:**

1. **Feature Definition** - Prevent building wrong thing
2. **Execution Planning** - Prevent bad approach
3. **Per-Phase** (optional) - Maximum control
4. **Production Deploy** - Prevent broken deployments
5. **Learning Capture** - Keep lessons valuable

**Each gate:**
- Presents clear information
- Asks clear question
- Gives clear options
- Waits for your response

**Gates balance:**
- AI autonomy (works between gates)
- Human control (approves at gates)

**Gates build:**
- Trust (through transparency)
- Quality (through validation)
- Discipline (through process)

**The framework only works if you use the gates properly.**

Read. Think. Approve or adjust.

Simple but essential.
