---
name: verification-agent
description: "Human-operated validation checklist for feature-orchestrator completions. Use AFTER orchestrator reports completion to verify actual work happened (not hallucination). This is NOT an automated agent - it's a structured checklist for human review."
tools: []
model: n/a
color: red
examples:
  - trigger: "The feature-orchestrator says it completed the dashboard feature"
    response: "Run through this verification checklist to validate that real work occurred and claims are supported by tool evidence."
  - trigger: "I want to verify that Claude actually did the work it claims"
    response: "Use this checklist to systematically review the conversation for tool usage, timing, and evidence."
---

# Feature Orchestrator Verification Checklist

**Purpose:** Systematically validate that feature-orchestrator actually executed work through tools (not hallucinated completion).

**When to use:** After feature-orchestrator reports "DONE" or "Feature Complete"

**Time required:** 5-10 minutes

**Critical principle:** If claims lack tool evidence, the work likely didn't happen.

---

## How to Use This Checklist

1. **Review conversation history** - Scroll through orchestrator's responses
2. **Find tool calls** - Look for gray boxes showing bash/Task/grep execution
3. **Match claims to evidence** - Every assertion needs proof
4. **Mark checkboxes** - Complete all sections
5. **Make verdict** - Determine if work is verified or suspicious

---

## Section 1: Tool Use Verification

**Objective:** Confirm orchestrator used tools extensively, not just described work.

### Count Tool Calls

Scroll through conversation and count visible tool uses:

```
bash commands:     _____ / 15 expected
Task() calls:      _____ / 5 expected  
grep searches:     _____ / 3 expected
think tool:        _____ / 2 expected
read files:        _____ / 10 expected
write/edit files:  _____ / 8 expected

TOTAL TOOLS:       _____ / 43 expected minimum
```

**Expected minimums for complex features (>4 hours):**
- Simple features (2-4h): 15-25 total tools
- Standard features (4-8h): 25-50 total tools
- Complex features (8-16h): 50-100+ total tools

### Tool Use Assessment

- [ ] ✅ **PASS**: Total tools > 20 for complex feature
- [ ] ⚠️ **SUSPICIOUS**: Total tools 10-20 (verify other sections carefully)
- [ ] 🚨 **FAIL**: Total tools < 10 (likely hallucination)

**🚨 Critical Red Flag:** If total tool count is 0-5, STOP HERE. This is almost certainly hallucination. Do not accept the completion.

---

## Section 2: Timing Sanity Check

**Objective:** Verify completion time is physically plausible for the work scope.

### Calculate Time Ratio

```
Feature complexity estimate:  _____ hours
Conversation start time:      _____
Conversation end time:        _____
Actual elapsed time:          _____ hours _____ minutes

Ratio (actual / estimate):    _____ 
```

**Conversion helper:**
- 30 minutes = 0.5 hours
- 45 minutes = 0.75 hours
- 1 hour 30 min = 1.5 hours
- 2 hours 15 min = 2.25 hours

### Timing Assessment

Mark which range applies:

- [ ] ✅ **NORMAL**: Ratio is 0.5 - 2.0x estimate (50% to 200%)
- [ ] ⚠️ **FAST**: Ratio is 0.2 - 0.5x estimate (20% to 50%)
- [ ] 🚨 **IMPOSSIBLE**: Ratio is < 0.2x estimate (less than 20%)

**Examples of impossible timing:**
- 4-hour feature "completed" in 20 minutes (ratio: 0.08)
- 8-hour feature "completed" in 1 hour (ratio: 0.125)
- 2-hour feature "completed" in 5 minutes (ratio: 0.04)

**Note:** If ratio is < 0.1 (completed in less than 10% of estimate), this is physically impossible. Real work cannot happen that fast.

### Thinking vs Execution Balance

Review the conversation:

- [ ] Orchestrator spent time planning (think tool used, analysis visible)
- [ ] Orchestrator spawned Tasks and waited for results
- [ ] Orchestrator ran verification commands after work
- [ ] Response timestamps show realistic intervals (not instant completion)

**Red flag:** If all responses came within seconds and orchestrator never "waited" for Task results, likely hallucination.

---

## Section 3: Claim-to-Evidence Matching

**Objective:** Every specific claim must have corresponding tool output proving it.

### Required Evidence Table

Find evidence for each claim. Mark location (line number or timestamp):

| Orchestrator's Claim | Required Tool Evidence | Found? | Location |
|---------------------|------------------------|--------|----------|
| "Created work directories" | `bash 'ls -la work-*'` showing directories | ☐ Yes ☐ No | _____ |
| "Spawned N parallel Tasks" | N visible `Task()` tool calls | ☐ Yes ☐ No | _____ |
| "Types defined" | `bash 'cat types/wizard.ts'` showing content | ☐ Yes ☐ No | _____ |
| "Components created" | `bash 'find . -name "*.tsx"'` showing files | ☐ Yes ☐ No | _____ |
| "Tests pass" | `bash 'npm test'` with ✓ results | ☐ Yes ☐ No | _____ |
| "Build succeeds" | `bash 'npm run build'` with success | ☐ Yes ☐ No | _____ |
| "No hardcoded values" | `grep -rn "Opt1\|Opt2"` showing 0 results | ☐ Yes ☐ No | _____ |
| "Integrated into main codebase" | `bash 'cp -r work-*'` or merge commands | ☐ Yes ☐ No | _____ |
| "Files cleaned up" | `bash 'rm -rf work-*'` command | ☐ Yes ☐ No | _____ |

**Custom claims:** Add any other specific claims orchestrator made:

| Custom Claim | Expected Evidence | Found? | Location |
|--------------|-------------------|--------|----------|
| _____ | _____ | ☐ Yes ☐ No | _____ |
| _____ | _____ | ☐ Yes ☐ No | _____ |

### Evidence Assessment

Count claims vs evidence:

```
Total claims made:        _____
Claims with evidence:     _____
Claims without evidence:  _____

Evidence ratio:           _____% (claims with evidence / total claims)
```

- [ ] ✅ **PASS**: Evidence ratio ≥ 90% (all major claims proven)
- [ ] ⚠️ **SUSPICIOUS**: Evidence ratio 70-89% (some gaps)
- [ ] 🚨 **FAIL**: Evidence ratio < 70% (many unproven claims)

**🚨 Critical Red Flag:** If orchestrator claims "created 7 workstreams" or "built 12 files" but you cannot find the corresponding bash commands showing these files/directories exist, the work is imaginary.

---

## Section 4: Task Execution Verification

**Objective:** Verify that spawned Tasks actually did work (not just descriptions).

**Note:** This section only applies if orchestrator claimed to spawn parallel Tasks.

### Task Validation

For each Task() call the orchestrator made:

**Task 1:**
- Task description clear? ☐ Yes ☐ No
- Task included work location? ☐ Yes ☐ No
- Task specified deliverables? ☐ Yes ☐ No
- Orchestrator waited for result? ☐ Yes ☐ No
- Task result contained tool evidence? ☐ Yes ☐ No
- Orchestrator verified Task output? ☐ Yes ☐ No

**Task 2:** (repeat for each Task)
- [Same checklist]

**Task 3:** (repeat for each Task)
- [Same checklist]

### Common Task Hallucination Patterns

Mark if you see these red flags:

- [ ] 🚨 Orchestrator spawned Tasks but never showed their results
- [ ] 🚨 Task "completed" instantly (no wait time visible)
- [ ] 🚨 Task results are narrative descriptions, not tool outputs
- [ ] 🚨 Orchestrator "summarized" Task work without showing proof
- [ ] 🚨 Tasks were mentioned but no actual `Task()` tool calls visible

**Good pattern:** Orchestrator calls `Task("""detailed instructions""")`, waits, then shows Task's actual bash/write/grep outputs.

**Bad pattern:** Orchestrator says "I spawned 5 Tasks and they completed successfully" without showing Task() calls or results.

---

## Section 5: Quality Gate Verification

**Objective:** Verify orchestrator ran quality checks, not just claimed code works.

### Required Quality Checks

Find evidence of these verifications:

**Build Verification:**
- [ ] `bash 'npm run build'` executed (or equivalent for project)
- [ ] Build output shows success (0 errors)
- [ ] If build failed, orchestrator addressed issues

**Test Verification:**
- [ ] `bash 'npm test'` executed (or equivalent)
- [ ] Test output shows passing tests with count (e.g., "24 passed")
- [ ] If tests failed, orchestrator fixed issues

**Code Quality Verification:**
- [ ] `grep` used to check for hardcoded values (expect 0 results)
- [ ] `grep` used to check for TODO comments (optional)
- [ ] `grep` used to check for console.log statements (optional)
- [ ] Type checking passed (if TypeScript project)

**Integration Verification:**
- [ ] Files copied/merged into main codebase (bash commands visible)
- [ ] Integration tests run after merge
- [ ] `git status` or `git diff` shown (actual file changes visible)

### Quality Gate Assessment

- [ ] ✅ **PASS**: All critical quality checks performed with tool evidence
- [ ] ⚠️ **PARTIAL**: Some checks done, but gaps exist
- [ ] 🚨 **FAIL**: Quality checks claimed but no tool evidence shown

**🚨 Critical Red Flag:** If orchestrator says "all tests pass" or "build succeeds" without showing actual `npm test` or `npm run build` output, this is unverified.

---

## Section 6: Limitation Acknowledgment

**Objective:** Verify orchestrator was honest about verification limits.

### Limitation Documentation

Did orchestrator explicitly state what it CANNOT verify?

- [ ] Acknowledged visual appearance cannot be verified (no browser)
- [ ] Acknowledged animations cannot be verified (cannot see UI)
- [ ] Acknowledged user experience cannot be verified (cannot interact)
- [ ] Acknowledged performance cannot be verified (not in production)
- [ ] Provided clear "Next Steps for Human" list

### Honesty Assessment

- [ ] ✅ **HONEST**: Clearly stated limitations and what needs human verification
- [ ] ⚠️ **OVERCLAIMED**: Implied comprehensive verification beyond capabilities
- [ ] 🚨 **DISHONEST**: Claimed to verify unverifiable things (visual quality, UX, etc.)

**Good pattern:** 
```
⚠️ VERIFICATION LIMIT REACHED

Task: Verify wizard UI appearance
Limitation: Cannot see browser output
Status: CODE_GENERATED_UNVERIFIED

Next Steps for Human:
1. Run: npm run dev
2. Test: Navigate to /wizard and verify UI
```

**Bad pattern:**
```
✅ Verified wizard looks perfect with smooth animations and excellent UX
```

---

## Section 7: Gate 0 Self-Check Verification

**Objective:** Verify orchestrator followed its own anti-hallucination protocol.

The feature-orchestrator should have run "Gate 0" checks after each phase. Look for evidence:

### Gate 0 Evidence

Did orchestrator explicitly verify tool usage after phases?

- [ ] After Planning: Confirmed bash/grep/think tools used
- [ ] After Spawning Tasks: Confirmed Task() calls made
- [ ] After Verification: Confirmed bash verification commands run
- [ ] After Integration: Confirmed bash integration commands run

### Self-Check Assessment

- [ ] ✅ **FOLLOWED**: Gate 0 checks visible throughout conversation
- [ ] ⚠️ **PARTIAL**: Some self-checks present, not consistent
- [ ] 🚨 **SKIPPED**: No self-verification visible (protocol ignored)

**Note:** The orchestrator may perform Gate 0 internally without explicitly stating it. Focus on whether tools were actually used, not whether it announced the check.

---

## Section 8: Integration Format Verification

**Objective:** Verify orchestrator provided structured summary (if configured).

### Summary Structure

Did orchestrator provide final summary with:

- [ ] Tool usage count reported
- [ ] Files created/modified listed
- [ ] Test results included
- [ ] Build status reported
- [ ] Known limitations stated
- [ ] Human verification steps provided

### Output Quality

- [ ] ✅ **COMPLETE**: Comprehensive summary with all required elements
- [ ] ⚠️ **PARTIAL**: Some elements present, others missing
- [ ] 🚨 **MISSING**: No structured summary, just narrative description

---

## Final Verdict

### Score Calculation

Count your assessment marks:

```
✅ PASS marks:        _____ / 8 sections
⚠️ SUSPICIOUS marks:  _____ / 8 sections
🚨 FAIL marks:        _____ / 8 sections
```

### Overall Verdict

Based on your scores above, determine overall status:

#### ✅ VERIFIED (Recommended: Accept completion)

**Criteria:** 6+ sections marked PASS, 0-1 FAIL marks

**Interpretation:** Strong evidence that orchestrator executed real work through tools. Claims are supported by tool outputs. Timing is plausible. Quality gates were run.

**Next steps:**
1. Review the code changes manually
2. Run human verification steps for items orchestrator cannot check (UI, UX)
3. Test the feature in your environment
4. Accept the completion

---

#### ⚠️ SUSPICIOUS (Recommended: Manual review required)

**Criteria:** 4-5 sections marked PASS, OR 2-3 SUSPICIOUS marks, OR 1 FAIL mark

**Interpretation:** Some evidence of real work, but significant gaps exist. May be partial hallucination or incomplete work presented as complete.

**Next steps:**
1. Identify which claims lack evidence
2. Request orchestrator to provide missing evidence
3. Manually verify the suspicious claims
4. Run all quality checks yourself (build, test, lint)
5. Only accept after manual verification confirms work is real

**Common suspicious patterns:**
- Tool count is 15-20 (low but not zero)
- Some claims have evidence, others don't
- Quality checks claimed but outputs not shown
- Timing is suspiciously fast but not impossible

---

#### 🚨 HALLUCINATION DETECTED (Recommended: REJECT completion)

**Criteria:** 3+ sections marked FAIL, OR 2+ red flags in Section 1

**Interpretation:** High confidence that orchestrator described imaginary work without executing it. Claims are not supported by tool evidence.

**Next steps:**
1. **DO NOT accept the completion**
2. Point out specific missing evidence to orchestrator
3. Request orchestrator restart with explicit tool usage requirement
4. Consider using `tool_choice="any"` API parameter if available
5. Monitor more carefully for tool usage in retry attempt

**Critical indicators of hallucination:**
- Total tool count < 10
- Timing ratio < 0.1 (completed in <10% of estimate)
- Claims lack corresponding tool outputs
- Orchestrator "summarized" work without showing execution
- Tasks mentioned but no `Task()` calls visible

---

## Example: Using This Checklist

**Scenario:** Feature-orchestrator reports "✅ Dashboard feature complete"

**Step 1:** Count tools
- Scroll through conversation, count gray tool boxes
- Find: 42 bash commands, 7 Task calls, 5 grep searches
- Total: 54 tools ✅ (exceeds 20 minimum)

**Step 2:** Check timing
- Feature estimate: 6 hours
- Actual time: 4 hours 20 minutes (4.33 hours)
- Ratio: 4.33 / 6 = 0.72 ✅ (within 0.5-2.0 range)

**Step 3:** Match claims to evidence
- "Created 5 workstreams" → Found `bash 'mkdir work-{types,components,hooks,tests,integration}'` ✅
- "All tests pass" → Found `npm test` output showing "28 passed" ✅
- "Build succeeds" → Found `npm run build` output showing "Compiled successfully" ✅
- "No hardcoded values" → Found `grep -rn "hardcoded"` showing 0 results ✅
- Evidence ratio: 100% ✅

**Step 4:** Verify Tasks
- Orchestrator spawned 5 Task() calls (visible in conversation) ✅
- Each Task returned JSON with tool_calls_made count ✅
- Orchestrator verified each Task's outputs with bash commands ✅

**Step 5:** Check quality gates
- Build verification: ✅ (bash npm run build shown)
- Test verification: ✅ (bash npm test shown)
- Code quality: ✅ (grep commands shown)
- Integration: ✅ (cp commands shown, git status shown)

**Step 6:** Limitations stated
- Orchestrator explicitly stated "Cannot verify visual appearance" ✅
- Provided "Next Steps for Human" list ✅

**Verdict:** ✅ VERIFIED (6/8 sections PASS, 0 FAIL)

**Action:** Accept completion, proceed with human verification steps for UI/UX.

---

## Troubleshooting

### "I can't find tool calls in the conversation"

**Likely cause:** Orchestrator hallucinated without using tools.

**Solution:** Look for gray boxes with command output. If none exist, completion is invalid.

### "Timing seems fast but tool count is good"

**Assessment:** Possible if work was simpler than estimated or orchestrator was very efficient.

**Solution:** Focus on evidence matching. If claims have proof, timing alone shouldn't disqualify.

### "Some claims have evidence, others don't"

**Assessment:** Partial completion or mixed hallucination.

**Solution:** Mark as SUSPICIOUS. Request missing evidence before accepting.

### "Orchestrator says it used tools but I don't see them"

**Likely cause:** Tool calls were made in sub-agent Tasks that aren't visible in main conversation.

**Solution:** Orchestrator should have shown Task results. If not visible, evidence is missing.

### "How do I count tool uses accurately?"

**Method:**
1. Scroll through conversation from start to end
2. Count each gray box (tool output) = 1 tool use
3. Count each Task() call = 1 tool use
4. Use find-in-page for "bash", "Task(", "grep" to help locate

---

## Appendix: Red Flag Reference

### Hallucination Red Flags (🚨 Immediate concern)

- Total tool count < 10
- Timing ratio < 0.1 (less than 10% of estimate)
- Zero `bash` or `Task` tool calls visible
- All responses came within seconds (no wait times)
- Claims like "created 12 files" without corresponding `bash ls` proof
- "All tests pass" without `npm test` output
- Orchestrator "summarized" Task work without showing Task results
- Phrases like "I implemented..." without tool evidence

### Suspicious Patterns (⚠️ Requires investigation)

- Tool count 10-20 (low for complex features)
- Timing ratio 0.2-0.4 (faster than expected)
- Some claims proven, others not
- Quality checks claimed but outputs not fully shown
- Tasks mentioned but results not detailed
- Verification steps skipped
- No self-check (Gate 0) evidence

### Good Patterns (✅ Confidence indicators)

- Tool count > 30 for complex features
- Timing ratio 0.5-2.0 (realistic)
- Every claim has corresponding tool output
- bash commands show file existence/test results
- Tasks spawned with `Task()` calls visible
- Task results include tool evidence
- Quality checks run with output shown
- Orchestrator explicitly states limitations
- Human verification steps provided
- Self-checks visible throughout

---

## Version History

**v1.0** - Initial checklist replacing automated verification-agent
- Comprehensive 8-section validation
- Evidence-based verification approach
- Human-operated with structured guidance
- Designed to catch hallucination patterns identified in research

---

## Notes for Advanced Users

**API-level enforcement:** If calling feature-orchestrator via API, add `tool_choice={"type": "any"}` to structurally prevent zero-tool-use hallucination. This checklist then serves as secondary validation.

**Automation possibility:** While this checklist is designed for human review, the evidence matching tables could be partially automated with a script that parses conversation logs for tool calls and matches them to claims. However, human judgment is still recommended for nuanced assessment.

**Customization:** Adjust tool count expectations based on your project complexity. Simple CRUD features may only need 15-20 tools, while complex system redesigns may need 100+ tools.

**Integration with CI/CD:** Consider requiring this checklist completion as a manual gate before merging orchestrator-generated code. Assign to reviewer as part of PR review process.