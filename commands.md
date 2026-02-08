# Commands Reference

**This is the core command system of behzad-framework.**

Commands are simple slash commands that expand into full prompts. When you type a command, Claude Code reads this file and executes the expanded prompt.

---

## How Commands Work

```
You type:     /new-request user authentication
Claude reads: This file (commands.md)
Claude runs:  The expanded prompt with your parameters injected
```

**Commands save you from memorizing long prompts.**

---

## Command Categories

| Category | Commands | Purpose |
|----------|----------|---------|
| Primary | /new-request, /init-existing, /init-new, /continue, /status, /help | Core workflow |
| Workflow | /plan, /deploy, /rollback, /pause, /resume | Execution control |
| Document | /update-tech-spine, /show-lessons, /list-features, /add-research, /sync-docs | Document management |
| Query | /show-roadmap, /show-metrics, /search-decisions | Information retrieval |

---

# Primary Commands

These are the commands you'll use most often.

---

## /new-request

**Purpose:** Start working on a new feature or bug. AI will classify automatically.

**Syntax:**
```
/new-request [description]
```

**Examples:**
```
/new-request user authentication
/new-request login button doesn't work on mobile
/new-request ability to share tasks with team members
```

**Note:** This command expands to `.claude/commands/new-request.md` which handles both features and bugs with proper classification.

---

## /init-existing

**Purpose:** Add behzad-framework to an existing project.

**Syntax:**
```
/init-existing
```

**Expands To:**

```
I'm initializing behzad-framework in this existing project.

**FIRST, read framework principles:**
1. Read: {framework_root}/philosophy.md
2. Read: {framework_root}/how-it-works.md

**ANALYZE THE PROJECT:**
1. Explore the codebase structure
2. Identify: tech stack, architecture patterns, existing documentation
3. Find: entry points, main services, data models, tests

**CREATE FRAMEWORK DOCUMENTS:**

1. **docs/product-system.md**
   - Document existing features as feature entries
   - Mark all as Status: "Completed"
   - Note any features in progress

2. **docs/tech-spine/system-map.md**
   - Document current architecture
   - List components and their relationships
   - Note technology choices

3. **docs/tech-spine/data-model.md**
   - Document existing data structures
   - Schemas, relationships, key fields

4. **docs/tech-spine/service-map.md**
   - List existing services/modules
   - Document APIs and endpoints
   - Note dependencies

5. **docs/tech-spine/decision-log.md**
   - Start empty or document known past decisions
   - Add decisions from README or comments if found

6. **docs/tech-spine/test-strategy.md**
   - Document existing test setup
   - Test commands, coverage targets

7. **docs/execution/execution-plan.md**
   - Create empty template for future features

8. **docs/learning/lessons.md**
   - Start empty for future lessons

**PRESENT SUMMARY:**
After creating all documents, present:
- What was discovered about the project
- What documents were created
- Any recommendations for improvement
- How to start using the framework

**ASK:** "Framework initialized. Ready to start? Use /new-request to begin."
```

---

## /init-new

**Purpose:** Start a brand new project with behzad-framework from day one.

**Syntax:**
```
/init-new [project-name]
```

**Examples:**
```
/init-new my-saas-app
/init-new task-management-system
```

**Expands To:**

```
I'm initializing a new project with behzad-framework: {project-name}

**FIRST, read framework principles:**
1. Read: {framework_root}/philosophy.md
2. Read: {framework_root}/how-it-works.md

**ASK ABOUT THE PROJECT:**
Before creating anything, ask:
1. What is this project about? (brief description)
2. Who are the target users?
3. What are the core features you want to build?
4. What tech stack do you want? (or should I recommend?)
5. Any specific constraints? (timeline, budget, compliance)

**AFTER CLARIFICATION, CREATE:**

1. **Basic project structure** based on tech stack

2. **docs/product-system.md**
   - Product vision from user's description
   - User personas from target users
   - Feature backlog from core features (all Status: "Planned")

3. **docs/tech-spine/system-map.md**
   - Proposed architecture
   - Technology choices and why

4. **docs/tech-spine/data-model.md**
   - Initial data model based on features
   - Start simple, will grow

5. **docs/tech-spine/service-map.md**
   - Planned services/modules
   - API structure

6. **docs/tech-spine/decision-log.md**
   - Document initial tech stack decisions
   - Include rationale

7. **docs/tech-spine/test-strategy.md**
   - Testing approach for this stack
   - Coverage targets

8. **docs/execution/execution-plan.md**
   - Empty template

9. **docs/learning/lessons.md**
   - Empty template

**PRESENT:**
- Project structure created
- All framework documents initialized
- Recommended first feature to deliver
- How to proceed

**ASK:** "Project initialized. Use /new-request [description] to start your first feature."
```

---

## /continue

**Purpose:** Resume work on a paused feature.

**Syntax:**
```
/continue [FEAT-ID]
```

**Examples:**
```
/continue FEAT-001
/continue FEAT-005
```

**Expands To:**

```
I'm resuming work on feature: {FEAT-ID}

**READ CURRENT STATE:**
1. Read: docs/product-system.md - Find {FEAT-ID} entry
2. Read: docs/execution/execution-plan.md - Find current phase
3. Read: docs/tech-spine/ (all files) - Current technical state
4. Read: docs/learning/lessons.md - Relevant lessons

**DETERMINE STATUS:**
- What phase was last completed?
- What phase should start next?
- Are there any blockers noted?
- What was the last decision gate?

**PRESENT SUMMARY:**
```
Resuming: {FEAT-ID} - [Feature Title]

Last completed: Phase X - [Phase Name]
Next phase: Phase Y - [Phase Name]
Overall progress: X of Y phases complete

Ready to continue with Phase Y?
```

**CONTINUE FROM WHERE WE LEFT OFF:**
- Pick up at the next incomplete phase
- Follow the same process as /new-request
- Stop at decision gates
- Update documents as you go
```

---

## /status

**Purpose:** Check the status of a feature or overall project.

**Syntax:**
```
/status [FEAT-ID]     # Status of specific feature
/status               # Overall project status
```

**Examples:**
```
/status FEAT-001
/status
```

**Expands To (with FEAT-ID):**

```
Checking status of feature: {FEAT-ID}

**READ:**
1. docs/product-system.md - Find {FEAT-ID}
2. docs/execution/execution-plan.md - Current phase info

**PRESENT:**
```
Feature: {FEAT-ID} - [Title]
Status: [In Planning / In Progress / Completed / Paused]
Priority: [P0/P1/P2]

Progress:
- Phase 1: [Complete/In Progress/Pending]
- Phase 2: [Complete/In Progress/Pending]
- ...

Current Phase: [Phase name and description]
Last Activity: [Date/time if available]
Blockers: [Any blockers noted]

Next Steps:
- [What needs to happen next]
```
```

**Expands To (without FEAT-ID - overall status):**

```
Checking overall project status.

**READ:**
1. docs/product-system.md - All features
2. docs/execution/execution-plan.md - Current work

**PRESENT:**
```
Project Status Overview

Features by Status:
- Completed: X features
- In Progress: X features
- Planned: X features
- Paused: X features

Currently Active:
- [FEAT-ID]: [Title] - Phase X of Y

Recently Completed:
- [FEAT-ID]: [Title]
- [FEAT-ID]: [Title]

Up Next (by priority):
- [FEAT-ID]: [Title] (P0)
- [FEAT-ID]: [Title] (P1)

Lessons Captured: X total
```
```

---

## /help

**Purpose:** Get help on how to use commands.

**Syntax:**
```
/help              # Show all commands
/help [command]    # Show help for specific command
```

**Examples:**
```
/help
/help deliver
/help continue
```

**Expands To (general help):**

```
**behzad-framework Commands**

**Getting Started:**
- `/init-new [name]` - Start new project
- `/init-existing` - Add to existing project

**Core Workflow:**
- `/new-request [description]` - Start new feature or bug
- `/continue [FEAT-ID]` - Resume paused feature
- `/status [FEAT-ID]` - Check status

**Execution Control:**
- `/plan [FEAT-ID]` - View/update execution plan
- `/deploy [FEAT-ID]` - Deploy a feature
- `/rollback [FEAT-ID]` - Rollback deployment
- `/pause` - Pause current work
- `/resume` - Resume paused work

**Documents:**
- `/update-tech-spine` - Refresh technical docs
- `/show-lessons [tags]` - View lessons
- `/list-features [filter]` - List features
- `/add-research [topic]` - Add research notes
- `/sync-docs` - Sync all documents

**Query:**
- `/show-roadmap` - View feature roadmap
- `/show-metrics` - View delivery metrics
- `/search-decisions [keyword]` - Search decision log

**Tips:**
- Start with `/init-existing` or `/init-new`
- Use `/new-request` for new features or bugs
- Use `/continue` to resume work
- Use `/status` to check progress

Type `/help [command]` for detailed help on any command.
```

**Expands To (specific command help):**

```
Show detailed help for command: {command}

Read the command definition from this file (commands.md) and present:
- Purpose
- Syntax
- Examples
- What it does step by step
```

---

# Workflow Commands

Commands for controlling the execution workflow.

---

## /plan

**Purpose:** View or update the execution plan for a feature.

**Syntax:**
```
/plan [FEAT-ID]
```

**Expands To:**

```
Viewing/updating execution plan for: {FEAT-ID}

**READ:**
1. docs/product-system.md - Feature definition
2. docs/execution/execution-plan.md - Current plan

**IF PLAN EXISTS:**
Present current plan with phase statuses.
Ask: "Do you want to modify this plan?"

**IF NO PLAN:**
Offer to create one:
"No execution plan found for {FEAT-ID}. Should I create one?"

**IF MODIFYING:**
Ask what to change:
- Add phases?
- Remove phases?
- Reorder phases?
- Update estimates?

Update execution-plan.md with changes.
```

---

## /deploy

**Purpose:** Deploy a completed feature to production.

**Syntax:**
```
/deploy [FEAT-ID]
```

**Expands To:**

```
Deploying feature: {FEAT-ID}

**PRE-FLIGHT CHECK:**
1. Read docs/product-system.md - Verify feature ready
2. Read docs/execution/execution-plan.md - All phases complete?
3. Verify all acceptance criteria met
4. Verify all tests passing

**IF NOT READY:**
Report what's missing:
"Cannot deploy {FEAT-ID}. Missing: [list issues]"

**IF READY:**
Execute deployment:
1. Create release tag
2. Deploy to staging (if applicable)
3. Run smoke tests
4. **DECISION GATE:** "Staging validated. Deploy to production?"
5. Deploy to production
6. Run post-deployment validation
7. Monitor for issues

**AFTER DEPLOYMENT:**
- Update feature status to "Deployed"
- Proceed to Learning Capture phase
```

---

## /rollback

**Purpose:** Rollback a deployed feature.

**Syntax:**
```
/rollback [FEAT-ID]
```

**Expands To:**

```
Rolling back feature: {FEAT-ID}

**VERIFY:**
1. Feature is currently deployed
2. Previous version is available

**CONFIRM:**
"Are you sure you want to rollback {FEAT-ID}? This will revert to the previous version."

**IF CONFIRMED:**
1. Rollback to previous version
2. Verify system stability
3. Update feature status to "Rolled Back"
4. Document reason in decision-log.md

**AFTER ROLLBACK:**
Ask: "What went wrong? Should we investigate and fix?"
```

---

## /pause

**Purpose:** Pause current work cleanly.

**Syntax:**
```
/pause
```

**Expands To:**

```
Pausing current work.

**SAVE STATE:**
1. Read docs/execution/execution-plan.md - Note current phase
2. Ensure all progress is documented
3. Note any in-progress items

**UPDATE DOCUMENTS:**
1. Update execution-plan.md with pause note:
   - Current phase
   - What was in progress
   - What needs to happen next
2. Update product-system.md status if needed

**CONFIRM:**
"Work paused. Current state saved.

Paused at: [Phase X - Description]
In progress: [What was being worked on]
To resume: /continue [FEAT-ID] or /resume

All progress is saved. You can safely close this session."
```

---

## /resume

**Purpose:** Resume the most recently paused work.

**Syntax:**
```
/resume
```

**Expands To:**

```
Resuming most recent work.

**FIND CURRENT WORK:**
1. Read docs/product-system.md - Find features with Status: "In Progress"
2. Read docs/execution/execution-plan.md - Find incomplete phases

**IF MULTIPLE IN PROGRESS:**
Present options:
"Multiple features in progress:
1. FEAT-001 - User Auth (Phase 3)
2. FEAT-002 - Search (Phase 1)

Which one should we continue?"

**IF ONE IN PROGRESS:**
Automatically continue that feature.
Same as `/continue [FEAT-ID]`

**IF NONE IN PROGRESS:**
"No work in progress. Use /new-request to start new work or /list-features to see planned features."
```

---

# Document Commands

Commands for managing framework documents.

---

## /update-tech-spine

**Purpose:** Refresh technical documentation to match current codebase.

**Syntax:**
```
/update-tech-spine
```

**Expands To:**

```
Updating tech-spine documentation.

**ANALYZE CURRENT CODEBASE:**
1. Scan project structure
2. Identify services, components, APIs
3. Find data models
4. Check for new dependencies

**COMPARE WITH DOCS:**
1. Read docs/tech-spine/system-map.md
2. Read docs/tech-spine/data-model.md
3. Read docs/tech-spine/service-map.md
4. Identify differences

**UPDATE DOCUMENTS:**
For each document, update to reflect current state:
- Add new components/services
- Remove deprecated items
- Update relationships

**PRESENT CHANGES:**
"Updated tech-spine documents:

system-map.md:
- Added: [new components]
- Removed: [deprecated items]

data-model.md:
- Added: [new models]
- Updated: [changed schemas]

service-map.md:
- Added: [new services/APIs]
- Updated: [changed endpoints]

Changes applied. Tech-spine now matches codebase."
```

---

## /show-lessons

**Purpose:** View lessons learned, optionally filtered by tags.

**Syntax:**
```
/show-lessons              # All lessons
/show-lessons [tags]       # Filtered by tags
```

**Examples:**
```
/show-lessons
/show-lessons auth
/show-lessons testing,performance
```

**Expands To:**

```
Showing lessons: {tags or "all"}

**READ:**
docs/learning/lessons.md

**IF TAGS PROVIDED:**
Filter lessons by matching tags.

**PRESENT:**
"Lessons Learned: {count} total {filter info}

---
Lesson 001: [Title]
Tags: [tags]
Context: [context]
Rule: [rule]

---
Lesson 002: [Title]
Tags: [tags]
Context: [context]
Rule: [rule]

---
..."

**IF NO LESSONS:**
"No lessons found {with those tags}. Lessons are captured after feature delivery."
```

---

## /list-features

**Purpose:** List features with optional filtering.

**Syntax:**
```
/list-features              # All features
/list-features [filter]     # Filtered (completed, in-progress, planned, p0, p1, p2)
```

**Examples:**
```
/list-features
/list-features in-progress
/list-features p0
```

**Expands To:**

```
Listing features: {filter or "all"}

**READ:**
docs/product-system.md

**FILTER:**
Apply filter if provided:
- completed: Status = "Completed"
- in-progress: Status = "In Progress"
- planned: Status = "Planned"
- p0/p1/p2: Priority = specified

**PRESENT:**
"Features: {count} {filter info}

| ID | Title | Status | Priority |
|----|-------|--------|----------|
| FEAT-001 | User Auth | Completed | P0 |
| FEAT-002 | Search | In Progress | P1 |
| FEAT-003 | Sharing | Planned | P1 |

Use /status [FEAT-ID] for details."
```

---

## /add-research

**Purpose:** Add research notes on a topic.

**Syntax:**
```
/add-research [topic]
```

**Examples:**
```
/add-research authentication methods
/add-research performance optimization
```

**Expands To:**

```
Adding research on: {topic}

**CREATE OR UPDATE:**
docs/research/{topic-slug}.md

**GATHER INFORMATION:**
Ask user:
"What research do you want to capture about {topic}?
- Key findings?
- Options considered?
- Pros/cons?
- Recommendation?
- Sources?"

**DOCUMENT:**
Create research note with:
- Topic
- Date
- Context (why researching)
- Findings
- Options (if applicable)
- Recommendation (if applicable)
- Sources

**CONFIRM:**
"Research note created: docs/research/{topic-slug}.md

This can be referenced in future feature planning."
```

---

## /sync-docs

**Purpose:** Ensure all framework documents are consistent and up-to-date.

**Syntax:**
```
/sync-docs
```

**Expands To:**

```
Syncing all framework documents.

**CHECK CONSISTENCY:**

1. **product-system.md**
   - All feature IDs unique?
   - Statuses valid?
   - Dependencies reference existing features?

2. **execution-plan.md**
   - References valid features?
   - Phase statuses consistent?

3. **tech-spine/**
   - system-map.md matches codebase?
   - data-model.md matches schemas?
   - service-map.md matches services?
   - decision-log.md entries dated?
   - test-strategy.md current?

4. **lessons.md**
   - All lessons have required fields?
   - Tags are consistent?

**FIX ISSUES:**
For each issue found, fix or report:
- Auto-fix: Simple inconsistencies
- Report: Issues needing user input

**PRESENT:**
"Document sync complete.

Checked: 8 documents
Issues found: X
Auto-fixed: Y
Needs attention: Z

[List any issues needing attention]

All documents are now consistent."
```

---

# Query Commands

Commands for retrieving information.

---

## /show-roadmap

**Purpose:** View the feature roadmap.

**Syntax:**
```
/show-roadmap
```

**Expands To:**

```
Generating feature roadmap.

**READ:**
docs/product-system.md

**ORGANIZE BY PRIORITY AND STATUS:**

**PRESENT:**
"Feature Roadmap

## Now (In Progress)
- FEAT-001: User Authentication [P0] - Phase 3 of 6
- FEAT-002: Search [P1] - Phase 1 of 4

## Next (Planned P0)
- FEAT-003: Team Management
- FEAT-004: Notifications

## Later (Planned P1-P2)
- FEAT-005: Analytics Dashboard [P1]
- FEAT-006: Mobile App [P2]
- FEAT-007: API Integrations [P2]

## Completed
- FEAT-000: Initial Setup [P0]

---
Total: X features (Y completed, Z in progress, W planned)"
```

---

## /show-metrics

**Purpose:** View delivery metrics and statistics.

**Syntax:**
```
/show-metrics
```

**Expands To:**

```
Calculating delivery metrics.

**READ:**
1. docs/product-system.md - Features
2. docs/execution/execution-plan.md - Phases
3. docs/learning/lessons.md - Lessons

**CALCULATE:**
- Features completed
- Features in progress
- Average phases per feature
- Lessons captured
- Most common lesson tags

**PRESENT:**
"Delivery Metrics

Features:
- Total: X
- Completed: Y (Z%)
- In Progress: W
- Planned: V

Execution:
- Avg phases per feature: X
- Total phases completed: Y

Learning:
- Total lessons: X
- Top tags: [tag1], [tag2], [tag3]

Trend: [improving/stable/needs attention]

These metrics help track delivery velocity and learning."
```

---

## /search-decisions

**Purpose:** Search the decision log.

**Syntax:**
```
/search-decisions [keyword]
```

**Examples:**
```
/search-decisions auth
/search-decisions database
/search-decisions JWT
```

**Expands To:**

```
Searching decisions for: {keyword}

**READ:**
docs/tech-spine/decision-log.md

**SEARCH:**
Find entries containing {keyword} in:
- Title
- Context
- Decision
- Rationale

**PRESENT:**
"Found X decisions matching '{keyword}':

---
Decision 002: Use JWT for Authentication
Date: 2024-01-15
Context: Needed stateless auth for API
Decision: JWT with 30-day expiration
Rationale: Stateless, scalable, standard

---
Decision 005: Redis for Session Storage
Date: 2024-02-01
Context: Needed fast session lookups
Decision: Redis with 24h TTL
Rationale: Fast, handles expiration

---

Use this to understand past technical decisions."
```

---

# Internal Commands

These are used internally by other commands. Users typically don't call these directly.

---

## [Internal] Read Framework Docs

Used by /new-request, /continue, and others to load framework context.

**Template:**
```
Read these framework documents:
1. {framework_root}/philosophy.md
2. {framework_root}/deliver-flow.md
3. {framework_root}/decision-gates.md
4. {framework_root}/commands.md (this file)
```

---

## [Internal] Read Project Docs

Used to load current project state.

**Template:**
```
Read project documents:
1. docs/product-system.md
2. docs/tech-spine/system-map.md
3. docs/tech-spine/data-model.md
4. docs/tech-spine/service-map.md
5. docs/tech-spine/decision-log.md
6. docs/tech-spine/test-strategy.md
7. docs/execution/execution-plan.md
8. docs/learning/lessons.md
```

---

## [Internal] Decision Gate Template

Used at each decision gate.

**Template:**
```
**DECISION GATE: {gate-name}**

{Present relevant information}

{Ask specific question}

Options:
- Approve: {what happens}
- Request changes: {what happens}
- Pause: {what happens}

Waiting for your response...
```

---

# Path Resolution

**{framework_root}** resolves to the location of behzad-framework files:
- If framework is in project: `./behzad-framework/`
- If framework is separate: The path where framework files are located

**{feature-description}** and other parameters are replaced with user input.

---

# Backward Compatibility

**Old prompt-based approach still works.**

If you prefer writing full prompts instead of commands, you can still do that. Commands are a convenience layer, not a replacement.

See [usage.md](usage.md) for both approaches.

---

# Adding New Commands

To add a new command:

1. Add command definition to this file following the format:
   - Purpose
   - Syntax
   - Examples
   - Expands To (the full prompt)

2. Update command-guide.md with user documentation

3. Test the command

**Keep commands focused.** One command = one purpose.
