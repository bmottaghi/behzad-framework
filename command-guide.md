# Command Guide

**Your quick reference for using behzad-framework commands.**

Commands make it easy to work with the framework without memorizing long prompts.

---

## Quick Start

### New Project

```
/init-new my-project-name
```

This creates a fresh project with all framework documents ready.

### Existing Project

```
/init-existing
```

This analyzes your codebase and creates framework documents.

### Deliver a Feature

```
/deliver user authentication
```

This starts the full 9-phase delivery process.

### Resume Work

```
/continue FEAT-001
```

This picks up where you left off.

---

## Command Cheat Sheet

| Command | What it does |
|---------|--------------|
| `/deliver [feature]` | Start new feature delivery |
| `/continue [FEAT-ID]` | Resume paused feature |
| `/status` | Check overall status |
| `/status [FEAT-ID]` | Check specific feature status |
| `/help` | Show all commands |
| `/pause` | Pause current work |
| `/resume` | Resume most recent work |

---

## All Commands by Category

### Starting Out

| Command | Example | Description |
|---------|---------|-------------|
| `/init-new` | `/init-new my-app` | Start a brand new project |
| `/init-existing` | `/init-existing` | Add framework to existing project |
| `/help` | `/help deliver` | Get help on any command |

### Delivering Features

| Command | Example | Description |
|---------|---------|-------------|
| `/deliver` | `/deliver search functionality` | Start delivering a new feature |
| `/continue` | `/continue FEAT-001` | Resume a paused feature |
| `/status` | `/status FEAT-002` | Check feature progress |
| `/plan` | `/plan FEAT-001` | View/edit execution plan |

### Controlling Execution

| Command | Example | Description |
|---------|---------|-------------|
| `/pause` | `/pause` | Pause current work |
| `/resume` | `/resume` | Resume most recent work |
| `/deploy` | `/deploy FEAT-001` | Deploy a feature |
| `/rollback` | `/rollback FEAT-001` | Rollback a deployment |

### Managing Documents

| Command | Example | Description |
|---------|---------|-------------|
| `/update-tech-spine` | `/update-tech-spine` | Sync tech docs with code |
| `/show-lessons` | `/show-lessons auth` | View lessons by tag |
| `/list-features` | `/list-features p0` | List features (filtered) |
| `/add-research` | `/add-research caching` | Add research notes |
| `/sync-docs` | `/sync-docs` | Ensure docs are consistent |

### Getting Information

| Command | Example | Description |
|---------|---------|-------------|
| `/show-roadmap` | `/show-roadmap` | View feature roadmap |
| `/show-metrics` | `/show-metrics` | View delivery statistics |
| `/search-decisions` | `/search-decisions database` | Search decision log |

---

## Common Workflows

### Workflow 1: First Time Setup

```
# For new project:
/init-new my-project

# For existing project:
/init-existing
```

### Workflow 2: Deliver a Feature

```
# Start delivery
/deliver user login with email and password

# AI will guide you through 9 phases
# Just respond to decision gates

# If you need to pause
/pause

# Resume later
/continue FEAT-001
```

### Workflow 3: Check What's Happening

```
# Overall status
/status

# Specific feature
/status FEAT-001

# View roadmap
/show-roadmap
```

### Workflow 4: Learn from Past Work

```
# View all lessons
/show-lessons

# View specific lessons
/show-lessons performance
/show-lessons auth,security
```

### Workflow 5: Keep Docs Updated

```
# After making code changes outside the framework
/update-tech-spine

# Check all docs are consistent
/sync-docs
```

---

## Tips

### Be Descriptive with /deliver

**Good:**
```
/deliver user authentication with email and password, including password reset
```

**Less Good:**
```
/deliver auth
```

The more you describe, the better the clarification phase goes.

### Use /status Often

Check status to see where things stand:
```
/status
```

This helps you stay oriented, especially when resuming work.

### Trust the Process

The framework guides you through decision gates. Don't skip them:
- Gate 1: Feature definition approval
- Gate 2: Execution plan approval
- Gate 3: Pre-deploy review
- Gate 4: Production deploy approval
- Gate 5: Lessons approval

Each gate catches problems early.

### Use /pause When Needed

Need to step away? Use `/pause` to save state cleanly.

The framework tracks your progress in documents, so nothing is lost.

### Filter with /show-lessons

Looking for specific knowledge:
```
/show-lessons testing
/show-lessons performance
/show-lessons auth,security
```

Tags help you find relevant lessons.

---

## Troubleshooting

### "Command not recognized"

Make sure you're using the exact command syntax. Check `/help` for the list.

### "Feature not found"

Check the feature ID with `/list-features`. Feature IDs are like FEAT-001.

### "No work in progress"

Use `/status` to see what's available, then `/deliver` to start new work.

### "Documents out of sync"

Run `/sync-docs` to check and fix document consistency.

### "Tech-spine outdated"

Run `/update-tech-spine` after making code changes outside the framework.

---

## Getting Help

```
# All commands
/help

# Specific command
/help deliver
/help continue
/help status
```

---

## Full Documentation

- [commands.md](commands.md) - Complete command definitions
- [deliver-flow.md](deliver-flow.md) - The 9-phase delivery process
- [decision-gates.md](decision-gates.md) - The 5 approval points
- [philosophy.md](philosophy.md) - Core principles
- [usage.md](usage.md) - Detailed usage guide

---

## Quick Reference Card

```
STARTING:
  /init-new [name]     Start new project
  /init-existing       Add to existing project

DELIVERING:
  /deliver [feature]   Start new feature
  /continue [ID]       Resume feature
  /status [ID]         Check status

CONTROLLING:
  /pause               Pause work
  /resume              Resume work
  /deploy [ID]         Deploy feature
  /rollback [ID]       Rollback deploy

DOCUMENTS:
  /update-tech-spine   Sync tech docs
  /show-lessons [tag]  View lessons
  /list-features       List features
  /sync-docs           Check consistency

INFO:
  /show-roadmap        View roadmap
  /show-metrics        View metrics
  /help [cmd]          Get help
```

Copy this and keep it handy!
