Checking status for: $ARGUMENTS

**READ:**
1. docs/product-system.md - All features
2. docs/execution/execution-plan.md - Current work

**IF FEAT-ID PROVIDED ($ARGUMENTS is not empty):**

Find the feature in product-system.md and present:
```
Feature: $ARGUMENTS - [Title]
Status: [In Planning / In Progress / Completed / Paused]
Priority: [P0/P1/P2]

Progress:
- Phase 1: [Complete/In Progress/Pending]
- Phase 2: [Complete/In Progress/Pending]
- ...

Current Phase: [Phase name and description]
Last Activity: [Date/time if available]
Blockers: [Any blockers noted]

Next Steps:
- [What needs to happen next]
```

**IF NO FEAT-ID PROVIDED ($ARGUMENTS is empty):**

Present overall project status:
```
Project Status Overview

Features by Status:
- Completed: X features
- In Progress: X features
- Planned: X features
- Paused: X features

Currently Active:
- [FEAT-ID]: [Title] - Phase X of Y

Recently Completed:
- [FEAT-ID]: [Title]
- [FEAT-ID]: [Title]

Up Next (by priority):
- [FEAT-ID]: [Title] (P0)
- [FEAT-ID]: [Title] (P1)

Lessons Captured: X total
```

**IF FEATURE NOT FOUND:**
Report: "Feature $ARGUMENTS not found. Use /list-features to see all features."
