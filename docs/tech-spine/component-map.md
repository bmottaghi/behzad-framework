# Component Map

**This document defines which components are shared across products.**

AI reads this to determine test boundaries - which tests to run when something changes.

Humans read this to understand the system structure and dependencies between products.

---

## Products

Define your products here. Each product is a distinct deployable unit.

| Product | Path Pattern | Description | Test Command |
|---------|--------------|-------------|--------------|
| website | `/web/*`, `/frontend/*` | Main user-facing website | `npm test --project=web` |
| admin-panel | `/admin/*` | Admin dashboard | `npm test --project=admin` |
| android | `/android/*` | Android mobile app | `./gradlew test` |
| ios | `/ios/*` | iOS mobile app | `xcodebuild test` |

> **Note:** Update this table when you add new products to your project.

---

## Shared Layers

These layers are shared across ALL products. **Changes here require running ALL tests.**

| Layer | Path Pattern | Description | Affects |
|-------|--------------|-------------|---------|
| API | `/api/*`, `/src/api/*` | Backend API endpoints | ALL products |
| Database | `/database/*`, `/migrations/*` | Database schema and migrations | ALL products |
| Shared Utils | `/shared/*`, `/common/*`, `/lib/*` | Shared utilities and helpers | ALL products |
| Auth | `/auth/*`, `/src/auth/*` | Authentication and authorization | ALL products |
| Core Models | `/models/*`, `/src/models/*` | Core data models | ALL products |

> **Rule:** When ANY file in these paths changes, run the complete test suite.

---

## Product-Specific Layers

Changes here only require tests for that specific product.

| Product | Path Pattern | Test Command |
|---------|--------------|--------------|
| website | `/web/*`, `/frontend/*` | `npm test --project=web` |
| admin-panel | `/admin/*` | `npm test --project=admin` |
| android | `/android/*` | `./gradlew test` |
| ios | `/ios/*` | `xcodebuild test` |

> **Rule:** When files only in product-specific paths change, run only that product's tests.

---

## Test Boundary Rules

When making changes, follow these rules to determine which tests to run:

### Rule 1: Shared Layer Changed
If ANY changed file matches a Shared Layer path → **Run ALL product tests**

```
Changed: /api/auth/login.js
Result: Run ALL tests (API is shared layer)
```

### Rule 2: Single Product Changed
If ALL changed files are in ONE product's path → **Run only that product's tests**

```
Changed: /web/components/Button.js, /web/pages/Home.js
Result: Run website tests only
```

### Rule 3: Multiple Products Changed
If changed files are in MULTIPLE product paths → **Run tests for each affected product**

```
Changed: /web/pages/Home.js, /admin/Dashboard.js
Result: Run website tests AND admin tests
```

### Rule 4: Before Release
Before any production deployment → **Always run ALL tests**

---

## Example Scenarios

| Scenario | Files Modified | Tests to Run |
|----------|----------------|--------------|
| Fix login API bug | `/api/auth/login.js` | ALL (shared layer) |
| Update web button style | `/web/components/Button.css` | Website only |
| New Android screen | `/android/app/screens/Profile.kt` | Android only |
| Database migration | `/migrations/002_add_tasks.sql` | ALL (shared layer) |
| Update shared validator | `/shared/validators/email.js` | ALL (shared layer) |
| Web + Admin feature | `/web/feature.js`, `/admin/feature.js` | Website + Admin |

---

## How AI Uses This Document

Before running tests (Phase F5.5 or B4.5), AI should:

1. **List changed files**
   ```
   git diff --name-only HEAD~1
   ```

2. **Check each file against Shared Layer patterns**
   - If ANY match → Run ALL tests

3. **If no shared layer matches, check Product-Specific patterns**
   - Run tests only for matched products

4. **Execute appropriate test command(s)**

### Decision Flow

```
Changed Files
     │
     ▼
┌────────────────┐
│ Any file in    │──YES──▶ Run ALL tests
│ Shared Layer?  │
└────────────────┘
     │ NO
     ▼
┌────────────────┐
│ Which products │──▶ Run tests for
│ are affected?  │    each affected product
└────────────────┘
```

---

## Customizing This Document

### When to Update

Update this document when:
- Adding a new product
- Adding a new shared layer
- Changing test commands
- Restructuring project paths

### How to Update

1. **Adding a Product:**
   - Add row to Products table
   - Add row to Product-Specific Layers table
   - Add example to Example Scenarios

2. **Adding a Shared Layer:**
   - Add row to Shared Layers table
   - Consider if existing products need test updates

---

## Notes

- This document is **project-specific** - customize paths and commands for your project
- When in doubt, run ALL tests - it's safer than missing regressions
- Test commands should be documented in your project's README or package.json

---

This document ensures efficient testing while preventing regressions across products.
