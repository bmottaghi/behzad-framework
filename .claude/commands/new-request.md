I'm using behzad-framework to handle a new request: $ARGUMENTS

**FIRST, read framework documents:**
> Note: Framework docs are in .behzad/ folder (if installed as submodule)

1. Read: .behzad/philosophy.md (or philosophy.md)
2. Read: .behzad/deliver-flow.md (or deliver-flow.md)
3. Read: .behzad/decision-gates.md (or decision-gates.md)

**THEN, read project documents:**
4. Read: docs/product-system.md
5. Read: docs/tech-spine/ (all 5 files)
6. Read: docs/learning/lessons.md

**REQUEST:**
$ARGUMENTS

---

## PHASE 1: CLARIFICATION & CLASSIFICATION

**Step 1: Ask clarifying questions**

Ask these questions to understand the request:

For potential BUGS:
- What is the expected behavior?
- What is the actual behavior?
- Steps to reproduce?
- When did this start happening?
- Any error messages?
- Which part of the system is affected?

For potential FEATURES:
- Who needs this?
- What should it do?
- Why is it needed now?
- Any constraints or dependencies?

**Step 2: Classify the request**

Based on answers, determine if this is a BUG or FEATURE:

```
┌─────────────────────────────────────────────────────────┐
│ CLASSIFICATION RESULT                                    │
├─────────────────────────────────────────────────────────┤
│ Type: [BUG / FEATURE]                                   │
│                                                         │
│ Reasoning:                                              │
│ - [Key reason 1]                                        │
│ - [Key reason 2]                                        │
│                                                         │
│ Confidence: [High / Medium / Low]                       │
└─────────────────────────────────────────────────────────┘
```

**DECISION GATE 0:** Ask user to confirm classification:
"This appears to be a [BUG/FEATURE]. Do you confirm? Or would you like to:
1. CONFIRM - Proceed with this classification
2. CHANGE - Switch to [other type]
3. ABANDON - Cancel this request"

**If user says ABANDON/CANCEL:** Go to ABANDON FLOW below.

---

## IF BUG → Follow BUG FLOW (6 Phases)

### Phase B1: Bug Definition

Create entry in docs/product-system.md under "## Bugs" section:

```markdown
### BUG-XXX: [Title]
- Status: Investigating
- Priority: [P0/P1/P2]
- Reported: [Today's date]
- Related Feature: [FEAT-XXX if applicable]

**Description:** [What's wrong]

**Steps to Reproduce:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Expected Behavior:** [What should happen]
**Actual Behavior:** [What happens instead]

**Environment:** [Browser, OS, version if relevant]
```

**DECISION GATE 1:** Present bug definition:
"Here's the bug definition. Options:
1. APPROVE - Continue to root cause analysis
2. MODIFY - Change something in the definition
3. ABANDON - Cancel this bug fix"

### Phase B2: Root Cause Analysis

- Analyze affected components using tech-spine
- Search codebase for related code
- Identify the root cause
- Check lessons.md for similar past issues

Present findings:
```
Root Cause Analysis:
- Affected files: [list]
- Root cause: [description]
- Related lessons: [if any]
```

### Phase B3: Fix Planning

Create simple fix plan:
- What files need to change
- What the fix approach is
- What tests to add/update

**DECISION GATE 2:** Present fix plan:
"Here's the fix plan. Options:
1. APPROVE - Start implementation
2. MODIFY - Change the approach
3. ABANDON - Cancel this bug fix"

### Phase B4: Implementation

- Implement the fix
- Write/update regression tests
- Update tech-spine if architecture changes
- Run tests to verify

### Phase B5: Verification

- Verify bug is fixed
- Run full test suite
- Check for side effects
- Test the original reproduction steps

### Phase B6: Completion & Learning

- Update product-system.md: Status → "Fixed", add Fixed date
- Identify lessons learned
- Draft lessons in proper format

**DECISION GATE 3:** Present completion:
"Bug fixed. Lessons learned:
- [Lesson 1]
- [Lesson 2]

Options:
1. APPROVE - Add lessons and complete
2. MODIFY - Change lessons
3. SKIP LESSONS - Complete without lessons"

Update docs/learning/lessons.md if approved.

---

## IF FEATURE → Follow FEATURE FLOW (9 Phases)

### Phase F1: Requirement Clarification
- Act as Product Manager
- Ask detailed questions about Who, What, Why, When, Where, How, Constraints
- Continue until requirements are crystal clear

### Phase F2: Feature Definition

Create entry in docs/product-system.md under "## Features" section:

```markdown
### FEAT-XXX: [Title]
- Status: In Planning
- Priority: [P0/P1/P2]
- Created: [Today's date]

**Description:** [What this feature does]

**Requirements:**
1. [Requirement 1]
2. [Requirement 2]

**Acceptance Criteria:**
- [ ] [Criterion 1]
- [ ] [Criterion 2]

**Dependencies:** [Other features or systems]
```

**DECISION GATE 1:** Present feature definition:
"Here's the feature definition. Options:
1. APPROVE - Continue to technical analysis
2. MODIFY - Change requirements
3. ABANDON - Cancel this feature"

### Phase F3: Technical Impact Analysis
- Read tech-spine documents
- Analyze affected components
- Identify new components needed
- Check for breaking changes
- Review relevant lessons

### Phase F4: Execution Planning

Create phased plan in docs/execution/execution-plan.md:
- Each phase: 1-4 hours, clear goal, tests, checkpoint
- Phases must be resumable

**DECISION GATE 2:** Present execution plan:
"Here's the implementation plan. Options:
1. APPROVE - Start implementation
2. MODIFY - Change the plan
3. ABANDON - Cancel this feature"

### Phase F5: Implementation
- Execute phase by phase
- Write tests alongside code
- Update tech-spine as you go
- Mark phases complete in execution-plan.md

### Phase F6: Pre-Release Review
- Verify all acceptance criteria
- Run full test suite
- Confirm documentation updated
- Security and performance check

**DECISION GATE 3:** Present review:
"Pre-release review complete. Options:
1. APPROVE - Ready to deploy
2. FIX ISSUES - Address problems first
3. ABANDON - Cancel deployment"

### Phase F7: Deployment

**DECISION GATE 4:** Request deployment approval:
"Ready to deploy to production. Options:
1. DEPLOY - Proceed with deployment
2. WAIT - Not ready yet
3. ABANDON - Cancel"

- Deploy to production
- Create release tag

### Phase F8: Post-Deployment Validation
- Health check
- Smoke tests
- Monitor logs and metrics
- Validate feature works in production

### Phase F9: Learning Capture
- Identify lessons learned
- Draft lessons

**DECISION GATE 5:** Present lessons:
"Feature complete. Lessons learned:
- [Lesson 1]
- [Lesson 2]

Options:
1. APPROVE - Add lessons and complete
2. MODIFY - Change lessons
3. SKIP LESSONS - Complete without lessons"

Update product-system.md: Status → "Completed"

---

## ABANDON FLOW

When user says "abandon", "cancel", or "stop" at any gate:

1. **If before implementation (Phases B1-B3 or F1-F4):**
   - Update product-system.md entry with Status: "Abandoned"
   - Add note: "Abandoned at [phase] on [date]. Reason: User cancelled."
   - Confirm: "Request abandoned. No code changes were made."

2. **If during implementation (Phases B4-B5 or F5-F7):**
   - Ask: "Implementation has started. Do you want to:
     1. ROLLBACK - Undo all changes
     2. KEEP CHANGES - Keep work done so far (mark as 'Paused')
     3. CONTINUE - Actually, let's continue"
   - If ROLLBACK: Revert changes, mark as "Abandoned"
   - If KEEP: Mark as "Paused" for later continuation

3. **Always record in product-system.md:**
   - Status: Abandoned / Paused
   - Reason and phase where stopped

---

## IMPORTANT RULES

1. **ALWAYS** update documentation (product-system.md, lessons.md)
2. **ALWAYS** stop at decision gates and wait for explicit approval
3. **NEVER** skip phases - even for "simple" bugs
4. **NEVER** proceed without user approval at gates
5. **RESPECT** abandonment immediately - don't try to convince user to continue
6. **CLASSIFY** correctly - bugs fix broken behavior, features add new behavior
7. **DOCUMENT** everything - future you will thank present you
