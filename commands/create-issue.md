---
name: create-issue
description: Create a well-formatted GitHub issue with proper template
---

# Create GitHub Issue: $ARGUMENTS

## Issue Creation Protocol

I will create a properly formatted GitHub issue based on your description.

### Phase 1: Classify Issue Type (2 minutes)

Based on your description "$ARGUMENTS", I will determine the issue type:

- **Feature Request** → Use if: "add", "implement", "create", "new feature"
- **Bug Report** → Use if: "broken", "error", "fails", "doesn't work", "bug"
- **Development Task** → Use if: "refactor", "improve", "update", "optimize", "tech debt"

### Phase 2: Gather Required Information (5 minutes)

I will ask clarifying questions based on the issue type:

#### For Features:
- What problem does this solve?
- How should it work?
- Complexity estimate (Simple/Medium/High)?
- Priority (Critical/High/Medium/Low)?
- Success criteria?

#### For Bugs:
- What's the current (broken) behavior?
- What's the expected (correct) behavior?
- Steps to reproduce?
- How often does it occur?
- Any console errors?

#### For Tasks:
- What needs to be done?
- Why is this important?
- Which files are affected?
- Acceptance criteria?

### Phase 3: Format Issue Body (3 minutes)

I will structure the issue body using the appropriate template format.

**Example for Feature:**
```yaml
Problem Statement:
Currently, users cannot [X]. This means they have to [workaround].

Proposed Solution:
1. Add a button in the [location]
2. When clicked, it should [behavior]
3. This will allow users to [benefit]

Complexity: 🟡 Medium (2-4 hours, multiple components)
Priority: ⚡ High (Important for user experience)

Success Criteria:
- [ ] Feature X works in UI
- [ ] Tests pass
- [ ] Performance <500ms
- [ ] Memory <50MB

Technical Notes:
Affected files:
- src/components/[Component].tsx
- src/lib/[service].ts
```

### Phase 4: Create Issue via gh CLI (2 minutes)

```bash
# Feature
gh issue create \
  --title "[FEATURE] [Concise title from description]" \
  --label "enhancement,needs-triage" \
  --body "[Formatted body from Phase 3]"

# Bug
gh issue create \
  --title "[BUG] [Concise title from description]" \
  --label "bug,needs-triage" \
  --body "[Formatted body from Phase 3]"

# Task
gh issue create \
  --title "[TASK] [Concise title from description]" \
  --label "task" \
  --body "[Formatted body from Phase 3]"
```

### Phase 5: Post-Creation Actions (2 minutes)

After creating the issue, I will:

1. **Display the issue number**: "✅ Created issue #123"
2. **Show the issue URL**: "View at: https://github.com/[repo]/issues/123"
3. **Ask follow-up questions**:
   ```
   What would you like to do next?
   - Assign to someone? (gh issue edit 123 --add-assignee @username)
   - Add to milestone? (gh issue edit 123 --milestone "Sprint X")
   - Set priority label? (gh issue edit 123 --add-label "priority-high")
   - Start working on it now? (I can use /fix-issue 123 or /implement-feature 123)
   ```

## Examples

### Example 1: Feature Request
```
User: "Create an issue for adding dark mode support"

Claude:
1. Classifies as Feature Request
2. Asks:
   - "What problem does this solve?" → "Users want dark mode for eye strain"
   - "Complexity?" → "Medium (multiple components need theming)"
   - "Priority?" → "Medium (nice to have)"
3. Creates issue with gh CLI:
   gh issue create --title "[FEATURE] Add dark mode support" --label "enhancement,needs-triage"
4. Returns: "✅ Created issue #124. Would you like to start implementing it now?"
```

### Example 2: Bug Report
```
User: "Create an issue for prompts jumping to top when copied"

Claude:
1. Classifies as Bug Report
2. Asks:
   - "What's the expected behavior?" → "Prompts should stay in place"
   - "How often?" → "Always (100%)"
   - "Steps to reproduce?" → [guides user to provide steps]
3. Creates issue with gh CLI:
   gh issue create --title "[BUG] Prompts jump to top of list when copied" --label "bug,needs-triage"
4. Returns: "✅ Created issue #125. Should I investigate and fix this now?"
```

### Example 3: Task
```
User: "Create an issue to refactor sync service to use async/await"

Claude:
1. Classifies as Development Task
2. Asks:
   - "Why is this important?" → "Better error handling and readability"
   - "Which files?" → "sync-service.ts, sync-queue.ts"
3. Creates issue with gh CLI:
   gh issue create --title "[TASK] Refactor sync service to use async/await" --label "task"
4. Returns: "✅ Created issue #126. This looks like a ~2 hour task. Want me to start?"
```

## Critical Rules

- ✅ **ALWAYS ask clarifying questions** - Don't assume details
- ✅ **ALWAYS use proper title format** - [TYPE] followed by concise description
- ✅ **ALWAYS add appropriate labels** - helps with filtering and triage
- ✅ **ALWAYS return issue number** - user needs this for tracking
- ✅ **ALWAYS offer next actions** - assign, milestone, or start working
- ❌ **NEVER auto-create without user confirmation** for non-critical issues
- ❌ **NEVER skip the template structure** - ensures consistency

## Auto-Create Exceptions

Only auto-create issues WITHOUT asking when:
- **Security vulnerability** (HIGH/CRITICAL severity)
- **Production crash** with stack trace
- **Data loss event** detected

For everything else, suggest creating the issue but wait for user confirmation.
