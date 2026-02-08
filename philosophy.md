# Philosophy

This document explains **why** behzad-framework exists and the core principles that guide every decision.

If you only read one document to understand this framework, read this one.

---

## The Problem

Most software development processes fail for predictable reasons:

1. **Requirements are vague** - Teams build the wrong thing because nobody asked the right questions
2. **Documentation gets stale** - Docs are written once, never updated, and become lies
3. **Knowledge is scattered** - Critical decisions live in Slack threads, forgotten emails, or people's heads
4. **AI wastes time and money** - Coding assistants rescan entire codebases repeatedly, burning tokens
5. **Work is fragile** - Long executions fail halfway through with no way to resume
6. **Mistakes repeat** - Teams make the same errors over and over because lessons aren't captured

Traditional project management tools don't solve these problems. They track tasks, not clarity.

**behzad-framework solves these problems through six core principles.**

---

## Principle 1: Intent-Based Usage

### What It Means

You state **what you want**, not how to do it.

The system asks questions, creates plans, executes work, and documents everything.

You don't run dozens of commands. You don't write documentation manually. You don't track status in spreadsheets.

You say: **"I want to deliver this feature."**

The framework handles the rest.

### Why This Matters

Most development processes make you think like an engineer even if you're not one.

They force you to:
- Know exactly what commands to run
- Understand technical implementation details
- Manually update documentation
- Track progress across multiple tools

**This is backwards.**

If you're a Product Leader, you should think about **what users need**, not about **how to structure a Git commit**.

The framework translates your intent into systematic execution.

### Example

**Traditional way:**
```
1. Write requirements doc
2. Create ticket in Jira
3. Design architecture
4. Update architecture docs
5. Write implementation plan
6. Create feature branch
7. Implement code
8. Write tests
9. Update docs
10. Create PR
11. ... and so on
```

**Framework way:**
```
/new-request user authentication
```

That's it. One command.

The framework automatically:
- Asks clarifying questions
- Defines the feature clearly
- Analyzes technical impact
- Creates phased execution plan
- Asks for your approval at decision gates
- Implements phase by phase
- Updates all documents automatically
- Captures lessons learned

You focus on **decisions**. The framework handles **execution**.

---

## Principle 2: Single Source of Truth

### What It Means

**No document explosion.**

A few living documents that are **always up to date**.

These documents are the source of truth, not your codebase.

AI reads these documents first, always.

### Why This Matters

Most projects suffer from documentation rot:

- README was accurate 6 months ago
- Architecture doc describes the old system
- API docs don't match the actual API
- Decision rationale is lost in old Slack messages

**This happens because documentation is treated as separate from work.**

People update code but forget to update docs. Eventually, docs become useless.

**The framework flips this.**

Documents are **part of the work**, not extra work.

Every feature delivery updates the documents. Every change is reflected. Every decision is captured.

The documents stay current because they're required for the process to function.

### The Core Documents

1. **product-system.md** - What features exist, their status, requirements
2. **tech-spine/** - How the system works technically (architecture, data, services, decisions, tests)
3. **execution-plan.md** - Current work broken into phases
4. **lessons.md** - What you've learned, rules for the future

That's it. Four document categories.

No sprawling wikis. No 50-page design docs. No out-of-date diagrams.

**Everything essential, nothing extra.**

### Why AI Reads Documents First

When AI scans your entire codebase:
- It burns tokens (costs money)
- It's slow
- It misses context (code shows "what", not "why")
- It can't understand past decisions

When AI reads **tech-spine**:
- Fast (5 files instead of 500)
- Cheap (minimal tokens)
- Contextual (explains "why", not just "what")
- Includes decision history

The documents are designed for both humans and AI to understand quickly.

---

## Principle 3: Decision Gates

### What It Means

AI doesn't act autonomously.

It stops at critical points, presents options clearly, and waits for your approval.

### Why This Matters

Giving AI full autonomy is dangerous:

- It might misunderstand requirements
- It might make bad architectural choices
- It might deploy broken code
- It might delete important work

**Humans must stay in control of important decisions.**

But interrupting AI constantly is annoying.

**Decision gates balance autonomy with control.**

AI works independently within a phase, but stops between phases to ask:

- "Does this feature definition match what you want?"
- "Should I proceed with this execution plan?"
- "Ready to deploy this to production?"

You approve or reject. If you reject, AI adjusts and presents a new plan.

### The Gates

The framework defines specific gates:

1. **After feature definition** - Confirm the feature is what you actually want
2. **After execution planning** - Approve the technical approach
3. **Before each phase** (optional) - Control pacing of work
4. **Before deployment** - Explicit approval to release
5. **After learning capture** - Review and approve lessons

These gates are intentional pause points.

They force you to think, review, and confirm before moving forward.

This prevents expensive mistakes.

---

## Principle 4: Token-Efficient & Scalable

### What It Means

AI must **not** rescan the entire codebase every time.

AI must rely on compact technical summaries first.

Deep code inspection happens only when necessary and scoped.

### Why This Matters

Modern AI coding assistants are powerful but expensive.

Every time AI scans your code, it uses tokens. Tokens cost money.

On a large codebase:
- Full scan = thousands of tokens
- Repeated scans = wasteful spending
- Context limits = AI can't see everything anyway

**The framework solves this through tech-spine.**

Instead of scanning code, AI reads:
- `system-map.md` - Architecture overview (200 lines)
- `data-model.md` - Data structures (150 lines)
- `service-map.md` - Services and APIs (100 lines)
- `decision-log.md` - Past decisions (varies, kept compact)
- `test-strategy.md` - Testing approach (100 lines)

**Total: ~550 lines instead of 50,000+ lines of code.**

This makes AI interactions:
- **Faster** - Less to read
- **Cheaper** - Fewer tokens
- **More accurate** - Summaries highlight what matters

When AI needs to inspect code, it does so **surgically**:

- "Read only the auth module"
- "Check the database migration files"
- "Inspect the API endpoint for user creation"

Scoped. Intentional. Efficient.

### The Rule

**If tech-spine is unclear, AI must ask questions before touching code.**

This prevents guessing and ensures documents stay accurate.

---

## Principle 5: Resumable Execution

### What It Means

No long, fragile executions.

Every feature is broken into **phases**.

Each phase has a clear goal, scope, tests, and checkpoint.

Work can pause and resume safely.

### Why This Matters

Long, uninterrupted executions fail:

- Your laptop crashes
- You need to step away
- AI hits an unexpected error
- You realize halfway through that the approach is wrong

**When execution isn't resumable, you lose progress.**

You have to start over, wasting time and money.

**The framework prevents this.**

Every feature is planned as phases:

**Example: Add User Authentication**

```
Phase 1: Add database schema for users
Phase 2: Implement auth service
Phase 3: Add login API endpoint
Phase 4: Add frontend login form
Phase 5: Write integration tests
Phase 6: Deploy to staging
Phase 7: Validate and deploy to production
```

Each phase:
- Takes 1-4 hours
- Has specific tests
- Has a checkpoint (how to verify success)
- Leaves the system in a working state

If Phase 3 fails, you don't lose Phase 1 and 2.

You fix Phase 3 and continue.

If you need to stop after Phase 4, the system is still functional.

You resume at Phase 5 later.

### The Commands

Simple commands control execution:

```
/continue FEAT-001    # Resume from where you left off
/pause                # Pause current work cleanly
/status FEAT-001      # Check progress
```

This gives you control and safety.

---

## Principle 6: Continuous Learning

### What It Means

The system **remembers lessons**.

Mistakes aren't repeated.

Learning is short, structured, and mandatory.

### Why This Matters

Most teams make the same mistakes over and over:

- "We forgot to add validation again"
- "We deployed without running tests again"
- "We made the same architectural mistake again"

**Why? Because lessons aren't captured systematically.**

Someone might remember for a week, but memory fades.

New team members don't know the history.

**The framework solves this with `lessons.md`.**

Every time you deliver a feature, AI proposes lessons:

```markdown
## Lesson 12: Auth Without Rate Limiting

**Date**: 2025-01-15
**Context**: Added login endpoint
**What happened**: Forgot rate limiting, endpoint got hammered in production
**Rule for the future**: All auth endpoints must have rate limiting. Check before deployment.
**Tags**: security, auth, deployment
```

**Short. Specific. Actionable.**

Before planning the next feature, AI reads all lessons.

If the new feature involves auth, AI will:
- Remember Lesson 12
- Add rate limiting to the plan
- Prevent repeating the mistake

### The Learning Loop

1. **Before planning** - AI reads lessons.md
2. **During execution** - AI follows rules from past lessons
3. **After delivery** - AI proposes new lessons
4. **You approve** - Lessons get added
5. **Next feature** - Process repeats

The framework **gets smarter with each delivery**.

Your second project is better than your first.

Your tenth project is better than your second.

**This is continuous improvement, automated.**

---

## How The Principles Work Together

These six principles aren't separate ideas. They reinforce each other.

**Example: Delivering a feature**

1. **Intent-based usage** - You say "I want search functionality"
2. **Decision gates** - AI asks clarifying questions before proceeding
3. **Single source of truth** - AI reads product-system.md and tech-spine to understand context
4. **Token-efficient** - AI reads summaries, not entire codebase
5. **Continuous learning** - AI checks lessons.md for past search-related mistakes
6. **Resumable execution** - AI creates a phased plan (indexing, API, UI, tests, deploy)
7. **Decision gates** - You approve the plan
8. **Resumable execution** - AI executes phase by phase
9. **Single source of truth** - AI updates tech-spine as it makes changes
10. **Decision gates** - You approve before deployment
11. **Continuous learning** - AI proposes lessons learned
12. **Single source of truth** - Lessons added to lessons.md, tech-spine updated, product-system.md marked complete

**All six principles active in one delivery.**

---

## What This Enables

When you follow these principles consistently:

1. **Features are clearly defined** - No more building the wrong thing
2. **Technical debt is tracked** - Decisions are documented, not forgotten
3. **AI costs are controlled** - Token usage is minimal and intentional
4. **Work never gets lost** - Phases are checkpointed and resumable
5. **Quality improves over time** - Lessons prevent repeated mistakes
6. **Onboarding is easier** - New people read the documents and understand the system

**The framework creates a flywheel of improvement.**

Each feature makes the next feature easier.

---

## What This Prevents

Following these principles prevents common failures:

- **Requirement churn** - Features are clarified upfront
- **Broken deployments** - Decision gates catch issues before production
- **Wasted AI spending** - Tech-spine prevents unnecessary code scanning
- **Lost progress** - Phased execution provides recovery points
- **Repeated mistakes** - Lessons system enforces learning
- **Knowledge silos** - Everything is documented in living documents

**This is defensive product development.**

You're not optimizing for speed. You're optimizing for **reliable delivery**.

---

## Common Objections

### "This seems like a lot of process for small features."

Small features move through the process quickly.

The clarification is fast. The planning is simple. The phases are few.

**The process scales to the work.**

The value is in **consistency**. Every feature follows the same pattern.

This builds discipline and prevents surprises.

### "What if I don't want to update documents?"

Then this framework isn't for you.

The documents **are** the system.

If you skip updating them, you lose the benefits.

But remember: **AI updates most documents automatically**.

You review and approve. You don't write them manually.

### "Can't I just use AI without all this structure?"

Yes, but you'll likely encounter the problems this framework prevents:

- Vague requirements leading to rework
- Repeated code scanning wasting tokens
- Lost context across sessions
- No documentation of decisions
- Repeated mistakes

**The structure exists because these problems are real.**

### "This feels heavyweight."

It's lightweight compared to traditional project management.

No sprint planning meetings. No daily standups. No burndown charts.

Just:
- Clear documents
- Phased execution
- Decision gates
- Learning capture

**Four concepts instead of forty.**

---

## Final Thought

This framework is opinionated.

It believes:
- **Clarity beats speed**
- **Documentation is part of work, not extra work**
- **AI should augment humans, not replace decision-making**
- **Learning from mistakes should be systematic**
- **Simplicity scales better than complexity**

If you agree with these beliefs, this framework will work for you.

If you don't, it won't.

**That's okay. This isn't for everyone.**

It's for people who want to deliver features systematically, learn continuously, and stay in control while using AI.

---

## Quick Start

Ready to try it?

```
/init-new my-project          # Start new project
/init-existing                # Add to existing project
/new-request user authentication  # Start a feature
/help                         # See all commands
```

Read [command-guide.md](command-guide.md) for all commands.

Read [how-it-works.md](how-it-works.md) to understand the system mechanics.
