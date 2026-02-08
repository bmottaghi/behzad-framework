Showing the feature roadmap.

**READ:**
Read: docs/product-system.md (focus on Roadmap section)

**PRESENT ROADMAP:**
```
Feature Roadmap

Products: [website] [admin-panel] [android] [all]
─────────────────────────────────────────────────

COMPLETED ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
│
├─ FEAT-001: [Title] `[products]` ✓
├─ FEAT-002: [Title] `[products]` ✓
│
IN PROGRESS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
│
├─ FEAT-003: [Title] `[products]` ▶ Phase 2/4
│
PLANNED ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
│
├─ P0 (Critical)
│   ├─ FEAT-004: [Title] `[products]`
│   └─ FEAT-005: [Title] `[products]`
│
├─ P1 (Important)
│   ├─ FEAT-006: [Title] `[products]`
│   └─ FEAT-007: [Title] `[products]`
│
└─ P2 (Nice to Have)
    ├─ FEAT-008: [Title] `[products]`
    └─ FEAT-009: [Title] `[products]`

Summary:
- Completed: X features
- In Progress: X features
- Planned: X features
- Total: X features
```

**DEPENDENCIES (if documented):**
```
Dependencies:
- FEAT-005 depends on FEAT-004
- FEAT-007 depends on FEAT-003
```

**FILTER BY PRODUCT (optional):**
If user wants to see features for a specific product:
```
/show-roadmap website
/show-roadmap admin-panel
/show-roadmap android
```
Show only features that include that product in their Products tag.

**QUICK ACTIONS:**
- Use `/new-request [description]` to add new feature or bug
- Use `/status FEAT-ID` for feature details
- Use `/continue FEAT-ID` to start working
