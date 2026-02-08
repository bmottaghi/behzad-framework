**behzad-framework Commands**

$ARGUMENTS

**Getting Started:**
| Command | Description |
|---------|-------------|
| `/init-new [name]` | Start new project with framework |
| `/init-existing` | Add framework to existing project |

**Core Workflow:**
| Command | Description |
|---------|-------------|
| `/deliver [feature]` | Start new feature delivery |
| `/continue [FEAT-ID]` | Resume paused feature |
| `/status [FEAT-ID]` | Check status (feature or project) |

**Execution Control:**
| Command | Description |
|---------|-------------|
| `/plan [FEAT-ID]` | View/update execution plan |
| `/deploy [FEAT-ID]` | Deploy a feature |
| `/rollback [FEAT-ID]` | Rollback deployment |
| `/pause` | Pause current work |
| `/resume` | Resume most recent work |

**Documents:**
| Command | Description |
|---------|-------------|
| `/update-tech-spine` | Sync tech docs with code |
| `/show-lessons [tags]` | View lessons by tag |
| `/list-features [filter]` | List features |
| `/add-research [topic]` | Add research notes |
| `/sync-docs` | Check document consistency |

**Query:**
| Command | Description |
|---------|-------------|
| `/show-roadmap` | View feature roadmap |
| `/show-metrics` | View delivery metrics |
| `/search-decisions [keyword]` | Search decision log |

**Tips:**
- Start with `/init-existing` or `/init-new`
- Use `/deliver` for new features
- Use `/continue` to resume work
- Use `/status` to check progress

**Documentation:**
- Read `philosophy.md` for core principles
- Read `deliver-flow.md` for the 9-phase process
- Read `command-guide.md` for detailed command docs

Type `/help [command]` for help on a specific command.
