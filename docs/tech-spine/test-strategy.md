# Test Strategy

**This document describes how we test our system.**

AI reads this to understand what needs to be tested and how.

Humans read this to understand our testing approach and coverage goals.

**Testing is not optional.** Every feature must have appropriate tests.

---

## Testing Philosophy

### Core Principles

1. **Tests are part of implementation** - Features aren't complete without tests
2. **Tests prevent regressions** - Test what breaks to prevent it breaking again
3. **Tests document behavior** - Tests show how the system should work
4. **Keep tests fast** - Slow tests don't get run
5. **Keep tests focused** - One test, one concern

### What We Test

**Must Test:**
- Business logic (all service methods)
- API endpoints (all request/response scenarios)
- Authentication and authorization
- Data validation
- Error handling

**Should Test:**
- UI components (critical user flows)
- Integration points (database, Redis, external APIs)
- Edge cases and error conditions

**Don't Test:**
- Third-party libraries (trust them)
- Configuration files
- Trivial getters/setters

---

## Test Types

### Unit Tests

**Purpose:** Test individual functions and methods in isolation

**Scope:** Single function or method

**Speed:** Very fast (< 10ms each)

**Coverage Goal:** 80%+ of business logic code

**Examples:**
- Test AuthService.validatePassword() with various inputs
- Test TaskService.createTask() with valid and invalid data
- Test utility functions (date formatting, validation, etc.)

**Tools:**
- Framework: Jest
- Mocking: Jest mocks
- Assertions: Jest expect()

**Location:** `tests/unit/`

---

### Integration Tests

**Purpose:** Test how components work together

**Scope:** Multiple components or layers

**Speed:** Moderate (100ms - 1s each)

**Coverage Goal:** All critical paths

**Examples:**
- Test API endpoint + Service + Database flow
- Test Auth middleware + AuthService + JWT validation
- Test full task creation flow (API → Service → Database)

**Tools:**
- Framework: Jest
- Database: Test database (Docker container)
- HTTP: Supertest for API testing

**Location:** `tests/integration/`

---

### End-to-End (E2E) Tests

**Purpose:** Test complete user workflows

**Scope:** Full system (frontend + backend + database)

**Speed:** Slow (5s - 30s each)

**Coverage Goal:** Critical user journeys only

**Examples:**
- User signs up → logs in → creates task → marks complete
- User logs in → views task list → deletes task
- User tries to access protected route without login

**Tools:**
- Framework: Playwright or Cypress
- Environment: Full stack running locally or in CI

**Location:** `tests/e2e/`

**Status:** Planned for post-MVP

---

## Test Coverage Goals

### Backend

| Component       | Unit Tests | Integration Tests | Target Coverage |
|-----------------|------------|-------------------|-----------------|
| Services        | ✅ Yes      | ✅ Yes             | 90%+            |
| Controllers     | ✅ Yes      | ✅ Yes             | 85%+            |
| Middleware      | ✅ Yes      | ✅ Yes             | 90%+            |
| Utilities       | ✅ Yes      | ❌ No              | 100%            |
| Routes          | ❌ No       | ✅ Yes             | 100%            |

**Overall Backend Coverage Goal:** 85%+

---

### Frontend

| Component       | Unit Tests | Integration Tests | E2E Tests |
|-----------------|------------|-------------------|-----------|
| Components      | ✅ Yes      | ❌ No              | ❌ No      |
| Services (API)  | ✅ Yes      | ✅ Yes             | ❌ No      |
| State (Context) | ✅ Yes      | ❌ No              | ❌ No      |
| User Flows      | ❌ No       | ❌ No              | ✅ Yes     |

**Overall Frontend Coverage Goal:** 70%+ (lower because E2E covers critical paths)

---

## Test Structure

### Unit Test Example

```javascript
// tests/unit/services/AuthService.test.js
describe('AuthService', () => {
  describe('validatePassword', () => {
    it('accepts valid password with number and special char', () => {
      const result = AuthService.validatePassword('SecurePass123!');
      expect(result.valid).toBe(true);
    });

    it('rejects password shorter than 8 characters', () => {
      const result = AuthService.validatePassword('Short1!');
      expect(result.valid).toBe(false);
      expect(result.error).toBe('Password must be at least 8 characters');
    });

    it('rejects password without number', () => {
      const result = AuthService.validatePassword('NoNumber!');
      expect(result.valid).toBe(false);
      expect(result.error).toBe('Password must include a number');
    });

    it('rejects password without special character', () => {
      const result = AuthService.validatePassword('NoSpecial123');
      expect(result.valid).toBe(false);
      expect(result.error).toBe('Password must include a special character');
    });
  });
});
```

---

### Integration Test Example

```javascript
// tests/integration/api/auth.test.js
describe('POST /api/auth/signup', () => {
  beforeEach(async () => {
    await clearDatabase(); // Clean slate for each test
  });

  it('creates user and returns token with valid data', async () => {
    const response = await request(app)
      .post('/api/auth/signup')
      .send({
        email: 'test@example.com',
        password: 'SecurePass123!'
      });

    expect(response.status).toBe(201);
    expect(response.body).toHaveProperty('token');
    expect(response.body.user.email).toBe('test@example.com');

    // Verify user was created in database
    const user = await db.query('SELECT * FROM users WHERE email = $1', ['test@example.com']);
    expect(user.rows).toHaveLength(1);
  });

  it('returns 400 for invalid email', async () => {
    const response = await request(app)
      .post('/api/auth/signup')
      .send({
        email: 'invalid-email',
        password: 'SecurePass123!'
      });

    expect(response.status).toBe(400);
    expect(response.body.error.code).toBe('INVALID_EMAIL');
  });

  it('returns 409 for duplicate email', async () => {
    // Create user first
    await AuthService.signUp('test@example.com', 'SecurePass123!');

    // Try to create same user again
    const response = await request(app)
      .post('/api/auth/signup')
      .send({
        email: 'test@example.com',
        password: 'DifferentPass456!'
      });

    expect(response.status).toBe(409);
    expect(response.body.error.code).toBe('DUPLICATE_EMAIL');
  });
});
```

---

## Test Data Management

### Test Database

**Setup:**
- Separate test database: `taskapp_test`
- Run migrations before tests
- Clear data between tests
- Use Docker container for isolation

**Approach:**
- `beforeAll`: Run migrations
- `beforeEach`: Clear all tables (or use transactions)
- `afterAll`: Tear down database connection

---

### Test Fixtures

**Location:** `tests/fixtures/`

**Purpose:** Reusable test data

**Examples:**
```javascript
// tests/fixtures/users.js
export const validUser = {
  email: 'test@example.com',
  password: 'SecurePass123!'
};

export const invalidPasswords = [
  'short',           // Too short
  'NoNumber!',       // No number
  'NoSpecial123',    // No special char
];

// tests/fixtures/tasks.js
export const validTask = {
  title: 'Test task',
  description: 'Test description',
  due_date: '2025-12-31'
};
```

---

## Continuous Integration

### Test Pipeline

**On every push:**
1. Lint code (ESLint)
2. Run unit tests
3. Run integration tests
4. Check code coverage
5. Fail build if coverage < 80%

**On pull request:**
1. All of the above
2. Run E2E tests (when implemented)

**Tools:**
- CI Platform: GitHub Actions
- Coverage Reports: Jest coverage reporter
- Coverage Tracking: Codecov or Coveralls

---

## Testing Checklist

When implementing a new feature, ensure:

**Backend:**
- [ ] Unit tests for all service methods
- [ ] Integration tests for API endpoints
- [ ] Test happy path (success cases)
- [ ] Test error cases (validation errors, not found, etc.)
- [ ] Test authentication/authorization (if applicable)
- [ ] Test rate limiting (if applicable)

**Frontend:**
- [ ] Unit tests for components with logic
- [ ] Test user interactions (clicks, form submissions)
- [ ] Test error states (loading, errors)
- [ ] Test edge cases (empty states, etc.)

---

## Testing Anti-Patterns (Avoid These)

### Don't: Test Implementation Details

**Bad:**
```javascript
it('calls database query with correct parameters', () => {
  // Testing HOW something works, not WHAT it does
});
```

**Good:**
```javascript
it('returns user tasks sorted by due date', () => {
  // Testing behavior, not implementation
});
```

---

### Don't: Write Flaky Tests

**Bad:**
```javascript
it('loads data', async () => {
  const data = await fetchData();
  setTimeout(() => {
    expect(data).toBeDefined(); // Race condition!
  }, 100);
});
```

**Good:**
```javascript
it('loads data', async () => {
  const data = await fetchData();
  expect(data).toBeDefined(); // Properly awaited
});
```

---

### Don't: Test Too Much in One Test

**Bad:**
```javascript
it('handles entire user flow', async () => {
  // 50 lines of test code testing 10 different things
});
```

**Good:**
```javascript
it('creates user successfully', async () => { ... });
it('logs in with valid credentials', async () => { ... });
it('fetches user tasks', async () => { ... });
```

---

## Mocking Strategy

### What to Mock

**Mock external dependencies:**
- Database (in unit tests, not integration tests)
- Redis
- External APIs (SendGrid, Stripe)
- Date/time (for consistent tests)

**Don't mock:**
- Your own code (defeats the purpose)
- Simple utilities (just test them)

---

### Mocking Examples

**Mock Database in Unit Test:**
```javascript
jest.mock('../../src/database', () => ({
  query: jest.fn()
}));

it('creates task successfully', async () => {
  const mockDb = require('../../src/database');
  mockDb.query.mockResolvedValue({ rows: [{ id: 'uuid', title: 'Test' }] });

  const task = await TaskService.createTask(userId, taskData);
  expect(task.id).toBe('uuid');
});
```

**Mock External API:**
```javascript
jest.mock('sendgrid', () => ({
  send: jest.fn().mockResolvedValue({ status: 200 })
}));
```

---

## Running Tests

### Commands

```bash
# Run all tests
npm test

# Run unit tests only
npm run test:unit

# Run integration tests only
npm run test:integration

# Run with coverage
npm run test:coverage

# Run in watch mode (development)
npm run test:watch

# Run specific test file
npm test -- path/to/test.js
```

---

### Test Environment

**Environment Variables:**
```
NODE_ENV=test
DATABASE_URL=postgresql://localhost:5432/taskapp_test
REDIS_URL=redis://localhost:6379/1
JWT_SECRET=test-secret
```

**Setup:**
1. Start test database (Docker)
2. Run migrations
3. Start Redis (Docker)
4. Run tests

---

## Test Maintenance

### When to Update Tests

**Update tests when:**
- Feature behavior changes
- Requirements change
- Bugs are fixed (add regression test)
- Acceptance criteria change

**Don't update tests when:**
- Refactoring code (tests should still pass if behavior unchanged)

---

### Removing Tests

**Remove tests when:**
- Feature is removed
- Test is redundant (covered by another test)
- Test is flaky and can't be fixed

**Document why** if removing a test.

---

## Coverage Reports

### What Coverage Means

**Line Coverage:** % of code lines executed by tests

**Branch Coverage:** % of if/else branches tested

**Function Coverage:** % of functions called by tests

**Statement Coverage:** % of statements executed

**Our Goal:**
- Line Coverage: 85%+
- Branch Coverage: 80%+
- Function Coverage: 90%+

---

### What Coverage Doesn't Mean

High coverage **does not guarantee** quality.

You can have 100% coverage with bad tests.

**Focus on:**
- Testing behavior, not implementation
- Testing edge cases
- Testing critical paths

**Coverage is a tool, not a goal.**

---

## Future Testing Improvements

**Planned:**
1. E2E tests with Playwright
2. Visual regression tests (screenshot comparison)
3. Performance testing (load testing critical endpoints)
4. Security testing (automated vulnerability scanning)

**Nice to Have:**
1. Mutation testing (test the tests)
2. Property-based testing (for complex logic)
3. Chaos engineering (test failure scenarios)

---

## How to Update This Document

**When to update:**
- Testing strategy changes
- New test types added
- Coverage goals change
- New tools adopted

**What to update:**
- Test type descriptions
- Coverage goals
- Examples
- Commands

**What NOT to include:**
- Actual test code (lives in tests/ folder)
- Test results (those are in CI)

---

## For AI: Reading This Document

**Before implementing a feature:**
1. Read this document to understand testing requirements
2. Plan tests as part of implementation (not after)
3. Ensure all test types are covered per checklist

**When writing tests:**
1. Follow the examples and patterns here
2. Ensure coverage goals are met
3. Test happy path and error cases
4. Keep tests focused and clear

**If feature needs new test approach:**
- Propose it clearly
- Explain why existing patterns don't fit
- Update this document with new pattern

**Run tests before completing feature:**
- All tests must pass
- Coverage must meet goals
- No skipped or pending tests

---

This is your testing truth. Test systematically. Ship confidently.
