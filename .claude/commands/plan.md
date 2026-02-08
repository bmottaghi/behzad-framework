I'm viewing/updating the execution plan for: $ARGUMENTS

**READ:**
1. Read: docs/product-system.md - Find the feature
2. Read: docs/execution/execution-plan.md - Current plan

**IF FEAT-ID PROVIDED ($ARGUMENTS is not empty):**

Find the execution plan for $ARGUMENTS and present:
```
Execution Plan: $ARGUMENTS - [Feature Title]

Phases:
┌─────────┬──────────────────────┬────────────┬─────────┐
│ Phase   │ Description          │ Status     │ Tests   │
├─────────┼──────────────────────┼────────────┼─────────┤
│ 1       │ [Phase 1 goal]       │ ✓ Complete │ ✓ Pass  │
│ 2       │ [Phase 2 goal]       │ → Current  │ Pending │
│ 3       │ [Phase 3 goal]       │ Pending    │ Pending │
│ 4       │ [Phase 4 goal]       │ Pending    │ Pending │
└─────────┴──────────────────────┴────────────┴─────────┘

Current Phase Details:
- Goal: [Current phase goal]
- Scope: [What's included]
- Tests: [Test requirements]
- Checkpoint: [Validation criteria]
```

**OPTIONS:**
1. Continue with current phase
2. Modify the plan
3. Add a new phase
4. View phase details

**IF NO FEAT-ID PROVIDED:**
Show the current active execution plan, or report "No active execution plan. Use /new-request to start a feature."

**IF PLAN NOT FOUND:**
Report: "No execution plan found for $ARGUMENTS. The feature may not have reached Phase 4 yet."
