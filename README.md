# AI Agents and Prompts

A collection of custom Claude Code agents and slash commands to enhance productivity and workflow automation.

## 📁 Repository Structure

```
AI-Agents-and-Prompts/
├── agents/                    # Custom Claude Code agents (8 total)
│   ├── chrome-extension-troubleshooter.md
│   ├── debug-coordinator.md
│   ├── feature-orchestrator.md
│   ├── figma-ui-engineer.md
│   ├── knowledge-navigator.md
│   ├── prompt-engineer.md
│   ├── security-auditor.md
│   └── test-suite-builder.md
├── .github/
│   └── ISSUE_TEMPLATE/        # GitHub issue templates
│       ├── feature.yml
│       ├── bug.yml
│       └── task.yml
├── commands/                  # Slash commands for workflow automation (19 total)
│   ├── Session Management/
│   │   ├── resume-session.md
│   │   └── resume-session-reset.md
│   ├── Task Management/
│   │   ├── add-task-simple.md
│   │   ├── add-task-complex.md
│   │   ├── add-task-discovered.md
│   │   └── add-task-emergency.md
│   ├── GitHub Integration/
│   │   ├── create-issue.md
│   │   ├── enrich-issue.md
│   │   ├── fix-issue.md
│   │   └── implement-feature.md
│   ├── Health Checks/
│   │   ├── health-check-quick.md
│   │   ├── health-check-velocity.md
│   │   ├── health-check-context.md
│   │   └── health-check-eod.md
│   └── CLAUDE.md Updates/
│       ├── update-architecture.md
│       ├── update-pattern.md
│       └── update-working-system.md
└── README.md
```

## 🤖 Agents

### 🔍 Debugging & Analysis

#### Debug Coordinator
**File:** `agents/debug-coordinator.md`
**Model:** Opus (most capable)
**Purpose:** Elite debugging command center for complex issues requiring systematic investigation.

**When to use:**
- Race conditions and intermittent bugs
- Memory leaks and performance degradation
- Production-only issues
- Multi-layer system problems requiring parallel investigation

**Example:** *"We have a race condition that only happens under high load"*

---

#### Knowledge Navigator
**File:** `agents/knowledge-navigator.md`
**Model:** Sonnet
**Purpose:** Expert at finding and understanding information across codebases and documentation.

**When to use:**
- Understanding system architecture
- Locating implementations and code examples
- Multi-source technical research
- "Code archaeology" tasks

**Example:** *"How does our authentication handle refresh tokens?"*

---

### 🛠️ Development & Implementation

#### Feature Orchestrator
**File:** `agents/feature-orchestrator.md`
**Model:** Opus
**Purpose:** Handles complex features (>4 hours) through parallel development or comprehensive planning.

**When to use:**
- Features requiring 7+ parallel tasks
- Complex features needing decomposition
- Creating detailed GitHub implementation plans

**Example:** *"Build a user dashboard with profile, activity feed, and settings"*

---

#### Figma UI Engineer
**File:** `agents/figma-ui-engineer.md`
**Model:** Sonnet
**Purpose:** Converts Figma designs into pixel-perfect React components.

**When to use:**
- Implementing designs from Figma files
- Ensuring design fidelity and accessibility
- Updating components to match new design specs

**Example:** *"Implement the dashboard header from the Figma file"*

---

### 🔐 Security & Quality

#### Security Auditor
**File:** `agents/security-auditor.md`
**Model:** Opus
**Purpose:** Identifies vulnerabilities using OWASP Top 10 framework with risk classification.

**When to use:**
- Pre-deployment security reviews
- Vulnerability scans and compliance checks
- Authentication/authorization audits
- SOC 2 / compliance preparation

**Example:** *"Review this authentication code before we deploy to production"*

---

#### Test Suite Builder
**File:** `agents/test-suite-builder.md`
**Model:** Sonnet
**Purpose:** Creates comprehensive test suites using TDD methodology.

**When to use:**
- Creating unit and integration tests
- TDD workflows (tests-first development)
- Improving test coverage
- Quality assurance before deployment

**Example:** *"I need comprehensive tests for this payment module"*

---

### 🎯 Specialized Tools

#### Prompt Engineer
**File:** `agents/prompt-engineer.md`
**Model:** Opus
**Purpose:** Meta-agent that creates/optimizes agent prompts and CLAUDE.md configuration.

**When to use:**
- Creating new custom agents
- Optimizing existing agent performance
- Improving CLAUDE.md delegation rules
- Debugging agent issues

**Example:** *"Create a new agent for database migration tasks"*

---

#### Chrome Extension Troubleshooter
**File:** `agents/chrome-extension-troubleshooter.md`
**Model:** Opus
**Purpose:** Expert for Chrome extension debugging and Manifest V3 compliance.

**When to use:**
- Service worker termination issues
- Manifest V3 migration problems
- Chrome Web Store submission failures
- CSP violations and API integration

**Example:** *"My extension service worker keeps crashing after 30 seconds"*

---

## 📋 GitHub Issue Templates

Three comprehensive templates optimized for AI-assisted development workflow.

### Feature Request (`feature.yml`)
**Purpose:** Structured feature specifications for autonomous implementation.

**Includes:**
- Problem statement (one sentence clarity)
- Proposed solution with user flow
- Success criteria (testable conditions)
- Complexity estimation (🟢 Simple / 🟡 Medium / 🔴 High / ⚫ Complex)
- Files to modify (with line estimates)
- Dependencies and blockers
- Security and performance considerations

**Complexity Guide:**
- 🟢 **Simple:** 15-25 msgs (30-45 min) - single agent
- 🟡 **Medium:** 30-50 msgs (1-2 hrs) - single agent + specialist
- 🔴 **High:** 50-100 msgs (2-4 hrs) - 2-3 parallel Tasks
- ⚫ **Complex:** 100+ msgs (multi-session) - parallel Tasks/worktrees

### Bug Report (`bug.yml`)
**Purpose:** Structured bug reports with reproduction steps and context.

**Includes:**
- Bug description (observed vs expected behavior)
- Reproduction steps
- Environment details (browser, OS, versions)
- Error messages and stack traces
- Impact assessment (severity/priority)
- Attempted solutions

### Task (`task.yml`)
**Purpose:** General development tasks and chores.

**Includes:**
- Task description
- Acceptance criteria
- Complexity estimate
- Dependencies
- Implementation notes

**Usage:**
```bash
# These templates appear when creating issues in your GitHub repo
# At: https://github.com/your-username/your-repo/issues/new/choose

# Or use the /create-issue slash command
/create-issue
```

---

## ⚡ Slash Commands

### Session Management

#### `/resume-session`
Resumes your previous work session by loading context from CLAUDE.md and recent commit history.

#### `/resume-session-reset`
Starts a fresh session with a clean slate while preserving important architecture context.

### Task Management

#### `/add-task-simple`
Adds a straightforward task to your todo list (< 2 hours complexity).

#### `/add-task-complex`
Adds a multi-step complex task with proper breakdown and planning.

#### `/add-task-discovered`
Adds tasks discovered during implementation (bugs found, refactors needed, etc.).

#### `/add-task-emergency`
Adds high-priority urgent tasks that need immediate attention.

### GitHub Integration

#### `/create-issue`
Creates a GitHub issue with proper template formatting (feature/bug/task).

#### `/enrich-issue <number>`
Researches the codebase and enriches a GitHub issue before implementation. Performs 15-25 minute deep-dive to:
- Find related components and reusable patterns
- Identify blockers and dependencies
- Validate complexity estimates with multi-factor scoring
- Check if Architecture Decision Record (ADR) is needed
- Post comprehensive findings as GitHub comment

Prevents mid-implementation surprises and improves planning accuracy.

**Example:**
```
/enrich-issue 123
```

**When to use:**
- Before starting any 🟡 Medium or 🔴 High complexity issue
- When issue lacks implementation details
- To validate initial complexity estimates
- Before feature decomposition decisions

#### `/fix-issue <number>`
Reads a GitHub issue, implements the fix, and creates a commit that closes it.

**Example:**
```
/fix-issue 123
```

#### `/implement-feature <number>`
Reads a feature issue, creates an implementation plan, executes it, and creates a PR.

**Example:**
```
/implement-feature 456
```

### Health Checks

#### `/health-check-quick`
Fast health check of current project status and blocking issues.

#### `/health-check-velocity`
Analyzes development velocity and identifies bottlenecks.

#### `/health-check-context`
Checks context usage and suggests when to compact conversation.

#### `/health-check-eod`
End-of-day health check with session summary and next steps.

### CLAUDE.md Updates

#### `/update-architecture`
Updates the architecture section in CLAUDE.md with new patterns or decisions.

#### `/update-pattern`
Documents a new code pattern or best practice in CLAUDE.md.

#### `/update-working-system`
Updates the "Current Context" section after completing significant work.

## 🚀 Installation

### Option 1: Manual Installation

1. **Clone this repository:**
   ```bash
   git clone https://github.com/Drewx-Design/AI-Agents-and-Prompts.git
   cd AI-Agents-and-Prompts
   ```

2. **Copy agents to your project:**
   ```bash
   # Copy all agents
   cp agents/*.md /path/to/your/project/.claude/agents/
   ```

3. **Copy slash commands:**
   ```bash
   # Copy all commands
   cp commands/*.md /path/to/your/project/.claude/commands/
   ```

4. **Copy GitHub issue templates:**
   ```bash
   # Copy templates to your repo
   cp -r .github/ISSUE_TEMPLATE /path/to/your/project/.github/
   ```

### Option 2: Symlink (Advanced)

Create symlinks to keep agents/commands synced across projects:

```bash
# For agents
ln -s /path/to/AI-Agents-and-Prompts/agents/*.md /path/to/your/project/.claude/agents/

# For commands
ln -s /path/to/AI-Agents-and-Prompts/commands/*.md /path/to/your/project/.claude/commands/
```

### Option 3: Global Installation

To use these across all projects, copy them to your global `.claude` directory:

**Windows:**
```powershell
cp agents\*.md $env:USERPROFILE\.claude\agents\
cp commands\*.md $env:USERPROFILE\.claude\commands\
```

**Mac/Linux:**
```bash
cp agents/*.md ~/.claude/agents/
cp commands/*.md ~/.claude/commands/
```

## 📝 Usage Guide

### Using Agents

Agents are invoked by Claude Code automatically when appropriate, or manually:

```
# Automatic (Claude detects the context)
User: "My Chrome extension service worker keeps crashing"
Claude: [automatically delegates to chrome-extension-troubleshooter]

# Manual invocation
User: "Use the chrome-extension-troubleshooter agent to analyze this error"
```

### Using Slash Commands

Slash commands are invoked with the `/` prefix:

```
/fix-issue 123
/implement-feature 456
/health-check-quick
/add-task-complex "Implement dark mode"
```

## 🛠️ Creating Your Own

### Agent Template

Create a new file in `agents/your-agent-name.md`:

```markdown
---
name: your-agent-name
description: Brief description of when to use this agent
model: opus  # or sonnet
color: blue  # visual indicator
---

You are an expert in [domain]. Your goal is to [objective].

## Expertise Areas
- Area 1
- Area 2

## Methodology
1. Step 1
2. Step 2

## Examples
[Provide code examples and patterns]
```

### Slash Command Template

Create a new file in `commands/your-command.md`:

```markdown
---
name: your-command
description: What this command does (shown in autocomplete)
---

Your command instructions here.
Use $ARGUMENTS to access command parameters.

Example:
Run task: $ARGUMENTS
```

## 🤝 Contributing

Contributions welcome! Please:

1. Fork this repository
2. Create a feature branch (`git checkout -b feature/amazing-agent`)
3. Commit your changes (`git commit -m 'Add amazing agent'`)
4. Push to the branch (`git push origin feature/amazing-agent`)
5. Open a Pull Request

## 📄 License

MIT License - feel free to use and modify for your projects.

## 🔗 Resources

- [Claude Code Documentation](https://docs.claude.com/)
- [Writing Custom Agents Guide](https://docs.claude.com/docs/claude-code/custom-agents)
- [Slash Commands Reference](https://docs.claude.com/docs/claude-code/slash-commands)

## 💡 Tips

- **Test agents locally first** before adding to production projects
- **Use descriptive names** for easy discovery
- **Document examples** to show expected behavior
- **Version control** your `.claude` directory for team sharing
- **Review periodically** and archive unused agents/commands

---

Made with ❤️ for better AI-assisted development
