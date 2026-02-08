Listing features with filter: $ARGUMENTS

**READ:**
Read: docs/product-system.md

**IF FILTER PROVIDED ($ARGUMENTS is not empty):**

Filter can be: status (planned, in-progress, completed, paused), priority (P0, P1, P2), or keyword search.

```
Features matching: $ARGUMENTS

┌──────────┬─────────────────────────┬────────────┬──────────┐
│ ID       │ Title                   │ Status     │ Priority │
├──────────┼─────────────────────────┼────────────┼──────────┤
│ FEAT-001 │ [Title]                 │ Completed  │ P0       │
│ FEAT-002 │ [Title]                 │ In Progress│ P1       │
└──────────┴─────────────────────────┴────────────┴──────────┘

Total: X features
```

**IF NO FILTER PROVIDED:**

Show all features grouped by status:
```
All Features

## In Progress (X)
- FEAT-003: [Title] (P0) - Phase 2 of 4

## Planned (X)
- FEAT-004: [Title] (P1)
- FEAT-005: [Title] (P2)

## Completed (X)
- FEAT-001: [Title] (P0)
- FEAT-002: [Title] (P1)

## Paused (X)
- FEAT-006: [Title] (P1) - Paused at Phase 3

Total: X features
```

**QUICK ACTIONS:**
- Use `/status FEAT-ID` for details
- Use `/continue FEAT-ID` to resume work
- Use `/deliver [feature]` to add new feature
