---
name: fix-issue
description: Automatically analyze and fix a GitHub issue
---

# Fix GitHub Issue: #$ARGUMENTS

## Workflow

I will systematically fix the issue described in GitHub issue #$ARGUMENTS following this protocol:

### Phase 1: Issue Analysis (5 minutes)
1. Fetch full issue details: `gh issue view $ARGUMENTS --json number,title,body,labels,assignees`
2. Read and understand:
   - Problem description
   - Expected vs actual behavior
   - Reproduction steps (if bug)
   - Success criteria
   - Technical context
3. **STOP and confirm understanding** - Ask clarifying questions if needed

### Phase 2: Codebase Investigation (10 minutes)
1. Search for relevant files using Glob/Grep based on issue context
2. Read affected components and understand current implementation
3. Identify root cause (for bugs) or implementation approach (for features)
4. **STOP and present findings** - List files to modify and approach

### Phase 3: Implementation (variable)
1. Create todo list with TodoWrite tool for tracking
2. Implement changes following RULES.md standards:
   - Max 50 lines per function
   - TypeScript strict mode
   - Proper error handling
   - MV3 compliance for Chrome extension code
3. Update related tests or create new tests
4. Run TypeScript check: `npx tsc --noEmit`
5. Run relevant tests: `timeout 30 npx vitest run --no-coverage [test-path]`

### Phase 4: Validation (10 minutes)
1. Build verification: `npm run build`
2. Manual testing if needed
3. Ensure all acceptance criteria met
4. Check performance (<500ms, <50MB)

### Phase 5: Commit & Close (5 minutes)
1. Commit with proper format: `fix: resolve #$ARGUMENTS - [brief description]`
   - Use "fix:" for bugs
   - Use "feat:" for features
   - Use "refactor:" for code improvements
2. If user requests PR:
   - Create PR: `gh pr create --title "[type]: [title]" --body "Closes #$ARGUMENTS\n\n[Description]\n\n## Testing\n[How to test]\n\n## Performance\n[Impact notes]"`

## Critical Rules
- **ALWAYS ask before implementing** - Present approach and get approval
- **Follow RULES.md** - Max 50 lines/function, proper TypeScript, MV3 compliance
- **Test everything** - Run tests before committing
- **Use TodoWrite** - Track progress for complex fixes (>3 steps)
- **Commit atomically** - One fix = one commit with proper message format

## Auto-Close Behavior
This commit message format will automatically close the issue:
- `fix: resolve #123` ✅
- `feat: implement #123` ✅
- `refactor: improve #123` ❌ (does not auto-close, use "fix" or "feat")
