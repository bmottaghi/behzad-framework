# Service Map

**This document describes your services, APIs, external dependencies, and how they interact.**

AI reads this to understand what services exist and how to use them.

Humans read this to understand the service architecture without diving into code.

**Keep this synchronized with your actual services and APIs.**

---

## Internal Services

Services are logical modules within your backend that handle specific business logic.

### AuthService

**Purpose:** User authentication and authorization

**Location:** `src/services/AuthService.js`

**Responsibilities:**
- User registration (sign up)
- User login (authentication)
- Password validation
- JWT token generation
- Session management

**Key Methods:**

```javascript
async signUp(email, password)
  → Returns: { user, token }
  → Throws: ValidationError, DuplicateEmailError

async login(email, password)
  → Returns: { user, token }
  → Throws: InvalidCredentialsError, RateLimitError

async validateToken(token)
  → Returns: { userId, email }
  → Throws: InvalidTokenError, ExpiredTokenError

async logout(userId, tokenId)
  → Returns: { success: true }
```

**Dependencies:**
- bcrypt (password hashing)
- jsonwebtoken (JWT generation/validation)
- Redis (session storage)
- PostgreSQL (user data)

**Used By:**
- Auth API endpoints (`/api/auth/*`)
- Auth middleware (for protecting routes)

---

### UserService

**Purpose:** User profile management

**Location:** `src/services/UserService.js`

**Responsibilities:**
- Fetch user profile
- Update user profile
- Deactivate user account

**Key Methods:**

```javascript
async getUser(userId)
  → Returns: { id, email, created_at, ... }
  → Throws: UserNotFoundError

async updateUser(userId, updates)
  → Returns: { updated user }
  → Throws: ValidationError

async deactivateUser(userId)
  → Returns: { success: true }
```

**Dependencies:**
- PostgreSQL (user data)

**Used By:**
- User API endpoints (`/api/users/*`)

---

### TaskService

**Purpose:** Task management business logic

**Location:** `src/services/TaskService.js`

**Responsibilities:**
- Create tasks
- Fetch user's tasks
- Update tasks
- Mark tasks complete/incomplete
- Delete tasks

**Key Methods:**

```javascript
async createTask(userId, { title, description, due_date })
  → Returns: { created task }
  → Throws: ValidationError

async getUserTasks(userId, { filter, sort })
  → Returns: [ tasks ]
  → Options:
    - filter: 'all' | 'completed' | 'incomplete' | 'overdue'
    - sort: 'due_date' | 'created_at' | 'title'

async updateTask(taskId, userId, updates)
  → Returns: { updated task }
  → Throws: TaskNotFoundError, ValidationError

async markComplete(taskId, userId, isCompleted)
  → Returns: { updated task }

async deleteTask(taskId, userId)
  → Returns: { success: true }
  → Throws: TaskNotFoundError
```

**Dependencies:**
- PostgreSQL (task data)

**Used By:**
- Task API endpoints (`/api/tasks/*`)

---

## API Endpoints

### Auth Endpoints

**Base Path:** `/api/auth`

---

#### POST /api/auth/signup

**Purpose:** Register a new user

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "SecurePass123!"
}
```

**Response (201 Created):**
```json
{
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "created_at": "2025-01-15T10:30:00Z"
  },
  "token": "jwt-token-here"
}
```

**Errors:**
- `400` - Validation error (invalid email, weak password)
- `409` - Email already exists
- `500` - Server error

**Rate Limit:** 5 requests per 10 minutes per IP

**Notes:**
- Password must meet validation rules (see data-model.md)
- Token expires in 30 days
- Email validation prevents disposable domains

---

#### POST /api/auth/login

**Purpose:** Authenticate existing user

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "SecurePass123!"
}
```

**Response (200 OK):**
```json
{
  "user": {
    "id": "uuid",
    "email": "user@example.com"
  },
  "token": "jwt-token-here"
}
```

**Errors:**
- `401` - Invalid credentials
- `429` - Rate limit exceeded (too many login attempts)
- `500` - Server error

**Rate Limit:** 5 requests per 10 minutes per IP

**Notes:**
- Rate limiting prevents brute force attacks
- Failed attempts are logged (for security monitoring)

---

#### POST /api/auth/logout

**Purpose:** Log out user (invalidate token)

**Headers:**
```
Authorization: Bearer {token}
```

**Response (200 OK):**
```json
{
  "success": true
}
```

**Errors:**
- `401` - Invalid or missing token
- `500` - Server error

**Notes:**
- Currently a no-op (stateless JWT)
- Will invalidate session when session table is implemented

---

### Task Endpoints

**Base Path:** `/api/tasks`

**Authentication:** All endpoints require valid JWT token in Authorization header

---

#### GET /api/tasks

**Purpose:** Fetch user's tasks

**Headers:**
```
Authorization: Bearer {token}
```

**Query Parameters:**
- `filter` (optional): `all` | `completed` | `incomplete` | `overdue`
  - Default: `all`
- `sort` (optional): `due_date` | `created_at` | `title`
  - Default: `due_date`

**Response (200 OK):**
```json
{
  "tasks": [
    {
      "id": "uuid",
      "title": "Write documentation",
      "description": "Complete README",
      "due_date": "2025-01-20",
      "is_completed": false,
      "created_at": "2025-01-15T14:00:00Z",
      "updated_at": "2025-01-15T14:00:00Z"
    }
  ],
  "total": 1
}
```

**Errors:**
- `401` - Invalid or missing token
- `500` - Server error

---

#### POST /api/tasks

**Purpose:** Create a new task

**Headers:**
```
Authorization: Bearer {token}
```

**Request Body:**
```json
{
  "title": "Write documentation",
  "description": "Complete README file",
  "due_date": "2025-01-20"
}
```

**Response (201 Created):**
```json
{
  "task": {
    "id": "uuid",
    "user_id": "uuid",
    "title": "Write documentation",
    "description": "Complete README file",
    "due_date": "2025-01-20",
    "is_completed": false,
    "created_at": "2025-01-15T14:00:00Z",
    "updated_at": "2025-01-15T14:00:00Z"
  }
}
```

**Errors:**
- `400` - Validation error (missing title, invalid date)
- `401` - Invalid or missing token
- `500` - Server error

---

#### PATCH /api/tasks/:id

**Purpose:** Update a task

**Headers:**
```
Authorization: Bearer {token}
```

**Request Body (all fields optional):**
```json
{
  "title": "Updated title",
  "description": "Updated description",
  "due_date": "2025-01-25",
  "is_completed": true
}
```

**Response (200 OK):**
```json
{
  "task": {
    "id": "uuid",
    "title": "Updated title",
    ...
  }
}
```

**Errors:**
- `400` - Validation error
- `401` - Invalid or missing token
- `404` - Task not found or doesn't belong to user
- `500` - Server error

---

#### DELETE /api/tasks/:id

**Purpose:** Delete a task

**Headers:**
```
Authorization: Bearer {token}
```

**Response (200 OK):**
```json
{
  "success": true
}
```

**Errors:**
- `401` - Invalid or missing token
- `404` - Task not found or doesn't belong to user
- `500` - Server error

---

## Middleware

### Auth Middleware

**Purpose:** Validate JWT tokens and protect routes

**Location:** `src/middleware/auth.js`

**Usage:**
```javascript
router.get('/api/tasks', authMiddleware, taskController.getTasks);
```

**Behavior:**
1. Extract token from Authorization header
2. Validate token (check signature, expiration)
3. Extract userId from token
4. Attach `req.userId` for use by route handler
5. If invalid: return 401 Unauthorized

**Used By:** All protected routes (tasks, user profile, etc.)

---

### Rate Limiter Middleware

**Purpose:** Prevent abuse by limiting request rates

**Location:** `src/middleware/rateLimiter.js`

**Configuration:**
- Max requests: 5 per 10 minutes
- Storage: Redis counters
- Scope: Per IP address per endpoint

**Behavior:**
1. Check Redis counter for `rate_limit:{endpoint}:{ip}`
2. If counter >= limit: return 429 Too Many Requests
3. Increment counter
4. Set TTL (10 minutes)

**Used By:**
- `/api/auth/login`
- `/api/auth/signup`

---

### Error Handler Middleware

**Purpose:** Centralized error handling and formatting

**Location:** `src/middleware/errorHandler.js`

**Behavior:**
1. Catch errors from routes
2. Format error response consistently
3. Log errors for debugging
4. Return appropriate HTTP status code

**Error Format:**
```json
{
  "error": {
    "message": "Human-readable error message",
    "code": "ERROR_CODE",
    "details": { }
  }
}
```

---

## External Dependencies

### PostgreSQL Database

**Purpose:** Persistent data storage

**Connection:**
- Host: AWS RDS (production), localhost (development)
- Port: 5432
- Database: `taskapp`
- User: `taskapp_user`

**Connection Pooling:**
- Library: `pg` (node-postgres)
- Pool size: 20 connections
- Idle timeout: 30 seconds

**Error Handling:**
- Connection errors → Retry with exponential backoff
- Query errors → Logged and returned as 500 errors

---

### Redis Cache

**Purpose:** Session storage, rate limiting, caching

**Connection:**
- Host: AWS ElastiCache (production), localhost (development)
- Port: 6379
- Library: `ioredis`

**Usage:**
- Session tokens (TTL: 30 days)
- Rate limit counters (TTL: 10 minutes)

**Error Handling:**
- Redis down → Degrade gracefully (skip caching, disable rate limiting temporarily)
- Log errors for monitoring

---

### SendGrid (Planned, Not Implemented)

**Purpose:** Email delivery

**Use Cases:**
- Password reset emails
- Welcome emails
- Notification emails

**Configuration:**
- API Key: Stored in environment variable
- From email: noreply@example.com

**Status:** Not yet integrated

---

### Stripe (Planned, Not Implemented)

**Purpose:** Payment processing

**Use Cases:**
- Premium subscription billing
- One-time feature purchases

**Status:** Not yet integrated

---

## Service Communication

### Within Backend

**Pattern:** Direct function calls (monolithic architecture)

**Example:**
```javascript
// In AuthController
const { user, token } = await AuthService.signUp(email, password);
```

**No inter-service communication** - All services in same Node.js process

---

### Frontend to Backend

**Protocol:** HTTPS with JSON

**Authentication:** JWT tokens in Authorization header

**Example Request:**
```http
GET /api/tasks HTTP/1.1
Host: api.example.com
Authorization: Bearer eyJhbGci...
Content-Type: application/json
```

**CORS Configuration:**
- Allowed origins: `app.example.com` (production), `localhost:5173` (development)
- Allowed methods: GET, POST, PATCH, DELETE
- Allowed headers: Authorization, Content-Type

---

## API Versioning

**Current:** No versioning (MVP)

**Future Plan:**
- Version 1: `/api/v1/tasks`
- Version 2: `/api/v2/tasks`
- Deprecation policy: 6 months notice before removing old version

---

## Error Handling Strategy

### HTTP Status Codes

- `200 OK` - Successful GET, PATCH, DELETE
- `201 Created` - Successful POST
- `400 Bad Request` - Validation error
- `401 Unauthorized` - Missing or invalid token
- `404 Not Found` - Resource doesn't exist
- `409 Conflict` - Resource already exists (e.g., duplicate email)
- `429 Too Many Requests` - Rate limit exceeded
- `500 Internal Server Error` - Server error

### Error Response Format

```json
{
  "error": {
    "message": "Email already exists",
    "code": "DUPLICATE_EMAIL",
    "details": {
      "email": "user@example.com"
    }
  }
}
```

---

## Logging

**Library:** Built-in console (planned: Winston or Pino)

**Log Levels:**
- `ERROR` - Errors requiring attention
- `WARN` - Warnings (degraded performance, deprecated features)
- `INFO` - General info (server start, requests)
- `DEBUG` - Debugging info (development only)

**What Gets Logged:**
- All API requests (method, path, status code, duration)
- Authentication failures (for security monitoring)
- Database errors
- Rate limit events

**Log Format (planned):**
```json
{
  "timestamp": "2025-01-15T14:30:00Z",
  "level": "INFO",
  "message": "Request completed",
  "meta": {
    "method": "GET",
    "path": "/api/tasks",
    "status": 200,
    "duration": 45
  }
}
```

---

## Monitoring & Health Checks

### Health Endpoint

**Endpoint:** `GET /health`

**Purpose:** Check if service is alive

**Response (200 OK):**
```json
{
  "status": "healthy",
  "timestamp": "2025-01-15T14:30:00Z",
  "uptime": 86400,
  "dependencies": {
    "database": "connected",
    "redis": "connected"
  }
}
```

**Used By:** Load balancer, monitoring systems

---

## Performance Benchmarks

### Current Performance (MVP)

**Response Times (p95):**
- GET /api/tasks: < 50ms
- POST /api/tasks: < 100ms
- POST /api/auth/login: < 150ms (bcrypt hashing)

**Throughput:**
- ~100 requests/second (single instance)

**Bottlenecks:**
- None currently (small user base)

---

## How to Update This Document

**When to update:**
- New service added
- New API endpoint added
- Endpoint behavior changed
- External dependency added or changed
- Middleware added or modified

**What to update:**
- Service descriptions
- API endpoint documentation
- Request/response examples
- Error codes
- External dependencies

**What NOT to include:**
- Implementation code (lives in codebase)
- Deployment commands
- Database schemas (goes in data-model.md)

---

## For AI: Reading This Document

**Before implementing a feature:**
1. Read this document to understand existing services and APIs
2. Check if the feature requires new endpoints
3. Identify which services will be affected
4. Verify authentication and authorization requirements

**If implementing a feature requires service changes:**
1. Propose new endpoints or service methods clearly
2. Document request/response formats
3. Update this document before or during implementation
4. Ensure error handling is consistent

**If this document is unclear:**
- Ask questions before proceeding
- Propose updates to improve clarity

---

This is your service truth. Keep it synchronized with your code.
