# System Map

**This document describes the high-level architecture of your system.**

AI reads this **before** scanning code to understand how components connect.

Humans read this to understand the system without diving into code.

**Keep this compact.** Focus on structure, not implementation details.

---

## Architecture Overview

### System Type

[Describe what kind of system this is]

**Example:**
```
Web application with:
- Frontend: React SPA
- Backend: Node.js API
- Database: PostgreSQL
- Deployment: Docker containers on AWS
```

### Architecture Pattern

[Describe the overall pattern]

**Example:**
```
Three-tier architecture:
1. Presentation Layer (React frontend)
2. Application Layer (Express API)
3. Data Layer (PostgreSQL + Redis cache)

RESTful API between frontend and backend.
JWT-based authentication.
```

---

## System Components

### Component Map

```
┌─────────────────────────────────────────────────┐
│                   Frontend                       │
│  (React SPA, served via CDN)                    │
│                                                  │
│  Components:                                     │
│  - Auth (login, signup)                         │
│  - Dashboard (task list, stats)                │
│  - TaskManager (CRUD operations)               │
└─────────────────┬───────────────────────────────┘
                  │
                  │ HTTPS/JSON
                  │
┌─────────────────▼───────────────────────────────┐
│                Backend API                       │
│  (Node.js + Express)                            │
│                                                  │
│  Modules:                                        │
│  - AuthService (handles authentication)         │
│  - TaskService (manages tasks)                  │
│  - UserService (user management)                │
│                                                  │
│  Middleware:                                     │
│  - JWT validation                                │
│  - Rate limiting                                 │
│  - Error handling                                │
└─────────────────┬───────────────────────────────┘
                  │
                  │ SQL queries
                  │
┌─────────────────▼───────────────────────────────┐
│              Database Layer                      │
│  (PostgreSQL + Redis)                           │
│                                                  │
│  PostgreSQL: Persistent data                    │
│  - users table                                   │
│  - tasks table                                   │
│  - sessions table                                │
│                                                  │
│  Redis: Caching & sessions                      │
│  - Session tokens                                │
│  - Rate limit counters                           │
└──────────────────────────────────────────────────┘
```

---

## Component Descriptions

### Frontend (React SPA)

**Purpose:** User interface

**Technology:** React 18, React Router, Axios for API calls

**Key Modules:**
- `src/components/Auth/` - Login and signup forms
- `src/components/Dashboard/` - Main dashboard view
- `src/components/TaskManager/` - Task CRUD operations
- `src/services/api.js` - API client (Axios instance)
- `src/context/AuthContext.js` - Authentication state management

**External Dependencies:**
- Hosted on Cloudflare CDN
- Calls backend API at `api.example.com`

**Authentication:**
- Receives JWT token from backend after login
- Stores token in localStorage
- Sends token in Authorization header for all requests

---

### Backend API (Node.js + Express)

**Purpose:** Business logic and data access

**Technology:** Node.js 20, Express 4, JWT, bcrypt

**Key Modules:**
- `src/services/AuthService.js` - User authentication logic
- `src/services/TaskService.js` - Task business logic
- `src/services/UserService.js` - User management logic
- `src/routes/auth.js` - Auth endpoints (/login, /signup, /logout)
- `src/routes/tasks.js` - Task endpoints (CRUD)
- `src/middleware/auth.js` - JWT validation middleware
- `src/middleware/rateLimiter.js` - Rate limiting middleware

**External Dependencies:**
- PostgreSQL database
- Redis for caching
- SendGrid for email (planned, not yet implemented)

**Port:** 3000 (internal), exposed via nginx reverse proxy

---

### Database Layer

**PostgreSQL:**
- **Purpose:** Persistent data storage
- **Version:** PostgreSQL 15
- **Tables:** See [data-model.md](data-model.md)
- **Hosted:** AWS RDS (production), local Docker (development)

**Redis:**
- **Purpose:** Session storage and caching
- **Version:** Redis 7
- **Usage:**
  - Session tokens (TTL: 30 days)
  - Rate limit counters (TTL: 10 minutes)
- **Hosted:** AWS ElastiCache (production), local Docker (development)

---

## Data Flow

### User Login Flow

```
1. User enters email/password in frontend
2. Frontend sends POST /api/auth/login
3. Backend AuthService:
   - Validates credentials
   - Checks rate limiting (Redis)
   - Generates JWT token
   - Stores session in Redis
4. Backend returns JWT token
5. Frontend stores token in localStorage
6. Frontend redirects to dashboard
```

### Task Creation Flow

```
1. User fills task form in frontend
2. Frontend sends POST /api/tasks with JWT token
3. Backend middleware validates JWT
4. Backend TaskService:
   - Validates task data
   - Inserts into PostgreSQL tasks table
5. Backend returns created task
6. Frontend updates task list
```

---

## Technology Stack

### Frontend
- **Framework:** React 18
- **Router:** React Router 6
- **State Management:** React Context + Hooks
- **HTTP Client:** Axios
- **Styling:** TailwindCSS
- **Build Tool:** Vite

### Backend
- **Runtime:** Node.js 20 LTS
- **Framework:** Express 4
- **Authentication:** JWT (jsonwebtoken library)
- **Password Hashing:** bcrypt
- **Validation:** express-validator
- **Database Client:** pg (PostgreSQL)
- **Redis Client:** ioredis

### Database
- **Primary DB:** PostgreSQL 15
- **Cache:** Redis 7

### DevOps
- **Containerization:** Docker + Docker Compose
- **CI/CD:** GitHub Actions
- **Hosting:** AWS (EC2 for backend, RDS for PostgreSQL, ElastiCache for Redis, CloudFront for frontend)
- **Web Server:** nginx (reverse proxy)

---

## External Dependencies

### APIs
- **SendGrid** (email service) - Planned, not yet integrated
- **Stripe** (payments) - Planned for premium features

### Libraries
- **bcrypt** - Password hashing
- **jsonwebtoken** - JWT handling
- **express-validator** - Input validation
- **pg** - PostgreSQL client
- **ioredis** - Redis client

---

## Environment Configuration

### Development
- Backend runs on `localhost:3000`
- Frontend runs on `localhost:5173` (Vite dev server)
- PostgreSQL runs in Docker on `localhost:5432`
- Redis runs in Docker on `localhost:6379`

### Production
- Backend behind nginx reverse proxy at `api.example.com`
- Frontend served via CloudFront CDN at `app.example.com`
- PostgreSQL on AWS RDS (private subnet)
- Redis on AWS ElastiCache (private subnet)

---

## Security Model

### Authentication
- **Method:** JWT tokens
- **Token Lifetime:** 30 days
- **Storage:** Frontend: localStorage, Backend: Redis
- **Refresh:** No refresh tokens yet (planned for future)

### Authorization
- **Model:** User-based (each user can only access their own data)
- **Implementation:** Middleware checks JWT, extracts userId, filters queries by userId

### Rate Limiting
- **Implemented on:** Auth endpoints (/login, /signup)
- **Limit:** 5 requests per 10 minutes per IP
- **Storage:** Redis counters
- **Response:** HTTP 429 Too Many Requests

### Password Security
- **Hashing:** bcrypt with 10 rounds
- **Validation:** Min 8 chars, must include number and special character
- **Storage:** Hashed passwords in PostgreSQL (never plaintext)

---

## Deployment Architecture

### Production Setup

```
Internet
  │
  ├─→ CloudFront CDN → S3 (frontend static files)
  │
  └─→ Route53 → ALB → nginx → Node.js API
                               │
                               ├─→ RDS PostgreSQL
                               └─→ ElastiCache Redis
```

### Deployment Process
1. Code pushed to `main` branch
2. GitHub Actions runs tests
3. If tests pass:
   - Frontend: Build → Upload to S3 → Invalidate CloudFront cache
   - Backend: Build Docker image → Push to ECR → Deploy to EC2 (via SSH)
4. Run database migrations (if needed)
5. Smoke tests on production

---

## Scaling Considerations

### Current Scale
- **Users:** < 100 (MVP stage)
- **Requests:** < 1000/day
- **Database:** < 10MB data

### Scaling Plan (when needed)
1. **Horizontal scaling:** Add more EC2 instances behind load balancer
2. **Database:** Read replicas for read-heavy queries
3. **Caching:** Increase Redis usage for frequently accessed data
4. **CDN:** Already using CloudFront for frontend

---

## Known Limitations

1. **No horizontal scaling yet** - Single EC2 instance for backend
2. **No database replication** - Single PostgreSQL instance
3. **No monitoring** - No APM, logging is basic
4. **No automated backups** - Manual database backups only
5. **No disaster recovery** - No failover plan

**These are acceptable for MVP. Address as scale requires.**

---

## Future Architecture Changes

### Planned
1. **Monitoring:** Add DataDog or equivalent APM
2. **Logging:** Centralized logging with CloudWatch
3. **Database Backups:** Automated daily backups to S3
4. **Email Service:** Integrate SendGrid for password resets
5. **Payments:** Integrate Stripe for premium features

### Under Consideration
1. **Microservices:** Split backend into separate services (if complexity grows)
2. **GraphQL:** Replace REST API with GraphQL (if frontend needs justify it)
3. **WebSockets:** Add real-time updates (if users need it)

---

## How to Update This Document

**When to update:**
- New component added (new service, new database)
- Architecture pattern changes (e.g., move from monolith to microservices)
- Technology changes (e.g., swap PostgreSQL for MongoDB)
- Deployment changes (e.g., move from AWS to GCP)
- New external dependency added

**What to update:**
- Component map (visual diagram)
- Component descriptions
- Data flow diagrams
- Technology stack list
- Deployment architecture

**What NOT to include:**
- Implementation code snippets
- Detailed API documentation (goes in service-map.md)
- Database schemas (goes in data-model.md)
- Step-by-step deployment commands

**Keep it high-level. Keep it scannable.**

---

## For AI: Reading This Document

**Before implementing any feature:**
1. Read this entire document
2. Understand where the feature fits in the architecture
3. Identify which components will be affected
4. Check if new components are needed
5. Verify technology stack is sufficient

**If this document is unclear or outdated:**
- Ask clarifying questions before proceeding
- Propose updates to this document
- Don't make architectural assumptions

**If implementing a feature requires architectural changes:**
- Propose the change clearly
- Explain impact on existing components
- Update this document before or during implementation
- Log the decision in decision-log.md

---

This is your technical map. Keep it current. Trust it completely.
