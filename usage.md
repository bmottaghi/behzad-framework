# Usage Guide

**How to actually use behzad-framework with Claude Code in VSCode.**

This guide covers setup, daily usage, and best practices.

---

## Quick Start with Commands

The fastest way to use the framework:

```
# New project
/init-new my-project

# Existing project
/init-existing

# Deliver a feature
/deliver user authentication

# Check status
/status

# Resume paused work
/continue FEAT-001
```

That's it. Commands expand into full prompts automatically.

See [command-guide.md](command-guide.md) for all available commands.

---

## Prerequisites

Before using this framework:

1. **VSCode with Claude Code extension installed**
2. **A project** (new or existing)
3. **Git initialized** in your project
4. **Basic understanding** of your project's tech stack

---

## Initial Setup

### Option 1: New Project (Command)

```
/init-new my-project-name
```

Claude will:
- Ask about your project (description, users, features, tech stack)
- Create all framework folders and files
- Initialize templates based on your answers
- Create starter content

### Option 2: Existing Project (Command)

```
/init-existing
```

Claude will:
- Analyze your existing codebase
- Create framework folders
- Generate tech-spine by reverse-engineering your code
- Create product-system.md with current features
- Ask you to review and correct

---

## Advanced: Manual Setup with Prompts

If you prefer more control or the commands don't cover your use case:

### New Project (Manual)

```
I'm using behzad-framework for systematic product development.

Initialize this as a new project:
1. Create the docs/ structure
2. Create initial product-system.md
3. Create tech-spine/ templates
4. Set up execution/, learning/, research/ folders

This is a [describe your project type, e.g., "web application with React frontend and Node.js backend"].
```

### Existing Project (Manual)

```
I'm using behzad-framework to bring systematic process to this existing project.

Initialize behzad-framework:
1. Create docs/ structure
2. Analyze the existing codebase
3. Create tech-spine based on current architecture
4. Create product-system.md based on current features

This is an existing [project type] with [tech stack].
```

---

## Daily Usage

### Delivering a Feature

This is the most common workflow.

#### With Commands (Recommended)

```
/deliver user profile editing
```

That's it. Claude will:
1. Read all framework documents
2. Ask clarifying questions
3. Create feature definition (Gate 1)
4. Create execution plan (Gate 2)
5. Implement phase by phase
6. Deploy and validate (Gate 4)
7. Capture lessons (Gate 5)

#### Example with Commands

```
You: /deliver user profile editing

Claude: I have some clarifying questions:

1. What fields can users edit? (name, email, password, photo?)
2. Should email changes require verification?
3. Can users delete their profile?
...

You: Name, email, and photo. Yes to verification. Yes to delete.

Claude: Feature Definition Complete: FEAT-015

Requirements:
1. Users can edit name, email, photo
2. Email changes require verification
3. Users can delete profile
...

Does this match what you want?

You: Approved

Claude: [Creates execution plan]
Should I proceed with this plan?

You: Approved

Claude: Starting Phase 1...
[Implementation continues]
```

#### Advanced: With Full Prompts

If you need custom behavior:

```
I'm using behzad-framework.

I want to deliver: [describe feature]

Read:
- docs/product-system.md
- docs/tech-spine/ (all files)
- docs/learning/lessons.md

Follow deliver-flow.md.
Stop at decision gates in decision-gates.md.

[Any custom instructions here]
```

---

### Continuing a Paused Feature

```
/continue FEAT-015
```

Or for the most recent work:

```
/resume
```

Claude will pick up where you left off.

---

### Checking Feature Status

```
/status FEAT-015
```

Or for overall project status:

```
/status
```

---

### Updating Tech-Spine

If you made changes outside the framework:

```
/update-tech-spine
```

Claude will analyze your codebase and update the documentation.

---

### Adding Research

```
/add-research authentication strategies
```

Claude will help you capture research notes for future reference.

---

### Deploying a Feature

Deployment happens at Gate 4 in the deliver flow. You can also trigger it manually:

```
/deploy FEAT-015
```

---

### Rolling Back

If deployment has issues:

```
/rollback FEAT-015
```

---

## Command Reference

### All Commands

| Command | Purpose |
|---------|---------|
| `/deliver [feature]` | Start new feature delivery |
| `/init-new [name]` | Start new project |
| `/init-existing` | Add framework to existing project |
| `/continue [FEAT-ID]` | Resume paused feature |
| `/status [FEAT-ID]` | Check status |
| `/help [command]` | Get help |
| `/pause` | Pause current work |
| `/resume` | Resume most recent work |
| `/deploy [FEAT-ID]` | Deploy a feature |
| `/rollback [FEAT-ID]` | Rollback deployment |
| `/update-tech-spine` | Sync tech docs with code |
| `/show-lessons [tags]` | View lessons |
| `/list-features [filter]` | List features |
| `/show-roadmap` | View feature roadmap |
| `/show-metrics` | View delivery statistics |

For full details, see [command-guide.md](command-guide.md).

---

## Advanced: Custom Prompts

For situations not covered by commands, use full prompts.

### Basic Template

Always start with:

```
I'm using behzad-framework.
[Your specific request]
```

This tells Claude to read framework documents and follow the process

---

## Best Practices

### For Effective Use

#### 1. Use Commands

Use slash commands like `/deliver`, `/continue`, `/status`.

Commands automatically:
- Read the framework documents
- Follow the process
- Stop at decision gates

For custom needs, use full prompts starting with "I'm using behzad-framework."

---

#### 2. Read Gate Presentations

Don't blindly approve gates.

Read what Claude presents. Think. Decide.

Gates exist to prevent problems.

---

#### 3. Keep Documents Current

If you change something outside the framework process:
- Update the relevant documents
- Or tell Claude to update them

Stale documents = broken framework.

---

#### 4. Capture Lessons

After each feature, approve lessons.

Don't skip this. Lessons make future features easier.

---

#### 5. Use Research for Big Decisions

If a feature requires research:
- Do the research first
- Document in docs/research/
- Reference during feature delivery

Don't wing it on important technical decisions.

---

#### 6. Start Small

Your first feature with the framework:
- Choose something small (2-4 hours)
- Follow the process fully
- Learn how gates work
- Build confidence

Then tackle bigger features.

---

#### 7. Review Documents Weekly

Every week or two:
- Read product-system.md (are features up to date?)
- Scan lessons.md (are lessons still relevant?)
- Check tech-spine (is it accurate?)

Keep the framework healthy.

---

### For New Projects

#### Start with Vision

Before first feature:
1. Define product vision in product-system.md
2. Define architecture in tech-spine/
3. Set up development environment
4. Document setup in system-map.md

**Then** start delivering features.

---

#### Build Foundation First

First 2-3 features should establish foundation:
- Authentication
- Database setup
- Basic UI structure
- CI/CD pipeline

Document everything in tech-spine as you go.

---

### For Existing Projects

#### Gradual Adoption

Don't try to document everything at once.

**Phase 1:** Set up framework, document current state (rough)

**Phase 2:** Start using for new features

**Phase 3:** Refine documentation as you learn

**Phase 4:** Backfill documentation for important existing features

---

#### Focus on New Work

Use framework for all NEW features.

Don't worry about documenting every line of existing code.

Tech-spine should cover "what matters" not "everything."

---

## Troubleshooting

### Issue: Claude Doesn't Follow Framework

**Problem:** Claude skips steps or doesn't read documents.

**Solution:**

Always start with: "I'm using behzad-framework."

If Claude still doesn't follow:

```
I'm using behzad-framework for systematic feature delivery.

Read these documents FIRST:
- docs/product-system.md
- docs/tech-spine/ (all files)
- docs/learning/lessons.md
- deliver-flow.md
- decision-gates.md

I want to deliver: [feature]

Follow the deliver-flow.md process exactly.
Stop at each decision gate in decision-gates.md.
```

---

### Issue: Documents Get Stale

**Problem:** Tech-spine doesn't match actual code.

**Solution:**

After any change (inside or outside framework):

```
I'm using behzad-framework.

I changed [description of changes].

Update relevant tech-spine documents:
- Read current docs/tech-spine/
- Analyze changes
- Update appropriate files
- Show me what you updated
```

Make this a habit.

---

### Issue: Too Many Lessons

**Problem:** lessons.md has 100+ lessons, hard to read.

**Solution:**

Periodic review:

```
I'm using behzad-framework.

Review docs/learning/lessons.md:
1. Identify outdated lessons (tech changed, no longer relevant)
2. Identify duplicate lessons
3. Suggest which to deprecate or merge

Present recommendations.
```

Then approve cleanup.

---

### Issue: Unclear Requirements

**Problem:** Feature definition keeps changing.

**Solution:**

Take more time at Gate 1.

When Claude asks clarifying questions, think deeply.

Consider edge cases. Discuss with stakeholders if needed.

**Better to spend 30 minutes at Gate 1 than 6 hours redoing work.**

---

### Issue: Phases Too Large

**Problem:** Phases take 8+ hours, hard to resume.

**Solution:**

At Gate 2 (Execution Planning):

```
You: Phase 3 seems too large. Split it into smaller phases (1-2 hours each).

Claude: [Revises plan with smaller phases]
```

**Phases should be 1-4 hours.** No exceptions.

---

## Advanced Usage

### Custom Workflows

You can adapt the framework for specific needs:

#### Weekly Review Workflow

```
I'm using behzad-framework.

Weekly review:
1. Review all "In Progress" features in product-system.md
2. Check if any are blocked
3. Review last week's completed features
4. Check if lessons were captured
5. Suggest priorities for next week

Present summary.
```

---

#### Sprint Planning

```
I'm using behzad-framework.

Sprint planning:
1. Review "Planned" features in product-system.md
2. Based on team capacity of [X hours], recommend which features to tackle
3. Consider dependencies and priorities
4. Create suggested sprint plan

Present plan for approval.
```

---

#### Technical Debt Review

```
I'm using behzad-framework.

Technical debt review:
1. Scan decision-log.md for temporary decisions
2. Check lessons.md for recurring issues
3. Review tech-spine for "TODO" or "planned" items
4. Identify top 3 technical debt items to address

Present prioritized list.
```

---

### Multi-Developer Teams

Framework works for solo developers or small teams.

**For teams:**

1. **Shared docs/ folder** - Everyone reads and updates
2. **Gate approvals** - Tech lead or product owner approves gates
3. **Pull requests** - Tech-spine updates reviewed in PRs
4. **Weekly syncs** - Team reviews lessons.md together

---

### Integration with Project Management Tools

Framework complements (doesn't replace) tools like Jira, Linear, etc.

**Workflow:**

1. **Create Jira ticket** for feature
2. **Use framework** to deliver feature (docs/product-system.md, execution plan, etc.)
3. **Link feature ID** in Jira comments (e.g., "Implemented as FEAT-015, see docs/product-system.md")

Framework handles **how** work is done. PM tools handle **what** and **when**.

---

## Quick Reference

### Folder Structure

```
my-project/
├── docs/
│   ├── product-system.md          # Single source of product truth
│   ├── tech-spine/                # Technical knowledge (5 files)
│   ├── execution/                 # Current execution plans
│   ├── learning/                  # Lessons learned
│   └── research/                  # Deep research
├── src/                           # Your actual code
├── tests/                         # Your tests
└── [other project files]
```

---

### Key Commands

| Task | Command |
|------|---------|
| Deliver feature | `/deliver [feature]` |
| Continue feature | `/continue FEAT-[N]` |
| Check status | `/status FEAT-[N]` |
| Update tech-spine | `/update-tech-spine` |
| Deploy | `/deploy FEAT-[N]` |
| Rollback | `/rollback FEAT-[N]` |
| Get help | `/help` |

See [command-guide.md](command-guide.md) for complete list.

---

### Decision Gates

| Gate | When | What to Check |
|------|------|---------------|
| 1 | After Feature Definition | Requirements complete? Acceptance criteria clear? |
| 2 | After Execution Planning | Plan makes sense? Phases small? Tests included? |
| 3 | Before Each Phase (opt) | Previous phase OK? Ready to continue? |
| 4 | Before Production Deploy | All criteria met? Tests pass? Ready to ship? |
| 5 | After Learning Capture | Lessons valuable? Well written? |

---

### File Updates

| When You... | Update... |
|-------------|-----------|
| Start feature | product-system.md (add feature) |
| Change architecture | tech-spine/system-map.md |
| Add table/schema | tech-spine/data-model.md |
| Add API/service | tech-spine/service-map.md |
| Make big decision | tech-spine/decision-log.md |
| Change tests approach | tech-spine/test-strategy.md |
| Complete feature | product-system.md (mark complete), lessons.md |

---

## Getting Help

### Framework Questions

If unsure how to use the framework:

1. Read [philosophy.md](philosophy.md) - Understand why
2. Read [how-it-works.md](how-it-works.md) - Understand mechanics
3. Read [deliver-flow.md](deliver-flow.md) - Understand process
4. Read [examples/feature-delivery-example.md](examples/feature-delivery-example.md) - See example

### Technical Questions

For technical issues with your project (not framework):

Use Claude Code normally. Framework is for **process**, not replacing technical help.

---

## Summary

**To use behzad-framework:**

1. **Setup:** `/init-new` or `/init-existing` (once)
2. **Daily:** `/deliver [feature]` to start new work
3. **Resume:** `/continue [FEAT-ID]` to pick up where you left off
4. **Check:** `/status` to see progress
5. **Gates:** Approve at decision gates
6. **Learn:** Approve lessons after each feature

**The framework ensures:**
- Clear requirements
- Systematic execution
- Living documentation
- Continuous learning

**Your job:**
- Use commands to start work
- Approve at decision gates
- Stay engaged

**Claude's job:**
- Ask clarifying questions
- Plan execution
- Implement with tests
- Update documents
- Propose lessons

**Simple. Systematic. Effective.**

See [command-guide.md](command-guide.md) for all commands.
