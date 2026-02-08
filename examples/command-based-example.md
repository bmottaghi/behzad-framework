# Command-Based Feature Delivery Example

**Same feature delivery as [feature-delivery-example.md](feature-delivery-example.md), but using commands.**

This shows how commands simplify the interaction while achieving the same systematic result.

---

## Context

**Project:** Task management app for solo entrepreneurs

**Existing State:**
- Users can sign up and log in (FEAT-001 complete)
- Basic task creation works (FEAT-002 complete)
- Task list displays tasks (FEAT-003 complete)

**New Feature:** Add task prioritization (P1, P2, P3)

---

## Comparison: Commands vs Prompts

### Old Way (Prompt-Based)

```
I'm using behzad-framework.

I want to deliver: Task prioritization

Read:
- docs/product-system.md
- docs/tech-spine/ (all files)
- docs/learning/lessons.md

Follow deliver-flow.md.
Stop at decision gates.
```

### New Way (Command-Based)

```
/deliver task prioritization
```

**Same result. One line.**

---

## Complete Delivery Using Commands

### Step 1: Start Delivery

**User:**
```
/deliver task prioritization with P1/P2/P3 levels
```

**AI:**
```
Starting feature delivery: task prioritization with P1/P2/P3 levels

I've read the framework documents and project state.

Let me ask some clarifying questions about task prioritization:

1. Priority Levels: You mentioned P1/P2/P3. Should these be labeled as High/Medium/Low?

2. Default Priority: When users create a task without setting priority, what's the default?

3. Visual Indication: How should priority be displayed? (Color coding? Icons? Text?)

4. Sorting: Should users be able to sort tasks by priority?

5. Filtering: Should users be able to filter to show only specific priorities?

6. Editing: Can users change priority after task creation?

7. Existing Tasks: What happens to existing tasks that don't have priority?
```

**User:**
```
1) Yes, P1=High, P2=Medium, P3=Low
2) Default is P2
3) Color coding: red/yellow/green plus text label
4) Yes, sorting
5) Yes, filtering
6) Yes, can change anytime
7) Existing tasks get P2 default
```

---

### Step 2: Decision Gate 1 - Feature Definition

**AI:**
```
Feature Definition Complete: FEAT-004 Task Prioritization

I've created the feature definition in docs/product-system.md.

Requirements:
1. Tasks have priority field: P1 (High), P2 (Medium), P3 (Low)
2. Default priority is P2 when creating new tasks
3. Priority displayed with color coding:
   - P1: Red
   - P2: Yellow
   - P3: Green
4. Priority label shown (e.g., "P1 High")
5. Users can sort task list by priority
6. Users can filter task list by priority
7. Users can change task priority after creation
8. Existing tasks migrated to P2 default

Acceptance Criteria:
- [ ] Priority selector in task creation form
- [ ] Priority defaults to P2
- [ ] Color-coded priority display
- [ ] Sort by priority works
- [ ] Filter by priority works
- [ ] Edit priority works
- [ ] Migration adds P2 to existing tasks

Does this match what you want?
```

**User:**
```
Approved
```

---

### Step 3: Technical Analysis & Planning

**AI:**
```
Technical Impact Analysis complete.
Creating execution plan...

Execution Plan: FEAT-004 Task Prioritization

Phase 1: Database Migration (1 hour)
Phase 2: Backend - TaskService (1-2 hours)
Phase 3: Backend - API Endpoints (1-2 hours)
Phase 4: Frontend - Priority Selector (1-2 hours)
Phase 5: Frontend - Display & Controls (2 hours)
Phase 6: Deployment & Validation (1 hour)

Total: 7-10 hours across 6 phases

Risks identified: Low
Lessons applied: #009 (validate on backend), #001 (add indexes)

Should I proceed with this plan?
```

**User:**
```
Approved
```

---

### Step 4: Implementation

**AI:**
```
Starting Phase 1: Database Migration
✅ Created migration file
✅ Added priority column with P2 default
✅ Added index for performance
✅ Checkpoint validated: 127 existing tasks migrated to P2

Starting Phase 2: Backend - TaskService
✅ Updated createTask() with priority
✅ Updated updateTask() with priority
✅ Added priority validation
✅ 8 new unit tests passing

Starting Phase 3: Backend - API Endpoints
✅ Updated POST /api/tasks
✅ Updated GET /api/tasks with sort/filter
✅ Updated PATCH /api/tasks/:id
✅ 6 new integration tests passing

Starting Phase 4: Frontend - Priority Selector
✅ Added priority dropdown to TaskForm
✅ Default value P2
✅ Component tests passing

Starting Phase 5: Frontend - Display & Controls
✅ Created PriorityBadge component
✅ Added color coding (red/yellow/green)
✅ Added sort control
✅ Added filter control
✅ All frontend tests passing

All implementation phases complete.

Pre-Release Review:
✅ All 8 acceptance criteria verified
✅ 82 tests passing (40 unit, 24 integration, 18 frontend)
✅ Code coverage: 89%
✅ Tech-spine documents updated
✅ Security: Priority validated on backend

Ready to deploy?
```

**User:**
```
Deploy to staging first
```

---

### Step 5: Staging Deployment

**AI:**
```
Deploying to staging...

✅ Migration successful on staging (1,247 tasks migrated)
✅ Code deployed
✅ Smoke tests passing

Staging URL: https://staging.taskapp.example.com

Please test and confirm when ready for production.
```

**User:**
```
Looks good. Deploy to production
```

---

### Step 6: Production Deployment

**AI:**
```
Deploying to production...

✅ Release tag created: v1.4.0
✅ Migration successful (12,458 tasks migrated)
✅ Code deployed
✅ Health check passed
✅ Smoke tests passed
✅ No errors in logs

Feature is live: https://app.taskapp.example.com

Updating product-system.md: FEAT-004 = Completed

Moving to Learning Capture...
```

---

### Step 7: Learning Capture

**AI:**
```
Feature Delivery Complete: FEAT-004

Proposed lessons to capture:

Lesson 013: Consider UI Performance Early
→ Memoize components in lists with 50+ items

Lesson 014: Database Migrations Should Include Rollback
→ Always create UP and DOWN scripts together

Lesson 015: Verify Accessibility for Visual Features
→ Check contrast and color-blindness accessibility early

Should I add these lessons?
```

**User:**
```
Yes, add all three
```

**AI:**
```
✅ Added 3 lessons to docs/learning/lessons.md
✅ FEAT-004 marked as Completed
✅ Execution plan cleared

Feature Delivery Complete!

Summary:
- Duration: 8 hours
- Phases: 6/6 complete
- Tests: 82 total
- Lessons: 3 captured

Ready for next feature!
```

---

## Checking Status with Commands

At any point, use `/status` to check progress:

**User:**
```
/status FEAT-004
```

**AI:**
```
Feature: FEAT-004 - Task Prioritization
Status: Completed
Priority: P1

Progress:
- Phase 1: ✅ Complete - Database Migration
- Phase 2: ✅ Complete - Backend TaskService
- Phase 3: ✅ Complete - Backend API Endpoints
- Phase 4: ✅ Complete - Frontend Priority Selector
- Phase 5: ✅ Complete - Frontend Display & Controls
- Phase 6: ✅ Complete - Deployment & Validation

Deployed: v1.4.0 (2025-01-22)
Lessons Captured: 3 (013, 014, 015)
```

---

## Resuming Paused Work

If you need to pause and resume later:

**User:**
```
/pause
```

**AI:**
```
Work paused. Current state saved.

Paused at: Phase 3 - Backend API Endpoints
In progress: Writing integration tests
To resume: /continue FEAT-004

All progress is saved. You can safely close this session.
```

Later:

**User:**
```
/continue FEAT-004
```

**AI:**
```
Resuming: FEAT-004 - Task Prioritization

Last completed: Phase 2 - Backend TaskService
Next phase: Phase 3 - Backend API Endpoints
Overall progress: 2 of 6 phases complete

Continuing with Phase 3...
```

---

## Command Summary Used

| Step | Command | Purpose |
|------|---------|---------|
| Start | `/deliver task prioritization` | Begin feature delivery |
| Check | `/status FEAT-004` | View progress |
| Pause | `/pause` | Save and stop |
| Resume | `/continue FEAT-004` | Pick up where left off |

---

## Comparison: Full Conversation

### Prompt-Based (Feature Delivery Example)

- Initial prompt: **5 lines** with explicit file reading instructions
- Every interaction requires understanding the framework format

### Command-Based (This Example)

- Initial command: **1 line**
- Same systematic result
- Commands are self-documenting

---

## When to Use Which

### Use Commands (Recommended)

```
/deliver user authentication
/continue FEAT-001
/status
/show-lessons auth
```

Simple, fast, less to remember.

### Use Full Prompts (Advanced)

When you need:
- Custom instructions beyond standard flow
- Specific modifications to the process
- Edge cases not covered by commands

Example:
```
I'm using behzad-framework.

Deliver user authentication, but SKIP the staging deployment
and go straight to production (we don't have staging environment yet).

Follow deliver-flow.md with that modification.
```

---

## Key Takeaways

1. **Commands do the same thing** - Just simpler to type

2. **Same decision gates** - You still approve at key points

3. **Same documents** - Product-system.md, tech-spine, lessons

4. **Same systematic process** - 9 phases, quality gates, learning capture

5. **Commands expand to prompts** - Behind the scenes, same framework runs

**Start with commands. Fall back to prompts when needed.**

---

## Quick Reference

```
Start new feature:    /deliver [description]
Resume feature:       /continue [FEAT-ID]
Check progress:       /status [FEAT-ID]
Pause work:           /pause
View lessons:         /show-lessons [tags]
Get help:             /help
```

See [command-guide.md](../command-guide.md) for all commands.
