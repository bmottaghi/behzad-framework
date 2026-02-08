I'm rolling back feature: $ARGUMENTS

**READ STATE:**
1. Read: docs/product-system.md - Find the feature
2. Read: docs/tech-spine/decision-log.md - Deployment history

**VERIFY:**
- Is $ARGUMENTS currently deployed?
- What version is in production?
- What version should we rollback to?

**PRESENT ROLLBACK PLAN:**
```
Rollback Plan: $ARGUMENTS

Current State:
- Deployed Version: [version]
- Deployed Date: [date]

Rollback To:
- Previous Version: [version]
- From Date: [date]

Affected Components:
- [List components that will change]

Rollback Steps:
1. [Step 1]
2. [Step 2]
3. [Step 3]
```

**CONFIRMATION:**
```
⚠️  ROLLBACK CONFIRMATION

This will revert $ARGUMENTS to the previous version.

Type 'ROLLBACK' to confirm, or 'CANCEL' to abort.
```

**AFTER ROLLBACK:**
1. Update product-system.md status
2. Log decision in decision-log.md
3. Create lesson in lessons.md (what went wrong?)
4. Update tech-spine if needed

**IF NOT DEPLOYED:**
Report: "Feature $ARGUMENTS is not currently deployed. Nothing to rollback."
