---
name: enrich-issue
description: Research codebase and enrich GitHub issue before implementation
---

# Enrich Issue: #$ARGUMENTS

## Objective

Research the codebase and external resources to enrich issue #$ARGUMENTS with implementation context. Prevents mid-implementation surprises and improves planning accuracy.

**Time Budget:** 15-25 minutes total

---

## Phase 1: Issue Analysis (2 min)

**Load and verify issue:**
```bash
# Check if already enriched
gh issue view $ARGUMENTS --json labels --jq '.labels[].name' | grep -q "enriched" && \
  echo "⚠️ Issue already enriched. Proceeding with update..."

# Check if blocked
gh issue view $ARGUMENTS --json labels --jq '.labels[].name' | grep -q "blocked" && \
  echo "🛑 Issue marked as blocked. Review blockers before enriching."

# Load issue details
gh issue view $ARGUMENTS --json title,body,labels
```

**Understand the request:**
- What feature/bug/task is being requested?
- What's the user's stated goal?
- What complexity was initially estimated?

**🛑 CHECKPOINT:** "I understand this requests [description]. Starting codebase and external research."

---

## Phase 2: Codebase Research (10-15 min)

### A. Find Related Components

**Search for relevant code:**
```bash
# Find files/components mentioned in issue
grep -r "[key-term]" src/

# Find similar features/patterns
grep -r "[similar-concept]" src/
```

**Document:**
```markdown
**Related Components:**
- [file:line] - [description] (can reuse: Y/N)
```

### B. External Research (For Complex Features)

**For 🟡 Medium+ complexity, research established patterns:**
```bash
# Search for best practices, security considerations, performance benchmarks
# Use web search or docs lookup if available
```

**Document:**
```markdown
**External Insights:**
- Best practices: [source] - [summary]
- Performance: [benchmark/consideration]
- Security: [concern/pattern]
- Accessibility: [requirement]
```

**Skip if:** 🟢 Simple feature with clear internal patterns.

### C. Identify Patterns & Architecture

**Check existing patterns:**
1. Similar components to copy?
2. State management approach used?
3. Styling/animation patterns?
4. API/data handling patterns?

**Assess architectural impact:**
- [ ] Introduces new pattern? → Consider ADR
- [ ] Changes data models? → Migration needed?
- [ ] New external dependency? → Security review?
- [ ] Performance-critical path? → Benchmark needed?

**Document:**
```markdown
**Patterns to Follow:**
- Component: [example-file] (reusable: X%)
- State: [approach] at [location]
- Styling: [variables/animations]
- Data: [storage/API pattern]

**Architecture Impact:**
[None / List concerns]
```

### D. Files & Effort Estimation

**List specific files:**
```markdown
**Core Files (MODIFY):**
1. [path] - [change] (~X lines)

**New Files (CREATE):**
1. [path] - [purpose] (~X lines)

**Tests (ADD/UPDATE):**
1. [test-path] - [coverage]

**Docs (UPDATE if needed):**
- [doc-path] - [reason]

**Total Effort:** [files] files, [lines] estimated lines
```

### E. Blocker Analysis (CRITICAL)

**Check for absolute blockers:**
```bash
# Search for TODOs/FIXMEs in related files
rg -i "todo|fixme|hack" [files]

# Verify dependencies exist
grep -r "import.*[suspected-module]" src/

# Check API contracts if backend involved
```

**Blocker Decision Matrix:**

| Blocker | Severity | Resolution | ETA | Action |
|---------|----------|------------|-----|--------|
| [issue] | High/Med/Low | [path] | [time] | Proceed/Wait/Pivot |

**DECISION:**
- ✅ **Proceed:** No blockers OR all resolve in <1 day
- ⏸️ **Wait:** Blockers need external resolution
- 🔄 **Pivot:** Blockers suggest different approach

### F. Complexity Validation

**Multi-factor scoring (0-20 scale):**

```markdown
**Complexity Factors:**
- Files to touch: [count] × 1 = [X] pts
- New patterns: [count] × 3 = [X] pts
- Integration points: [count] × 2 = [X] pts
- External dependencies: [count] × 2 = [X] pts
- Testing complexity: [simple=1/complex=3] = [X] pts
- Technical unknowns: [0-5 scale] = [X] pts

**Total Score:** [X]/20

**Tier Mapping:**
- 0-6 pts: 🟢 Simple (15-25 msgs, 30-45 min)
- 7-13 pts: 🟡 Medium (30-50 msgs, 1-2 hrs)
- 14-20 pts: 🔴 High (50-100 msgs, 2-4 hrs)
- >20 pts: ⚫ Complex (break into sub-issues)

**Original Estimate:** [tier]
**Revised Estimate:** [tier] (confidence: High/Med/Low)
**Rationale:** [explain if changed]
```

---

## Phase 3: Architecture Decision Check (2 min)

**Does this require an ADR?**
- [ ] Introduces new architectural pattern
- [ ] Makes irreversible technology choice
- [ ] Impacts security/performance significantly
- [ ] Changes data models or API contracts

**If yes:**
```markdown
**ADR Needed:** Yes
**Title:** [Decision being made]
**Key Trade-offs:** [List]

**Recommend:** Create ADR before implementation
```

---

## Phase 4: Update GitHub Issue (5 min)

### A. Prepare Enrichment Comment

```markdown
## 🔬 Codebase Research Findings

### Related Components
[findings from Phase 2.A]

### External Insights (if applicable)
[findings from Phase 2.B]

### Patterns to Follow
[findings from Phase 2.C]

### Files & Effort
[findings from Phase 2.D]

### Blockers & Dependencies
[findings from Phase 2.E]

**Decision:** ✅ Proceed / ⏸️ Wait / 🔄 Pivot
**Rationale:** [explain]

### Complexity Validation
[findings from Phase 2.F]

### Architecture Decision
[findings from Phase 3]

---

**Enriched by:** Claude Code `/enrich-issue`
**Ready for implementation:** [Yes/No]
**Recommended next step:** [action]
```

### B. Post Comment & Update Labels

```bash
# Save enrichment to temp file
cat > /tmp/enrichment-$ARGUMENTS.md <<'EOF'
[Paste enrichment comment above]
EOF

# Post comment to issue
gh issue comment $ARGUMENTS --body-file /tmp/enrichment-$ARGUMENTS.md

# Add enriched label
gh issue edit $ARGUMENTS --add-label "enriched"

# Update complexity label (remove old, add new)
gh issue edit $ARGUMENTS --remove-label "complexity: unknown"
gh issue edit $ARGUMENTS --add-label "complexity: [tier]"

# Add blocker label if applicable
[If blockers found:] gh issue edit $ARGUMENTS --add-label "blocked"

# Clean up temp file
rm /tmp/enrichment-$ARGUMENTS.md
```

---

## Phase 5: Summary & Recommendation (2 min)

**Provide summary to user:**

```
✅ Research complete for issue #$ARGUMENTS

**Key Findings:**
- Related components: [count] found
- Patterns to reuse: [Y/N] - [which]
- Files to modify: [count] core + [count] new
- Blockers: [None / List with severity]
- External insights: [key learnings if any]

**Complexity:** [Original] → [Revised] ([confidence])
**Reasoning:** [why complexity changed or stayed same]

**Decision: [✅ Proceed / ⏸️ Wait / 🔄 Pivot]**
**Rationale:** [explain recommendation]

**Next Steps:**
1. [If ✅] Review enrichment comment in issue #$ARGUMENTS
2. [If ✅] When ready: /implement-feature $ARGUMENTS
3. [If ⏸️] Resolve blocker: [which] then re-enrich
4. [If 🔄] Discuss alternative approach with user
5. [If ADR] Create architecture decision record first
```

---

## Success Example

**Issue #70: Add wizard onboarding button**

```markdown
## 🔬 Codebase Research Findings

### Related Components
- `SimpleAppWithUnifiedSearch.tsx:450` - Tags button (similar positioning)
- `ConfirmationModal.tsx` - Modal pattern (80% reusable)

### Patterns to Follow
**Component:** SettingsButton.tsx (oval, fixed position)
**State:** Local useState (no Jotai needed)
**Styling:** --glow-animation exists, can reuse
**Storage:** chrome.storage.local for completion flag

### Files & Effort
**Core:** 1 file (+5 lines)
**New:** 7 files (~500 lines total)
**Tests:** 3 files
**Total:** 8 files, 505 lines

### Blockers & Dependencies
✅ All prerequisites verified (tags exist, modal pattern exists)
⚠️ Minor: z-index adjustment may be needed
**Decision:** ✅ Proceed (minor issue, easy fix)

### Complexity Validation
- Files: 8 × 1 = 8 pts
- New patterns: 0 × 3 = 0 pts
- Integration: 1 × 2 = 2 pts
- Testing: moderate = 2 pts
**Total:** 12/20 → 🟡 Medium (CONFIRMED)

### Architecture Decision
No ADR needed (follows existing patterns)

---

**Enriched by:** Claude Code
**Ready:** ✅ Yes
**Next:** /implement-feature 70
```

---

## Failure Example (Blocker Found)

**Issue #85: Add real-time collaboration**

```markdown
## 🔬 Codebase Research Findings

### Related Components
❌ No WebSocket infrastructure found
❌ No presence tracking system
⚠️ Current sync is REST-based, not real-time

### External Insights
- Best practice: Operational Transform or CRDT for conflict resolution
- Performance: WebSocket connections consume 50-100KB RAM each
- Security: Need auth token validation on every message

### Blockers & Dependencies

| Blocker | Severity | Resolution | ETA |
|---------|----------|------------|-----|
| Missing WebSocket server | HIGH | Build infrastructure | 3-5 days |
| No conflict resolution algo | HIGH | Choose CRDT vs OT | 1 day research |
| Auth not WebSocket-aware | MED | Add token validation | 1 day |

**Decision:** ⏸️ **WAIT** - Multiple high-severity blockers

### Complexity Validation
- Files: 15+ × 1 = 15 pts
- New patterns: 3 × 3 = 9 pts
- Integration: 5+ × 2 = 10 pts
**Total:** 34/20 → ⚫ **COMPLEX** (Exceeds scale!)

**Recommendation:** Break into 3 sub-issues:
1. #86: Build WebSocket infrastructure
2. #87: Implement conflict resolution
3. #88: Add real-time UI updates

### Architecture Decision
**ADR Required:** Yes - "Real-time Architecture Choice"
**Key Decision:** CRDT vs Operational Transform
**Must decide before implementation**

---

**Enriched by:** Claude Code
**Ready:** ❌ No (blockers + needs decomposition)
**Next:** Resolve architecture decisions, create sub-issues
```

---

## Quality Checklist

Before completing:
- [ ] Issue loaded and understood
- [ ] Related components documented with file:line
- [ ] Existing patterns identified (or "none found")
- [ ] Files to modify listed with line estimates
- [ ] Blockers checked with decision matrix
- [ ] Complexity validated with multi-factor scoring
- [ ] ADR need assessed
- [ ] Enrichment comment posted to GitHub issue
- [ ] Labels updated (enriched, complexity, blocked if needed)
- [ ] Clear recommendation provided (Proceed/Wait/Pivot)

**If ANY checkbox unchecked:** Continue research.

---

## Critical Rules

**DO:**
- ✅ Post findings to GitHub (not just local summary)
- ✅ Use multi-factor complexity scoring
- ✅ Check for blockers with decision matrix
- ✅ Research external best practices for complex features
- ✅ Prompt for ADR when architectural decisions needed
- ✅ Provide both success and failure examples
- ✅ Give clear Proceed/Wait/Pivot recommendation

**DON'T:**
- ❌ Start implementation (research only)
- ❌ Skip blocker analysis (causes problems later)
- ❌ Ignore external research for complex features
- ❌ Provide vague estimates ("a few files")
- ❌ Assume patterns without verifying in code
- ❌ Skip GitHub issue update (defeats purpose)
