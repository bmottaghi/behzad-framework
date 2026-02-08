# behzad-framework

An AI-driven Product & Engineering Operating System for delivering software features end-to-end with clarity and discipline.

---

## What This Is

**behzad-framework** is a process framework, not a code library.

It helps you deliver features from idea to deployment using AI as your virtual team.

Instead of juggling scattered documents, unclear requirements, and fragmented knowledge, this framework gives you:

- **One clear process** - From vague idea to deployed feature
- **Living documents** - Always up to date, never stale
- **AI as your team** - Product Manager, Architect, Engineer, QA, DevOps, and Historian roles
- **Decision gates** - AI stops and asks for your approval at critical points
- **Learning system** - Captures lessons to prevent repeated mistakes

The framework is designed for **non-technical Product Leaders** who want to ship features systematically using AI tools like Claude Code.

---

## Quick Start with Commands

```
# Start a new feature
/deliver user authentication

# Check status
/status FEAT-001

# Continue paused work
/continue FEAT-001

# Get help
/help
```

Commands expand into full prompts automatically. No memorization needed.

See [command-guide.md](command-guide.md) for all available commands.

For complete command documentation, see [commands.md](commands.md).

---

## Who This Is For

You should use this framework if you:

- Lead product development but aren't deeply technical
- Work with AI coding assistants (like Claude Code in VSCode)
- Want clear, documented processes without bureaucracy
- Need to deliver features reliably and learn from each delivery
- Work solo or with a small team
- Value clarity over complexity

---

## Who This Is NOT For

This framework is **not designed** for:

- Large enterprise teams with complex approval hierarchies
- Projects that don't use AI coding assistants
- Teams that prefer minimal documentation
- People looking for a code library or task runner
- Organizations that need extensive customization and tooling

If you need heavy processes, compliance workflows, or enterprise-grade project management, look elsewhere.

---

## How It Works (High Level)

You state your intent: **"I want to deliver this feature."**

The framework guides you through:

1. **Clarification** - AI asks questions to understand what you really want
2. **Definition** - Feature gets defined clearly in the product document
3. **Impact Analysis** - AI checks the technical architecture to understand what changes
4. **Planning** - Work is broken into small, safe phases
5. **Implementation** - AI writes code and tests together, phase by phase
6. **Review** - You approve before release
7. **Deployment** - Feature gets deployed with proper versioning
8. **Validation** - System checks that deployment succeeded
9. **Learning** - Lessons are captured for future work

All of this happens through **living documents** that stay current. No document explosion. No stale documentation.

---

## Core Guarantees

When you use this framework correctly:

1. **Features are clearly defined before implementation** - No more building the wrong thing
2. **Technical impact is understood upfront** - No surprise breaking changes
3. **Work happens in small, testable phases** - No long, fragile executions
4. **AI stops at critical points for your approval** - You stay in control
5. **All decisions are documented** - Future you will understand why
6. **Lessons are captured and reused** - Mistakes aren't repeated

---

## What Makes This Different

Most development frameworks focus on code structure or task management.

**This framework focuses on clarity and discipline in the delivery process.**

- **Intent-based** - You say what you want, the system handles the rest
- **Token-efficient** - AI doesn't rescan your entire codebase every time
- **Resumable** - Work can pause and resume safely across phases
- **Self-improving** - Gets better with each feature you deliver

The framework treats **documentation as the source of truth**, not your codebase.

AI reads compact technical summaries instead of scanning thousands of lines of code.

This makes the process faster, cheaper, and more reliable.

---

## Installation

### Option 1: New Project (Clone)

```bash
git clone https://github.com/bmottaghi/behzad-framework.git my-project
cd my-project
code .
```

Open in VSCode with Claude Code extension. Commands work automatically!

Then type `/init-new my-project` to set up your project.

### Option 2: Existing Project (Git Submodule) ⭐ Recommended

This method allows easy updates when the framework improves.

**Step 1: Add as submodule**
```bash
cd your-project
git submodule add https://github.com/bmottaghi/behzad-framework.git .behzad
```

**Step 2: Run setup script**

Linux/Mac:
```bash
chmod +x .behzad/setup.sh && ./.behzad/setup.sh
```

Windows (PowerShell):
```powershell
.\.behzad\setup.ps1
```

**Step 3: Initialize**
```
/init-existing
```

### Updating the Framework

When the framework gets updates:

```bash
# Pull latest changes
git submodule update --remote .behzad

# Re-run setup (Windows only, if not using symlinks)
.\.behzad\setup.ps1 -Force
```

If using symlinks (Linux/Mac or Windows with Developer Mode), updates apply automatically!

### Option 3: Manual Copy (Not Recommended)

If you prefer not to use submodules:

**Linux/Mac:**
```bash
cd your-project
git clone https://github.com/bmottaghi/behzad-framework.git .behzad-temp
cp .behzad-temp/CLAUDE.md .
cp -r .behzad-temp/.claude .
rm -rf .behzad-temp
```

**Windows (PowerShell):**
```powershell
cd your-project
git clone https://github.com/bmottaghi/behzad-framework.git .behzad-temp
cp .behzad-temp\CLAUDE.md .
cp -Recurse -Force .behzad-temp\.claude .
rm -Recurse -Force .behzad-temp
```

Then type `/init-existing` to analyze your codebase and create framework docs.

> **Note:** With manual copy, you'll need to repeat these steps to get updates.

---

## Getting Started

### Fastest Path (Commands)

1. **Install the framework** (see Installation above)
2. **Set up your project**: `/init-existing` or `/init-new my-project`
3. **Deliver your first feature**: `/deliver user authentication`
4. **Check progress**: `/status`

See [command-guide.md](command-guide.md) for all commands.

### Full Understanding

1. **Read the philosophy** - Understand the core principles: [philosophy.md](philosophy.md)
2. **Understand how it works** - Learn the system mechanics: [how-it-works.md](how-it-works.md)
3. **Set up your project** - Follow the usage guide: [usage.md](usage.md)
4. **Deliver your first feature** - Follow the deliver flow: [deliver-flow.md](deliver-flow.md)

### Examples

- [Command-based example](examples/command-based-example.md) - Using slash commands (recommended)
- [Prompt-based example](examples/feature-delivery-example.md) - Using full prompts (advanced)

---

## Project Structure

```
behzad-framework/
├── README.md              # You are here
├── commands.md            # Command definitions (core)
├── command-guide.md       # Command quick reference
├── philosophy.md          # Core principles
├── how-it-works.md        # System architecture
├── usage.md               # How to use this framework
├── deliver-flow.md        # Main delivery workflow
├── decision-gates.md      # When AI stops for approval
├── docs/                  # Your project documents (living, always current)
│   ├── product-system.md  # Single source of product truth
│   ├── tech-spine/        # Compact technical knowledge
│   ├── execution/         # Current execution plans
│   ├── learning/          # Lessons learned
│   └── research/          # External research input
└── examples/              # Complete examples
```

---

## Frequently Asked Questions

### Does this replace my existing project management tool?

No. This framework focuses on the **delivery process**, not task tracking.

You can still use Jira, Linear, Asana, or whatever you prefer for task management.

This framework complements those tools by ensuring work is clearly defined, well-planned, and properly documented.

### Can I use this with existing projects?

Yes. The framework can analyze your existing codebase and create initial technical documents.

From that point forward, you follow the deliver flow for new features.

See [usage.md](usage.md) for details on integrating with existing projects.

### What if I don't use Claude Code?

The framework is designed to work with AI coding assistants in general.

While optimized for Claude Code, you can adapt the prompts and workflows for other AI tools.

The core principles (living documents, decision gates, phased execution) work regardless of the AI tool.

### How much overhead does this add?

Very little if done correctly.

Most of the "work" is AI asking you clarifying questions and updating documents automatically.

The decision gates add deliberate pause points, which save time by catching issues early.

You spend **more time thinking upfront** and **less time fixing problems later**.

### Is this overkill for small features?

The framework scales to the size of the work.

Small features move through the process quickly with minimal documentation.

Large features get properly broken down and tracked.

The key is that **every feature follows the same process**, which builds discipline and consistency.

---

## Philosophy

This framework is built on six core principles:

1. **Intent-based usage** - State what you want, the system handles execution
2. **Single source of truth** - A few living documents, always current
3. **Decision gates** - AI stops at critical points for approval
4. **Token-efficient** - AI reads summaries, not entire codebases
5. **Resumable execution** - Work is broken into phases with checkpoints
6. **Continuous learning** - Lessons are captured and reused

Read more in [philosophy.md](philosophy.md).

---

## Contributing

This framework is designed to be simple and focused.

If you want to suggest improvements:

1. Use it on real projects first
2. Document what worked and what didn't
3. Propose specific, simple changes

We value **clarity over features** and **simplicity over complexity**.

---

## License

MIT License - Use this however you want.

See [LICENSE](LICENSE) for details.

---

## Credits

Created by Behzad for systematic, AI-driven feature delivery.

Built on the principles of clarity, discipline, and continuous learning.

---

**Remember**: This is not a tool. This is a process.

The value comes from following it consistently, not from installing software.

Start with [philosophy.md](philosophy.md) to understand why this framework exists and how it thinks.
