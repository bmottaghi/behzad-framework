# How It Works

This document explains the **mechanics** of behzad-framework.

How the pieces fit together. How the process flows. How AI and documents interact.

---

## System Architecture

The framework has five main components:

1. **Command Layer** - Simple slash commands
2. **Living Documents** - Your source of truth
3. **Virtual Team** - AI playing different roles
4. **Delivery Process** - The flow from idea to deployment
5. **Learning System** - Continuous improvement

These components work together to deliver features systematically.

---

## Component 1: Command Layer

### What It Is

Simple slash commands that expand into full prompts.

Instead of memorizing long prompts like:
```
I'm using behzad-framework for systematic feature delivery.
Read these documents first: docs/product-system.md, docs/tech-spine/...
I want to deliver: user authentication
Follow deliver-flow.md...
```

You just type:
```
/deliver user authentication
```

**The command expands automatically.**

### How It Works

1. **You type a command** like `/deliver user authentication`
2. **Claude reads [commands.md](commands.md)** which defines the command
3. **Command expands** into a full prompt with your parameters injected
4. **Claude executes** the expanded prompt

### Available Commands

| Category | Commands |
|----------|----------|
| Primary | `/deliver`, `/init-existing`, `/init-new`, `/continue`, `/status`, `/help` |
| Workflow | `/plan`, `/deploy`, `/rollback`, `/pause`, `/resume` |
| Document | `/update-tech-spine`, `/show-lessons`, `/list-features`, `/add-research`, `/sync-docs` |
| Query | `/show-roadmap`, `/show-metrics`, `/search-decisions` |

See [command-guide.md](command-guide.md) for complete reference.

### Why Commands Work

**Without commands:**
- You memorize long prompts
- Easy to forget steps
- Inconsistent usage

**With commands:**
- Simple, memorable syntax
- Commands ensure correct prompts
- Consistent every time

**Commands are the user interface. Documents are the engine.**

---

## Component 2: Living Documents

### What They Are

A small set of markdown files that are **always current**.

They live in your repository alongside your code.

They're version controlled, human-readable, and AI-friendly.

### The Document Structure

```
docs/
├── product-system.md        # What features exist and their status
├── tech-spine/              # How the system works technically
│   ├── system-map.md        # Architecture overview
│   ├── data-model.md        # Data structures and database
│   ├── service-map.md       # Services, APIs, dependencies
│   ├── decision-log.md      # Major decisions and rationale
│   └── test-strategy.md     # Testing approach
├── execution/
│   └── execution-plan.md    # Current work broken into phases
├── learning/
│   └── lessons.md           # Captured lessons
└── research/
    └── (your research files)  # External research to consider
```

### Document Roles

**product-system.md**
- The single source of **product truth**
- Lists all features (planned, active, completed)
- Includes requirements and acceptance criteria
- Updated with every feature
- **Non-technical leaders read this to understand product status**

**tech-spine/** (5 files)
- Compact **technical knowledge layer**
- Designed for AI consumption (and smart humans)
- Answers: "How does this system work?"
- AI reads this **instead of scanning the entire codebase**
- Updated whenever architecture, data, or services change

**execution-plan.md**
- Current feature broken into **phases**
- Each phase has goal, scope, tests, checkpoint
- AI executes one phase at a time
- Supports pause/resume

**lessons.md**
- Short, structured **lessons learned**
- AI reads before planning new work
- Prevents repeating mistakes

**research/**
- External research you want considered
- API documentation, design patterns, architectural options
- AI treats these as **mandatory context** when told to

### Why Living Documents Work

Traditional documentation fails because it's separate from work.

Code changes. Docs don't. Eventually, docs lie.

**In this framework, documents are part of the workflow.**

AI can't proceed without reading them.

AI can't complete work without updating them.

This keeps documents current by necessity, not by discipline.

---

## Component 3: Virtual Team

AI doesn't act as a generic assistant. It plays **specific roles**.

### The Roles

**Product Manager**
- Asks clarifying questions about requirements
- Creates feature definitions in product-system.md
- Ensures acceptance criteria are clear
- Updates feature status

**System Architect**
- Reads and understands tech-spine
- Analyzes technical impact of features
- Updates system-map.md when architecture changes
- Logs major decisions in decision-log.md

**Senior Engineer**
- Creates phased execution plans
- Implements code changes
- Writes tests alongside code
- Updates data-model.md and service-map.md as needed

**QA / Test Strategist**
- Ensures each phase has appropriate tests
- Validates acceptance criteria are met
- Updates test-strategy.md

**DevOps / Release Manager**
- Prepares deployment plans
- Handles versioning
- Validates post-deployment
- Ensures production readiness

**Project Historian**
- Captures lessons learned
- Maintains decision-log.md
- Ensures context isn't lost

### How Roles Switch

AI doesn't explicitly announce role changes.

Instead, **it shifts focus based on the workflow phase**.

During requirement clarification → Product Manager mindset

During technical analysis → System Architect mindset

During implementation → Senior Engineer mindset

During testing → QA mindset

During deployment → DevOps mindset

After delivery → Historian mindset

**The same AI, different perspectives at different times.**

---

## Component 4: Delivery Process (The "deliver" Flow)

When you say "I want to deliver this feature," the framework runs this process:

### Phase 1: Requirement Clarification

**What happens:**
- AI (as Product Manager) asks questions about your intent
- Questions focus on "why" and "what", not "how"
- Questions clarify edge cases and acceptance criteria

**Example questions:**
- "Who will use this feature?"
- "What happens if the user is offline?"
- "How do you want errors to be displayed?"
- "What defines 'done' for this feature?"

**Output:** Clear understanding of what you want

### Phase 2: Feature Definition

**What happens:**
- AI creates a feature entry in product-system.md
- Includes description, requirements, acceptance criteria
- Marks status as "In Planning"

**Decision Gate:** "Does this match what you want?"

You review. Approve or request changes.

If approved, continue. If not, AI revises.

### Phase 3: Technical Impact Analysis

**What happens:**
- AI reads tech-spine/ to understand current architecture
- AI identifies what needs to change
- AI considers data model, services, APIs affected
- AI checks lessons.md for relevant past learnings

**Output:** Clear understanding of technical impact

**Example analysis:**
```
Based on tech-spine:

Changes needed:
- database: Add 'users' table (data-model.md)
- service: Create AuthService (service-map.md)
- API: Add /login endpoint (service-map.md)
- frontend: Add login form component

Dependencies:
- Requires encryption library (not currently in use)
- Impacts existing session management

Risks:
- Lesson 12 says auth endpoints need rate limiting
- system-map.md shows no current auth strategy
```

### Phase 4: Execution Planning

**What happens:**
- AI breaks work into small phases
- Each phase: 1-4 hours of work
- Each phase has tests and checkpoint
- Phases are sequential and resumable

**Output:** execution-plan.md created

**Decision Gate:** "Should I proceed with this plan?"

You review the plan. Approve or request changes.

### Phase 5: Implementation (Phase by Phase)

**What happens:**
- AI implements Phase 1
- AI writes tests for Phase 1
- AI validates checkpoint
- (Optional) Decision Gate: "Ready for Phase 2?"
- AI continues to next phase

**Updates during implementation:**
- tech-spine files updated as architecture/data/services change
- Comments in code reference relevant tech-spine sections
- Checkpoint validation ensures each phase is solid

**If phase fails:**
- AI reports what went wrong
- You decide: retry, revise plan, or pause
- Progress from previous phases is preserved

### Phase 6: Pre-Release Review

**What happens:**
- All phases complete
- AI summarizes what was built
- AI confirms all acceptance criteria met
- AI shows updated tech-spine entries

**Decision Gate:** "Ready to release?"

You review the changes. Approve or request fixes.

### Phase 7: Deployment & Versioning

**What happens:**
- AI prepares deployment (version bump, changelog, etc.)
- AI deploys to staging (if applicable)
- AI validates staging works

**Decision Gate:** "Ready to deploy to production?"

You approve. AI deploys.

### Phase 8: Post-Deployment Validation

**What happens:**
- AI checks production health
- AI validates feature works as expected
- AI monitors for immediate issues

**Output:** Confirmation that deployment succeeded

### Phase 9: Learning Capture

**What happens:**
- AI reviews the entire delivery
- AI proposes lessons learned
- Lessons cover what went well and what didn't

**Example lesson proposal:**
```
## Lesson 15: Auth Library Integration

**Date**: 2025-01-20
**Context**: Added user authentication
**What happened**: Spent extra time choosing encryption library. Should have researched options upfront.
**Rule for the future**: For new dependencies, research options in docs/research/ before implementation phase.
**Tags**: dependencies, planning
```

**Decision Gate:** "Should I add this lesson?"

You review. Approve or edit.

Approved lessons go into lessons.md.

### Completion

- Feature status in product-system.md marked "Completed"
- All tech-spine updates committed
- execution-plan.md archived (or cleared for next feature)
- Lessons added

**Feature delivery is complete.**

---

## Component 5: Learning System

The framework improves with each delivery through `lessons.md`.

### Lesson Structure

```markdown
## Lesson [ID]: [Short Title]

**Date**: YYYY-MM-DD
**Context**: What was the situation?
**What happened**: What went wrong or right?
**Rule for the future**: What should we do next time?
**Tags**: [relevant tags]
```

### How Lessons Are Used

**Before planning:**
- AI reads all lessons
- AI filters by relevant tags
- AI applies rules from past lessons

**Example:**

You want to add "password reset" feature.

AI reads lessons.md and finds:
- Lesson 12: "All auth endpoints need rate limiting"
- Lesson 15: "Research dependencies upfront"

AI includes these in the plan automatically:
- Phase 1: Research password reset libraries (docs/research/)
- Phase 4: Add rate limiting to reset endpoint

**Mistakes don't repeat.**

### Lesson Maintenance

Over time, lessons accumulate.

Some become outdated (architecture changed, tech evolved).

**Periodic review:**
- Read through lessons.md
- Mark outdated lessons as `[DEPRECATED]`
- Remove lessons that no longer apply

**Keep lessons compact and useful.**

Too many lessons = noise. Curate them.

---

## How AI and Documents Interact

This is the key to the framework.

### The Read-Update Cycle

1. **AI reads documents** before acting
2. **AI acts** based on document content
3. **AI updates documents** with changes
4. **AI commits** updates to version control

**Documents stay current automatically.**

### Example Interaction

You: "I want to add search functionality."

**AI reads:**
- `product-system.md` - What features currently exist?
- `tech-spine/system-map.md` - How is the system architected?
- `tech-spine/data-model.md` - What data exists?
- `tech-spine/service-map.md` - What services are available?
- `lessons.md` - Any past search-related lessons?

**AI acts:**
- Asks clarifying questions
- Creates feature definition
- Analyzes impact
- Creates execution plan

**AI updates:**
- `product-system.md` - Adds "Search" feature (status: In Planning)
- `execution-plan.md` - Creates phased plan

**You approve plan.**

**AI implements Phase 1:**
- Adds search indexing code
- Writes tests

**AI updates:**
- `tech-spine/service-map.md` - Documents new SearchService
- `tech-spine/data-model.md` - Documents search index structure

**AI implements Phase 2, 3, 4...**

**AI finishes:**
- `product-system.md` - Updates "Search" status to Completed
- `lessons.md` - Adds lesson about indexing strategy

**Complete cycle. Documents reflect reality.**

---

## How This Scales

### Small Feature (1-2 hours)

- Clarification: 2 questions
- Planning: 2-3 phases
- Updates: Minor changes to 1-2 tech-spine files
- Lessons: 0-1 lesson

**Total overhead: ~5 minutes of your decision-making time**

### Medium Feature (4-8 hours)

- Clarification: 5-6 questions
- Planning: 4-6 phases
- Updates: Changes to 3-4 tech-spine files
- Lessons: 1-2 lessons

**Total overhead: ~15 minutes of your decision-making time**

### Large Feature (1-2 days)

- Clarification: 10+ questions
- Planning: 8-12 phases
- Updates: Significant tech-spine changes
- Lessons: 2-4 lessons

**Total overhead: ~30 minutes of your decision-making time**

**The process scales to the work.**

The structure stays the same. The depth changes.

---

## Integration with Claude Code (VSCode Extension)

This framework is designed to work seamlessly with Claude Code.

### Using Commands (Recommended)

1. **Open your project in VSCode**
2. **Type a command:** `/deliver user authentication`
3. **Claude reads framework documents**
4. **Claude follows the deliver flow**
5. **Claude stops at decision gates**
6. **You approve or redirect**
7. **Claude implements and updates documents**

**That's it. Commands handle the complexity.**

### Example with Commands

```
# Start a new project
/init-new my-project

# Deliver a feature
/deliver user authentication with email and password

# Check status
/status FEAT-001

# Continue paused work
/continue FEAT-001
```

### Advanced: Using Full Prompts

For custom scenarios not covered by commands:

```
I'm using behzad-framework for systematic feature delivery.

Read these documents first:
- docs/product-system.md
- docs/tech-spine/ (all files)
- docs/learning/lessons.md

I want to deliver: User authentication with email and password

Follow deliver-flow.md.
Stop at decision gates defined in decision-gates.md.

[Add any custom instructions here]
```

### Why This Works

Claude Code in VSCode:
- Can read all markdown files in your repo
- Can edit files systematically
- Can run tests and validate checkpoints
- Can commit changes to Git
- Can pause and resume work

**Commands provide the interface. Documents provide the structure.**

---

## What Happens Without the Framework

To appreciate how this works, consider what happens **without** the framework:

**You:** "Add search functionality."

**AI (unstructured):**
- Starts implementing immediately (no clarification)
- Scans entire codebase (wastes tokens)
- Makes assumptions about requirements
- Writes code without tests
- Doesn't document decisions
- If it fails halfway, progress is lost
- No lessons captured

**Result:** Wasted time, wasted money, unclear implementation, no learning.

**With the framework:**

**You:** "Add search functionality."

**AI (structured):**
- Asks clarifying questions first
- Reads tech-spine (not entire codebase)
- Creates clear feature definition
- Plans in resumable phases
- Implements with tests
- Documents all changes
- Captures lessons

**Result:** Clear, tested, documented, learned from.

**The difference is discipline.**

---

## Common Questions

### What if I want to skip a phase?

You can, but you lose the benefits of that phase.

Skipping clarification → vague requirements → rework.

Skipping planning → fragile execution → higher failure risk.

Skipping learning → repeated mistakes.

**The process exists because these phases prevent problems.**

### What if AI makes a mistake?

AI will make mistakes. That's expected.

**The framework minimizes impact:**
- Small phases → mistakes are caught early
- Decision gates → you review before major steps
- Resumable execution → failed phases can be retried without losing other work

When AI makes a mistake:
1. You notice (because phases are small)
2. You tell AI what's wrong
3. AI fixes and retries that phase
4. Learning is captured to prevent future occurrence

### Can I customize the process?

The core process should stay consistent.

**What you can customize:**
- Number of phases (more or fewer based on feature size)
- Decision gates (skip optional ones if you trust the work)
- Lesson detail (more or less verbose)

**What you shouldn't customize:**
- The document structure (documents are the system)
- The read-update cycle (documents must stay current)
- The learning capture (prevents repeated mistakes)

**Consistency creates discipline. Don't over-customize.**

---

## Next Steps

Now that you understand how the system works:

1. Read [command-guide.md](command-guide.md) - Learn the commands
2. Read [usage.md](usage.md) - Learn how to set up and use the framework
3. Read [deliver-flow.md](deliver-flow.md) - Detailed walkthrough of the delivery process
4. Read [decision-gates.md](decision-gates.md) - Understand when and why AI stops
5. See [examples/command-based-example.md](examples/command-based-example.md) - Complete example with commands

**Start with commands. Fall back to prompts when needed.**
