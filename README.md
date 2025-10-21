# AI Agents and Prompts

A collection of custom Claude Code agents and slash commands to enhance productivity and workflow automation.

## 📁 Repository Structure

```
AI-Agents-and-Prompts/
├── agents/                    # Custom Claude Code agents
│   └── chrome-extension-troubleshooter.md
├── commands/                  # Slash commands for workflow automation
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

### Chrome Extension Troubleshooter
**File:** `agents/chrome-extension-troubleshooter.md`
**Purpose:** Expert agent for debugging Chrome extension issues, service worker errors, Manifest V3 compliance, and Chrome Web Store validation.

**When to use:**
- Service worker termination issues
- Manifest V3 migration problems
- Chrome Web Store submission failures
- CSP violations and security issues
- Extension API integration problems

**Usage in Claude Code:**
```
Use the chrome-extension-troubleshooter agent to debug this service worker issue
```

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
