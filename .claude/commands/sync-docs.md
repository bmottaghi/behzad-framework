I'm checking document consistency across the framework.

**READ ALL DOCUMENTS:**
1. docs/product-system.md
2. docs/tech-spine/system-map.md
3. docs/tech-spine/data-model.md
4. docs/tech-spine/service-map.md
5. docs/tech-spine/decision-log.md
6. docs/tech-spine/test-strategy.md
7. docs/execution/execution-plan.md
8. docs/learning/lessons.md

**CHECK FOR INCONSISTENCIES:**

1. **Feature References:**
   - Are all FEAT-IDs in execution-plan.md also in product-system.md?
   - Do lessons reference valid features?

2. **Component References:**
   - Do service-map APIs match system-map components?
   - Are data-model entities referenced in service-map?

3. **Status Consistency:**
   - Do execution-plan phases match product-system status?
   - Are "Completed" features fully documented?

4. **Decision Trail:**
   - Do tech-spine changes have decision-log entries?
   - Are major decisions documented?

**REPORT:**
```
Document Sync Report

✓ Passed Checks:
- [Check description]
- [Check description]

⚠ Warnings:
- [Warning description]
- [Warning description]

✗ Issues Found:
- [Issue description]
- [Issue description]

Recommendations:
1. [What to fix]
2. [What to update]
```

**ASK:**
"Would you like me to fix any of these issues automatically?"
