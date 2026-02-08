I'm updating the tech-spine documents to reflect current code state.

**READ CURRENT STATE:**
1. Read: docs/tech-spine/system-map.md
2. Read: docs/tech-spine/data-model.md
3. Read: docs/tech-spine/service-map.md
4. Read: docs/tech-spine/decision-log.md
5. Read: docs/tech-spine/test-strategy.md

**ANALYZE CODEBASE:**
Scan the current codebase to detect:
- New components or services
- Changed data models or schemas
- New or modified APIs
- Updated dependencies
- New test patterns

**COMPARE AND REPORT:**
```
Tech-Spine Sync Report

system-map.md:
- [+] New: [component]
- [~] Changed: [component]
- [-] Removed: [component]

data-model.md:
- [+] New: [entity/table]
- [~] Changed: [entity/table]

service-map.md:
- [+] New: [service/API]
- [~] Changed: [service/API]

test-strategy.md:
- [~] Coverage: X% → Y%
```

**ASK:**
"Would you like me to update the tech-spine documents with these changes?"

**IF APPROVED:**
Update each document and present:
- What was updated
- What might need manual review
- Any decisions that should be logged
