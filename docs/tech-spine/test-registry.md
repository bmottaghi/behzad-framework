# Test Registry

**Master list of all tests in the project.**

AI reads this to know which tests exist and how to run them.

This is the **permanent** test registry. When a feature is completed, its tests are transferred here from execution-plan.md.

---

## Summary

| Product | Unit Tests | Integration | E2E | Total |
|---------|------------|-------------|-----|-------|
| website | 0 | 0 | 0 | 0 |
| admin-panel | 0 | 0 | 0 | 0 |
| shared | 0 | 0 | 0 | 0 |
| **Total** | 0 | 0 | 0 | **0** |

> Update these counts when adding tests for completed features.

---

## Tests by Feature

### FEAT-000: Project Setup

**Products:** `[all]`
**Total Tests:** 0

*No tests - setup feature only.*

---

*Add new feature test entries here as features are completed.*

**Template for new entries:**

```markdown
### FEAT-XXX: [Feature Title]

**Products:** `[products]`
**Total Tests:** N

| Type | File | Count |
|------|------|-------|
| Unit | `tests/unit/...` | X |
| Integration | `tests/integration/...` | Y |
| E2E | `tests/e2e/...` | Z |

**Run Command:** `npm test -- --grep "FEAT-XXX"`
```

---

## Tests by Product

### Website Tests

**Path Patterns:**
- `tests/unit/web/**`
- `tests/integration/web/**`
- `tests/e2e/web/**`

**Run Command:** `npm test -- --project=web`

**Test Count:** 0

---

### Admin Panel Tests

**Path Patterns:**
- `tests/unit/admin/**`
- `tests/integration/admin/**`
- `tests/e2e/admin/**`

**Run Command:** `npm test -- --project=admin`

**Test Count:** 0

---

### Shared Tests

**Path Patterns:**
- `tests/unit/shared/**`
- `tests/integration/shared/**`

**Run Command:** `npm test -- --project=shared`

**Test Count:** 0

---

## How AI Uses This Document

### When Running Tests (Phase F5.5 or B4.5)

1. **Read this file** to understand existing tests
2. **Read component-map.md** to determine test boundaries
3. **Identify tests to run** based on changed files:
   - Shared layer changed → Run ALL tests
   - Single product changed → Run that product's tests
4. **Execute test commands** from this document

### When Completing a Feature (Phase F9)

1. **Copy Test Registry** from execution-plan.md
2. **Add new section** under "Tests by Feature"
3. **Update Summary table** counts
4. **Update "Tests by Product"** sections

---

## Test Commands Reference

| Scope | Command |
|-------|---------|
| All tests | `npm test` |
| Specific feature | `npm test -- --grep "FEAT-XXX"` |
| Website only | `npm test -- --project=web` |
| Admin only | `npm test -- --project=admin` |
| Shared only | `npm test -- --project=shared` |
| With coverage | `npm test -- --coverage` |

---

## Document Maintenance

**This document is updated when:**
- A feature is completed (add new test entry)
- Tests are added to existing features
- Test files are renamed or moved
- Test commands change

**Keep this document accurate.** AI relies on it to run the correct tests.
