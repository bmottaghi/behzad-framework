# Data Model

**This document describes your data structures, database schema, and relationships.**

AI reads this to understand what data exists and how it's organized.

Humans read this to understand the data model without reading database migration files.

**Keep this synchronized with your actual database.**

---

## Database Overview

**Primary Database:** PostgreSQL 15

**Purpose:** Persistent storage for all application data

**Schema Versioning:** Managed via migration files (see `migrations/` folder in codebase)

**Current Schema Version:** 1.0.0 (updated: 2025-01-15)

---

## Tables

### users

Stores user account information.

**Purpose:** User authentication and profile data

| Column       | Type         | Constraints           | Description                      |
|--------------|--------------|-----------------------|----------------------------------|
| id           | UUID         | PRIMARY KEY           | Unique user identifier           |
| email        | VARCHAR(255) | UNIQUE, NOT NULL      | User's email (login identifier)  |
| password_hash| VARCHAR(255) | NOT NULL              | bcrypt hashed password           |
| created_at   | TIMESTAMP    | NOT NULL, DEFAULT NOW | When user signed up              |
| updated_at   | TIMESTAMP    | NOT NULL, DEFAULT NOW | Last profile update              |
| is_active    | BOOLEAN      | NOT NULL, DEFAULT TRUE| Account active status            |

**Indexes:**
- `idx_users_email` on `email` (for login lookups)

**Example Data:**
```sql
id: 'a1b2c3d4-...'
email: 'user@example.com'
password_hash: '$2b$10$...'
created_at: '2025-01-15 10:30:00'
updated_at: '2025-01-15 10:30:00'
is_active: true
```

**Notes:**
- Passwords are hashed with bcrypt (10 rounds)
- Email is unique constraint (prevents duplicate accounts)
- Soft delete pattern (is_active flag, never hard delete users)

---

### tasks

Stores user tasks.

**Purpose:** Task management data

| Column       | Type         | Constraints                | Description                      |
|--------------|--------------|----------------------------|----------------------------------|
| id           | UUID         | PRIMARY KEY                | Unique task identifier           |
| user_id      | UUID         | FOREIGN KEY (users.id)     | Owner of this task               |
| title        | VARCHAR(200) | NOT NULL                   | Task title                       |
| description  | TEXT         | NULL                       | Optional task description        |
| due_date     | DATE         | NULL                       | Optional due date                |
| is_completed | BOOLEAN      | NOT NULL, DEFAULT FALSE    | Completion status                |
| created_at   | TIMESTAMP    | NOT NULL, DEFAULT NOW      | When task was created            |
| updated_at   | TIMESTAMP    | NOT NULL, DEFAULT NOW      | Last task update                 |
| completed_at | TIMESTAMP    | NULL                       | When task was marked complete    |

**Indexes:**
- `idx_tasks_user_id` on `user_id` (for fetching user's tasks)
- `idx_tasks_due_date` on `due_date` (for sorting by due date)
- `idx_tasks_is_completed` on `is_completed` (for filtering completed/incomplete)

**Example Data:**
```sql
id: 'e5f6g7h8-...'
user_id: 'a1b2c3d4-...'
title: 'Write documentation'
description: 'Complete the README file for the project'
due_date: '2025-01-20'
is_completed: false
created_at: '2025-01-15 14:00:00'
updated_at: '2025-01-15 14:00:00'
completed_at: NULL
```

**Notes:**
- Each task belongs to exactly one user (foreign key)
- Tasks are never hard deleted (implement soft delete if needed)
- completed_at is set when is_completed changes to true

---

### sessions (planned, not yet implemented)

Will store user sessions for enhanced security.

**Purpose:** Track active user sessions

| Column       | Type         | Constraints           | Description                      |
|--------------|--------------|-----------------------|----------------------------------|
| id           | UUID         | PRIMARY KEY           | Unique session identifier        |
| user_id      | UUID         | FOREIGN KEY (users.id)| User this session belongs to     |
| token_hash   | VARCHAR(255) | UNIQUE, NOT NULL      | Hashed JWT token                 |
| expires_at   | TIMESTAMP    | NOT NULL              | Session expiration               |
| created_at   | TIMESTAMP    | NOT NULL, DEFAULT NOW | When session was created         |
| ip_address   | VARCHAR(45)  | NULL                  | User's IP (for security tracking)|
| user_agent   | TEXT         | NULL                  | Browser/device info              |

**Notes:**
- Currently using stateless JWT (no session table yet)
- This table is planned for future to enable session revocation
- Will allow "logout all devices" functionality

---

## Data Relationships

### Entity-Relationship Diagram

```
┌─────────────────┐
│     users       │
│─────────────────│
│ id (PK)         │
│ email           │
│ password_hash   │
│ created_at      │
│ updated_at      │
│ is_active       │
└────────┬────────┘
         │
         │ 1:N
         │
         ▼
┌─────────────────┐
│     tasks       │
│─────────────────│
│ id (PK)         │
│ user_id (FK)    │
│ title           │
│ description     │
│ due_date        │
│ is_completed    │
│ created_at      │
│ updated_at      │
│ completed_at    │
└─────────────────┘
```

**Relationships:**
- One user can have many tasks (1:N)
- Each task belongs to one user
- Tasks are deleted if user is deleted (CASCADE)

---

## Redis Data Structures

**Purpose:** Caching and session storage

**Server:** Redis 7

### Session Tokens

**Key Pattern:** `session:{userId}:{tokenId}`

**Value:** JWT token string

**TTL:** 30 days (2,592,000 seconds)

**Example:**
```
Key: "session:a1b2c3d4-...:xyz123"
Value: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
TTL: 2592000
```

**Purpose:** Store active session tokens for validation

---

### Rate Limit Counters

**Key Pattern:** `rate_limit:{endpoint}:{ip}`

**Value:** Integer counter

**TTL:** 10 minutes (600 seconds)

**Example:**
```
Key: "rate_limit:login:192.168.1.1"
Value: 3
TTL: 600
```

**Purpose:** Track request counts for rate limiting

---

## Data Validation Rules

### User Data

**email:**
- Must be valid email format
- Must not be from disposable email domains
- Maximum 255 characters
- Unique across all users

**password:**
- Minimum 8 characters
- Must include at least one number
- Must include at least one special character
- Stored as bcrypt hash (never plaintext)

---

### Task Data

**title:**
- Required (cannot be null or empty)
- Maximum 200 characters
- No HTML allowed (sanitized on input)

**description:**
- Optional (can be null)
- Maximum 2000 characters
- No HTML allowed (sanitized on input)

**due_date:**
- Optional (can be null)
- Must be valid date
- Can be in the past (no restriction)

---

## Common Queries

### Fetch User's Tasks

```sql
SELECT * FROM tasks
WHERE user_id = $1
AND is_completed = false
ORDER BY due_date ASC NULLS LAST;
```

**Index Used:** `idx_tasks_user_id`, `idx_tasks_is_completed`, `idx_tasks_due_date`

---

### Create New Task

```sql
INSERT INTO tasks (id, user_id, title, description, due_date)
VALUES ($1, $2, $3, $4, $5)
RETURNING *;
```

---

### Mark Task Complete

```sql
UPDATE tasks
SET is_completed = true, completed_at = NOW(), updated_at = NOW()
WHERE id = $1 AND user_id = $2
RETURNING *;
```

---

### Find User by Email

```sql
SELECT * FROM users
WHERE email = $1 AND is_active = true;
```

**Index Used:** `idx_users_email`

---

## Database Migrations

**Migration System:** Custom migration scripts (planned: migrate library or similar)

**Migration Files Location:** `migrations/` folder in codebase

**Naming Convention:** `YYYYMMDD_HHMMSS_description.sql`

**Example:**
- `20250115_100000_create_users_table.sql`
- `20250115_103000_create_tasks_table.sql`

**Migration Process:**
1. Create new migration file
2. Write SQL for schema change
3. Test migration on development database
4. Run migration on production during deployment
5. Update this document to reflect changes

---

## Backup Strategy

**Current:** Manual backups only

**Planned:**
- Automated daily backups to S3
- Retention: 30 days
- Point-in-time recovery enabled

---

## Data Growth Estimates

### Current (MVP)
- Users: < 100
- Tasks per user: ~50
- Total tasks: < 5,000
- Database size: < 10 MB

### 6 Months
- Users: ~1,000
- Tasks per user: ~100
- Total tasks: ~100,000
- Database size: ~100 MB

### 1 Year
- Users: ~10,000
- Tasks per user: ~200
- Total tasks: ~2,000,000
- Database size: ~1 GB

**No scaling concerns at these sizes.**

---

## Performance Considerations

### Current Performance

**Query Performance:**
- Task list query: < 10ms
- User lookup by email: < 5ms
- Task creation: < 10ms

**Bottlenecks:**
- None currently (small dataset)

### Future Optimizations (if needed)

1. **Partitioning:** Partition tasks table by user_id if dataset grows
2. **Archiving:** Move completed tasks older than 1 year to archive table
3. **Read Replicas:** Add read replicas if read load increases
4. **Caching:** Cache frequently accessed data in Redis

---

## Data Privacy & Compliance

### Personal Data

**What we store:**
- Email addresses
- Task titles and descriptions

**What we DON'T store:**
- Passwords in plaintext (only bcrypt hashes)
- Payment information (not implemented yet)
- Tracking cookies or analytics data

### GDPR Compliance (if applicable)

**User Rights:**
- Right to access: Users can export their data (planned)
- Right to deletion: Users can delete their account (planned)
- Right to portability: Data export in JSON format (planned)

**Data Deletion:**
- Soft delete users (set is_active = false)
- Hard delete after 30 days (planned)
- Cascade delete all user's tasks

---

## How to Update This Document

**When to update:**
- New table added
- Table schema changed (new column, constraint, index)
- New Redis data structure added
- Validation rules changed
- Relationships changed

**What to update:**
- Table definitions with accurate column types and constraints
- ER diagram if relationships change
- Redis data structures if caching strategy changes
- Common queries if access patterns change
- Migration history

**What NOT to include:**
- Migration SQL code (lives in migrations/ folder)
- ORM model code (lives in codebase)
- Sample data (unless helpful for understanding)

---

## For AI: Reading This Document

**Before implementing a feature:**
1. Read this document to understand existing data structures
2. Check if the feature requires new tables or columns
3. Verify if existing indexes support your queries
4. Check validation rules

**If implementing a feature requires data changes:**
1. Propose schema changes clearly
2. Explain why the change is needed
3. Update this document before or during implementation
4. Create a migration file
5. Update common queries if needed

**If this document is unclear:**
- Ask questions before making assumptions
- Propose updates to improve clarity

---

This is your data truth. Keep it synchronized with your database.
