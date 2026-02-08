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
- Which product(s) does this affect? (website/admin-panel/android/all)

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

## IF BUG → Follow BUG FLOW (7 Phases)

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

### Phase B7: Git Commit & Push (Mandatory)

**This phase is MANDATORY - cannot be skipped.**

1. **Check Git Repository**
   - Check if `.git` folder exists
   - If NO: Run `git init`

2. **Check Remote**
   - Run: `git remote -v`
   - If NO remote configured:
     - Ask user: "No GitHub remote found. Please enter your repository URL:"
     - Run: `git remote add origin <url>`

3. **Commit Changes**
   - Stage relevant files: `git add .`
   - Commit with message:
     ```
     fix(BUG-XXX): [Bug title]

     - [What was fixed]
     - Delivered via behzad-framework
     ```

4. **Push to Remote**
   - Run: `git push -u origin <current-branch>`
   - If push fails: Report error and ask user for resolution

5. **Confirm Success**
   - Show: Commit hash, branch name, remote URL
   - "✅ Changes pushed to [remote URL]"

---

## IF FEATURE → Follow FEATURE FLOW (10 Phases)

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
- Products: `[website, admin-panel, android]`
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

### Phase F2.5: Roadmap Update

After feature is approved, update the Roadmap section in product-system.md:

1. Add feature to appropriate section based on priority:
   - P0/P1 → Add to PLANNED section
   - P2/P3 → Add to BACKLOG section

2. Include Products tag in the roadmap entry:
   ```
   PLANNED:
   ├─ P0 (Critical)
   │   └─ FEAT-XXX: [Title] `[products]`
   ```

3. If feature has dependencies → Add to DEPENDENCIES section:
   ```
   DEPENDENCIES:
   - FEAT-XXX requires FEAT-YYY
   ```

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
- **Update Test Registry** in execution-plan.md:
  - Add each test file with test count
  - Mark test status (Pass/Fail)
  - Update coverage numbers after test runs

### Phase F5.5: Full Test Suite Verification (Mandatory)

**This phase is MANDATORY - cannot be skipped.**

Before proceeding to Pre-Release Review:

1. **Read docs/tech-spine/test-registry.md** to see all existing tests
2. **Read docs/tech-spine/component-map.md** to determine test boundaries
3. **Identify which tests to run** based on changed files:
   - If ANY file in Shared Layer changed → Run ALL tests
   - If only Product-Specific files changed → Run that product's tests
4. **Run appropriate tests:**
   - Command: `npm test` or project's test command
5. **Check results:**
   - If ALL tests pass → Continue to Phase F6
   - If ANY test fails:
     - Stop and report which tests failed
     - If previous feature's tests fail → **Regression detected**
     - Fix all failing tests before continuing
     - Re-run full test suite
6. **Update Test Registry** in execution-plan.md with final results

**Why this matters:** New features should never break existing functionality.

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

Update product-system.md:
- Status → "Completed"
- **Update Roadmap section:**
  - Move feature from PLANNED/IN PROGRESS to COMPLETED
  - Format: `- FEAT-XXX: [Title] \`[products]\` ✓`

**Transfer Test Registry to permanent storage:**
1. Read Test Registry section from execution-plan.md
2. Add new entry to docs/tech-spine/test-registry.md under "Tests by Feature"
3. Update Summary table counts in test-registry.md
4. Update "Tests by Product" sections if needed

### Phase F10: Git Commit & Push (Mandatory)

**This phase is MANDATORY - cannot be skipped.**

1. **Check Git Repository**
   - Check if `.git` folder exists
   - If NO: Run `git init`

2. **Check Remote**
   - Run: `git remote -v`
   - If NO remote configured:
     - Ask user: "No GitHub remote found. Please enter your repository URL:"
     - Run: `git remote add origin <url>`

3. **Commit Changes**
   - Stage relevant files: `git add .`
   - Commit with message:
     ```
     feat(FEAT-XXX): [Feature title]

     - [Summary of what was added]
     - Delivered via behzad-framework
     ```

4. **Push to Remote**
   - Run: `git push -u origin <current-branch>`
   - If push fails: Report error and ask user for resolution

5. **Confirm Success**
   - Show: Commit hash, branch name, remote URL
   - "✅ Feature delivered and pushed to [remote URL]"

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
8. **ALWAYS** run full test suite before completion - prevent regressions
9. **ALWAYS** commit and push to Git - no work is complete without version control
10. **ALWAYS** check for GitHub remote - ask for URL if not configured
11. **ALWAYS** update Roadmap when creating, starting, or completing features
12. **ALWAYS** update Test Registry in execution-plan.md as you write tests
13. **ALWAYS** check component-map.md to determine which tests to run
14. **ALWAYS** transfer tests from execution-plan.md to test-registry.md when feature completes
15. **ALWAYS** read test-registry.md before running tests to know all existing tests
