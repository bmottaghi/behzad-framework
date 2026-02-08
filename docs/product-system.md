# Product System

**This is the single source of product truth.**

Everything about what your product is, what features it has, and their status lives here.

Non-technical leaders should be able to read this and understand the complete product state.

AI reads this before planning any feature.

---

## Product Vision

### What We're Building

[Describe your product in 2-3 sentences. What problem does it solve? Who is it for?]

**Example:**
```
We're building a task management app for solo entrepreneurs.
It helps them organize their work without the complexity of enterprise tools.
The focus is simplicity and speed.
```

### Core Principles

[List 3-5 principles that guide product decisions]

**Example:**
```
1. Simple over powerful - Only essential features
2. Fast over fancy - Speed matters more than animations
3. Offline-first - Must work without internet
4. Privacy-focused - No tracking, no ads
```

### Success Metrics

[Define how you measure success]

**Example:**
```
- User retention: 60%+ after 30 days
- Task completion rate: 80%+
- Load time: < 2 seconds
- Mobile-friendly: Works on phones without app
```

---

## Features

### How to Read This

**Status:**
- `Planned` - Defined but not started
- `In Planning` - Being clarified and planned
- `In Progress` - Currently being built
- `Testing` - Built, being validated
- `Completed` - Shipped and live
- `On Hold` - Paused temporarily
- `Cancelled` - Not doing this anymore

**Priority:**
- `P0` - Critical, blocks other work
- `P1` - Important, near-term delivery
- `P2` - Valuable, medium-term
- `P3` - Nice to have, long-term

---

## Active Features

### FEAT-001: User Authentication

**Status:** In Progress
**Priority:** P0
**Started:** 2025-01-15
**Target:** 2025-01-20

**Description:**

Allow users to create accounts and log in with email and password.

**Requirements:**

1. Users can sign up with email and password
2. Email must be validated (valid format, not disposable domains)
3. Password must be >= 8 characters, include number and special char
4. Users can log in with email and password
5. Users can log out
6. Sessions last 30 days
7. Failed login attempts are rate-limited (max 5 per 10 minutes)

**Acceptance Criteria:**

- [ ] Sign up form works and creates user in database
- [ ] Email validation prevents invalid emails
- [ ] Password validation enforces requirements
- [ ] Login form works with correct credentials
- [ ] Login fails with wrong credentials (clear error message)
- [ ] Logout clears session
- [ ] Rate limiting prevents brute force attacks
- [ ] User stays logged in for 30 days (unless they log out)

**Technical Notes:**

- Requires new `users` table (see tech-spine/data-model.md)
- Using bcrypt for password hashing
- JWT tokens for sessions
- Rate limiting via middleware (see tech-spine/service-map.md)

**Related Lessons:**

- Lesson 12: Auth endpoints need rate limiting
- Lesson 15: Research dependencies upfront

**Related Research:**

- docs/research/auth-best-practices.md

**Current Phase:** Phase 3 of 6 (see execution/execution-plan.md)

---

## Planned Features

### FEAT-002: Task Creation

**Status:** Planned
**Priority:** P0
**Estimated Start:** 2025-01-21

**Description:**

Users can create tasks with title, description, and due date.

**Requirements:**

1. Users must be logged in to create tasks
2. Task must have a title (required, max 200 chars)
3. Task can have description (optional, max 2000 chars)
4. Task can have due date (optional)
5. Tasks are saved to user's account
6. Tasks appear in task list immediately

**Acceptance Criteria:**

- [ ] Create task form appears when user clicks "New Task"
- [ ] Title field is required and validated
- [ ] Description field is optional and validated
- [ ] Due date picker works (calendar UI)
- [ ] Task saves to database when form submitted
- [ ] Task appears in user's task list
- [ ] Error handling for failed saves

**Dependencies:**

- Requires FEAT-001 (User Authentication) to be completed

**Questions to Clarify:**

- Should tasks have tags or categories?
- Should users be able to set priority on tasks?
- Should there be task templates?

**Next Step:**

Once FEAT-001 is complete, start requirement clarification for this feature.

---

### FEAT-003: Task List View

**Status:** Planned
**Priority:** P1
**Estimated Start:** 2025-01-23

**Description:**

Users can view all their tasks in a list, sorted and filtered.

**Requirements:**

1. Display all user's tasks in a list
2. Show task title, due date, completion status
3. Sort by: due date, created date, priority
4. Filter by: completed/incomplete, overdue
5. Pagination if more than 50 tasks

**Acceptance Criteria:**

- [ ] Task list loads on dashboard
- [ ] Tasks display correctly with all info
- [ ] Sorting works (due date, created, priority)
- [ ] Filtering works (status, overdue)
- [ ] Pagination works if needed
- [ ] Empty state shows when no tasks

**Dependencies:**

- Requires FEAT-002 (Task Creation)

---

## Completed Features

### FEAT-000: Project Setup

**Status:** Completed
**Priority:** P0
**Completed:** 2025-01-10

**Description:**

Initialize project repository, set up development environment, configure basic tooling.

**What Was Delivered:**

- Git repository created
- Framework structure initialized (docs/, tech-spine/, etc.)
- Development environment configured
- Basic CI/CD pipeline set up

**Lessons Learned:**

- Lesson 10: Document environment setup steps (see tech-spine/system-map.md)

---

## On Hold Features

*No features currently on hold.*

---

## Bugs

### How to Read This

**Status:**
- `Reported` - Newly reported, not yet investigated
- `Investigating` - Being analyzed to find root cause
- `In Progress` - Fix is being implemented
- `Fixed` - Fix deployed and verified
- `Won't Fix` - Decided not to fix (with reason)
- `Abandoned` - Work cancelled before completion

**Priority:**
- `P0` - Critical, blocks users, fix immediately
- `P1` - Important, affects many users, fix soon
- `P2` - Minor, workaround exists, fix when convenient

---

### Active Bugs

*No active bugs currently.*

---

### Fixed Bugs

#### BUG-000: Example Bug Entry

**Status:** Fixed
**Priority:** P1
**Reported:** 2025-01-10
**Fixed:** 2025-01-11
**Related Feature:** FEAT-001

**Description:** Login button doesn't respond on mobile devices.

**Steps to Reproduce:**
1. Open app on mobile browser
2. Enter email and password
3. Tap "Login" button
4. Nothing happens

**Expected Behavior:** User should be logged in and redirected to dashboard.

**Actual Behavior:** Button shows no response, user stays on login page.

**Root Cause:** CSS z-index issue caused overlay to block button on mobile.

**Fix:** Adjusted z-index values in login form CSS.

**Lessons Learned:** Lesson 20: Test all interactive elements on mobile before release.

---

### Won't Fix

*No bugs marked as won't fix.*

---

### Abandoned

*No abandoned bug fixes.*

---

## Cancelled Features

### FEAT-999: Social Media Integration

**Status:** Cancelled
**Priority:** P3
**Cancelled:** 2025-01-12
**Reason:** Out of scope for MVP. Adds complexity without clear value.

**Original Description:**

Share tasks to Twitter/Facebook.

**Why Cancelled:**

- Core users don't need this
- Adds external dependencies
- Doesn't align with privacy-focused principle

---

## Feature Request Inbox

This is where vague ideas go before becoming defined features.

Once clarified and prioritized, they move to "Planned Features" section.

### Idea: Recurring Tasks

**From:** User feedback
**Date:** 2025-01-14

**Description:**

Allow tasks to repeat (daily, weekly, monthly).

**Questions:**

- How often do users need this?
- What's the complexity vs value?
- Should this be MVP or post-MVP?

**Status:** Researching

---

### Idea: Task Collaboration

**From:** Product vision
**Date:** 2025-01-13

**Description:**

Allow multiple users to collaborate on tasks.

**Questions:**

- Does this fit our "solo entrepreneur" target?
- What's the scope? (Sharing? Assigning? Comments?)

**Status:** On hold until post-MVP

---

## How to Use This Document

### As a Product Leader

**To check feature status:**
- Look at "Active Features" to see what's being built
- Look at "Planned Features" to see what's next
- Look at "Completed Features" to see what's shipped

**To add a new feature:**
1. Add to "Feature Request Inbox" with description
2. Clarify questions and requirements
3. Prioritize and move to "Planned Features"
4. Start delivery when ready (follows deliver-flow.md)

### As AI (Claude Code)

**Before planning a feature:**
1. Read this entire document
2. Understand product vision and principles
3. Check if feature already exists (don't duplicate)
4. Check dependencies (what must be done first?)
5. Read related lessons and research

**When starting a feature:**
1. Move from "Planned" to "In Planning"
2. Follow deliver-flow.md for requirement clarification
3. Update this document with clarified requirements
4. Move to "In Progress" when implementation starts

**When completing a feature:**
1. Mark all acceptance criteria as complete
2. Move from "In Progress" to "Completed"
3. Add completion date
4. Add "Lessons Learned" section
5. Update "Related Lessons" if new lessons were captured

**When blocking a feature:**
1. Move to "On Hold" with clear reason
2. Document what needs to happen to unblock

**When cancelling a feature:**
1. Move to "Cancelled Features"
2. Document why (prevents re-proposing the same thing)

---

## Notes on Acceptance Criteria

Good acceptance criteria are:
- **Specific** - "User can log in" not "Auth works"
- **Testable** - Can verify pass/fail clearly
- **User-focused** - Describes user behavior, not implementation
- **Complete** - Covers happy path and edge cases

Bad acceptance criteria are:
- **Vague** - "System is fast"
- **Technical** - "Database query optimized"
- **Incomplete** - Only covers happy path

**AI must ensure acceptance criteria are good before implementation.**

If criteria are unclear, AI asks questions to clarify.

---

## Document Maintenance

**This document is living.**

It gets updated with every feature.

If it's not up to date, the framework doesn't work.

**Update rules:**
1. Feature status changes → update immediately
2. Requirements change → update acceptance criteria
3. Feature completed → move to "Completed Features"
4. New feature idea → add to "Feature Request Inbox"

**Don't let this document get stale.**

---

## Example: Complete Feature Lifecycle

Here's what a feature looks like through its full lifecycle in this document:

**Day 1:** Added to "Feature Request Inbox"
```markdown
### Idea: Dark Mode
**From:** User request
**Status:** Needs clarification
```

**Day 2:** Clarified, moved to "Planned Features"
```markdown
### FEAT-025: Dark Mode
**Status:** Planned
**Priority:** P2
(Requirements defined, acceptance criteria added)
```

**Day 5:** Implementation starts
```markdown
**Status:** In Progress
**Started:** 2025-01-20
**Current Phase:** Phase 2 of 4
```

**Day 7:** Implementation completes
```markdown
**Status:** Completed
**Completed:** 2025-01-22
**Lessons Learned:** Lesson 18: CSS variable approach works well for themes
```

**Always current. Always clear.**

---

This document is your product source of truth.

Keep it updated. Read it often. Trust it completely.
