---
name: implement-feature
description: Implement a feature from GitHub issue with proper planning
---

# Implement Feature from GitHub Issue: #$ARGUMENTS

## Systematic Implementation Protocol

### Phase 1: Requirements Gathering (10 minutes)

1. **Fetch Issue Details:**
   ```bash
   gh issue view $ARGUMENTS --json number,title,body,labels,complexity
   ```

2. **Analyze Complexity:**
   - Review feature requirements thoroughly
   - Identify all affected components
   - Count subtasks (if 7+, consider @feature-orchestrator agent)
   - Check for integration points

3. **Assess Scope:**
   - 🟢 **Simple** (<2 hours): Single component, clear implementation → Proceed directly
   - 🟡 **Medium** (2-4 hours): Multiple components → Create detailed plan
   - 🔴 **High** (>4 hours): Complex integration → Recommend @feature-orchestrator

### Phase 2: Planning (15-30 minutes)

**Create comprehensive implementation plan:**

1. **List all files** to create/modify
2. **Break down into phases:**
   - Phase 1: Data/types layer
   - Phase 2: Logic/service layer
   - Phase 3: UI components
   - Phase 4: Integration
   - Phase 5: Testing
3. **Identify risks and dependencies**
4. **Estimate realistic timeline**

**🛑 CRITICAL: WAIT for user approval before coding!**

Present the plan in this format:
```
## Implementation Plan for Issue #$ARGUMENTS

### Files to Create
- `src/components/NewComponent.tsx` - Purpose
- `src/lib/new-service.ts` - Purpose

### Files to Modify
- `src/components/ExistingComponent.tsx` - Add X functionality
- `src/lib/existing-service.ts` - Integrate with Y

### Implementation Phases
1. **Phase 1**: Data layer (30 min)
   - Create types in `types.ts`
   - Update database schema if needed

2. **Phase 2**: Service logic (45 min)
   - Implement core functionality
   - Add error handling

... (continue for all phases)

### Risks
- Risk 1: Potential conflict with X feature
- Risk 2: Performance impact on Y operation

### Testing Strategy
- Unit tests for service logic
- Component tests for UI
- E2E test for complete workflow

**Estimated Total Time**: X hours
**Ready to proceed? (yes/no)**
```

### Phase 3: Implementation (variable)

**Only proceed after user approval!**

1. **Initialize TodoWrite** with all phases
2. **Work through plan systematically**:
   - Mark phase as "in_progress"
   - Implement phase
   - Run tests for phase
   - Mark phase as "completed"
   - Move to next phase

3. **Follow RULES.md standards**:
   - Max 50 lines per function, 150 per file
   - ES modules (import/export)
   - Async/await (not .then())
   - Functional React components
   - TypeScript strict mode

4. **Quality gates at each phase**:
   - TypeScript: `npx tsc --noEmit`
   - Tests: `timeout 30 npx vitest run --no-coverage [relevant-tests]`
   - Build: `npm run build` (before final commit)

### Phase 4: Testing & Validation (20-30 minutes)

1. **Run full test suite**:
   ```bash
   timeout 90 npx vitest run --no-coverage test/
   ```

2. **Manual testing**:
   - Load extension in chrome://extensions
   - Test complete user workflow
   - Verify performance (<500ms load, <50MB memory)

3. **Verify acceptance criteria** from issue:
   - Check each checkbox in issue's success criteria
   - Document any deviations

### Phase 5: Commit & PR Creation (10 minutes)

1. **Commit with proper format**:
   ```bash
   git add [files]
   git commit -m "feat: implement #$ARGUMENTS - [brief description]"
   ```

2. **Create Pull Request**:
   ```bash
   gh pr create --title "feat: [Feature Name]" --body "$(cat <<'EOF'
   Closes #$ARGUMENTS

   ## Summary
   [Describe what was implemented]

   ## Changes
   - Added X component for Y functionality
   - Modified Z service to support...

   ## Testing
   1. Load extension
   2. Open side panel
   3. Test feature X
   4. Verify Y behavior

   ## Performance Impact
   - Load time: [before] → [after]
   - Memory: [measurement]
   - No regression detected

   ## Screenshots (if applicable)
   [Add before/after screenshots]
   EOF
   )"
   ```

## Decision Tree

```
Issue Complexity Assessment:
├── Simple (< 2 hours)
│   └── Proceed with abbreviated plan → implement → test → commit
│
├── Medium (2-4 hours)
│   └── Create detailed plan → GET APPROVAL → implement → test → PR
│
└── High (> 4 hours)
    ├── Consider: Delegate to @feature-orchestrator?
    │   └── Ask user: "This is complex (7+ subtasks). Should I delegate?"
    └── If proceeding: Create very detailed plan → GET APPROVAL → phased implementation
```

## Critical Rules

- ✅ **ALWAYS create a plan first** (even for simple features)
- ✅ **ALWAYS wait for approval** before writing code
- ✅ **ALWAYS use TodoWrite** for tracking (unless trivial 1-step task)
- ✅ **ALWAYS run tests** before committing
- ✅ **ALWAYS check MV3 compliance** for Chrome extension code
- ❌ **NEVER skip planning phase**
- ❌ **NEVER proceed without approval**
- ❌ **NEVER commit without testing**
