# Tutorial: Requirements Engineering with AI agents (SoopiFood)

**Chapter:** 2 · **Led by:** Group TODO · **Duration:** 60 min · **Format:** in teams
**Tools:** your AI coding agent (any agent that can read and write files in this repository)

## Learning objectives

By the end of this tutorial you will be able to:

1. TODO (sections 2.1–2.5)
2. Use an agent to prioritise a backlog with MoSCoW, and see how the result changes when you give it the stakeholders' context (2.6)
3. Use an agent to handle a change request as an explicit trade-off rather than scope creep (2.7)
4. Use one agent to write Gherkin acceptance criteria and a second agent to review them against the business rules (2.8)
5. Use an agent to audit a "done" claim against a Definition of Done, and check that every tick is backed by evidence (2.9)

## Before you start

- [ ] Clone this repository and open it with your agent
- [ ] TODO (anything for sections 2.1–2.5)

**The app:** SoopiFood, a food ordering and delivery app. Starter files are in [`starter/`](starter/README.md);
copy-paste prompts are in [`starter/prompts/`](starter/prompts/). Agents write to `tutorial/workspace/`.

**How every part works:** you go round the loop at least twice.

```
Round 1 (agent) → Review (you, or a second agent) → Iterate: Round 2 with more context (agent) → Review (you)
```

In every review, ask the same question: **what did the agent not know?** The fix is usually more context, not a longer instruction.

## Plan

| Part | Time (min) | Activity | Chapter section |
|---|---|---|---|
| TODO | TODO | TODO | 2.1–2.5 |
| A. Prioritise | 7 | Round 1 on the backlog only → review against the stakeholder notes → round 2 with the notes | 2.6 |
| B. New changes | 5 | Two change requests → review the trade-off → iterate on a stakeholder push-back | 2.7 |
| C. Acceptance criteria | 12 | Writer → reviewer (new session) → writer with the rules → final check | 2.8 |
| D. Definition of Done | 6 | Audit a pull request → review the evidence → iterate | 2.9 |
| **Total** | **60** | | |

## Part A: Prioritise with MoSCoW (2.6) — 7 min

**Task:** Prioritise SoopiFood Release 1: 15 stories in [`backlog.yaml`](starter/backlog.yaml), capacity 50 points, about 60/20/20.

1. **Round 1** *(2 min)*. The agent gets the backlog only.
   Prompt: [`1a_prioritise_round1.md`](starter/prompts/1a_prioritise_round1.md) → `workspace/moscow_round1.md`
2. **Review** *(3 min)*. Read [`stakeholder_notes.md`](starter/stakeholder_notes.md) yourself (the agent has not seen it). Then check the agent's plan:
   - Add up the points. Does the self-check match your numbers?
   - Where did it put promo codes (SF-06), cash on delivery (SF-13) and reviews (SF-10)? Would the stakeholders agree?
   - For each wrong call: was the agent wrong, or did it just not know?
3. **Iterate: round 2** *(2 min)*. Give the agent the stakeholder notes.
   Prompt: [`1b_prioritise_round2.md`](starter/prompts/1b_prioritise_round2.md) → `workspace/moscow.md`. Read its "Changes from round 1". Is every change explained by a note?

## Part B: Handle new changes without scope creep (2.7) — 5 min

**Task:** Two requests arrive after the plan is agreed ([`change_requests.yaml`](starter/change_requests.yaml)): allergen information (Legal, 2 points) and "split the bill" (Marketing, 8 points). The capacity does not change.

1. **Round 1** *(2 min)*. Prompt: [`1c_change_requests.md`](starter/prompts/1c_change_requests.md) → `workspace/scope_changes.md`
2. **Review** *(1 min)*.
   - Is every added point paid for by a demotion? Re-add the points.
   - If the agent said yes to a request without removing anything, the plan is over capacity: that is scope creep.
3. **Iterate** *(2 min)*. Marketing pushes back on CR-02.
   Prompt: [`1d_iterate_pushback.md`](starter/prompts/1d_iterate_pushback.md). Does the agent show what each option costs, or does it give in?

## Part C: Write and verify acceptance criteria (2.8) — 12 min

**Task:** Acceptance criteria for *SF-06: as a customer, I want to apply a promo code at checkout so that I pay less*.

1. **Round 1: writer** *(3 min)*. The user story only, no business rules.
   Prompt: [`2a_writer.md`](starter/prompts/2a_writer.md) → `workspace/discount.feature`
   It will look complete: valid Gherkin, concrete numbers, happy/error/edge tags.
2. **Review: a second agent** *(3 min)*. Open a **new agent session**. It gets the feature file and [`business_rules.md`](starter/business_rules.md), and reports contradictions, untested boundaries and invented rules.
   Prompt: [`2b_reviewer.md`](starter/prompts/2b_reviewer.md) → `workspace/review.md`
   If your writer happened to get everything right, review [`fallback/discount_v1.feature`](starter/fallback/discount_v1.feature) instead.
3. **Iterate: round 2, writer** *(3 min)*. Back in the writer's session, give it the review and the rules.
   Prompt: [`2c_rewrite.md`](starter/prompts/2c_rewrite.md) → `workspace/discount_v2.feature`
4. **Review: you** *(3 min)*. Pick two findings from `review.md` and check them yourself against `business_rules.md`; the reviewer is an agent too. Then check that every rule R1–R7 has a scenario in `discount_v2.feature`. Optionally, run the reviewer prompt again on v2.

**Takeaway:** round 1 failed because the writer had no business context, and it cost you a review and a rewrite to find out. On a real project, design the context up front: [`2d_writer_with_context.md`](starter/prompts/2d_writer_with_context.md) gives the writer the rules, the error codes and the coverage you expect in the first prompt.

## Part D: Check the Definition of Done (2.9) — 6 min

**Task:** Pull request [`pr_sf06.md`](starter/pr_sf06.md) says story SF-06 is "ready to merge, story is done 🎉". Is it?

**How an audit works:** (1) collect the evidence: CI log, diff, changed files, reviewers, not the description; (2) go item by item: ✅ / ❌ / ❓ with the exact line quoted; (3) put every claim in the PR next to what the evidence says; (4) give a verdict and the list of what must happen before Done.

1. **Round 1** *(2 min)*. The agent audits the PR against [`DEFINITION_OF_DONE.md`](starter/DEFINITION_OF_DONE.md), item by item, quoting evidence.
   Prompt: [`3a_dod_audit.md`](starter/prompts/3a_dod_audit.md) → `workspace/dod_audit.md`
2. **Review** *(2 min)*. For two ticks or crosses, find the quoted line in the PR yourself. Watch for:
   - ticks taken from the author's **claims** ("All acceptance tests pass ✅") instead of the **CI log**;
   - "reviewed by Copilot" counted as review by another team member;
   - "SKIPPED" read as "passed";
   - problems visible only in the diff.
3. **Iterate** *(2 min)*. Challenge a judgement call (D3) and turn the verdict into tasks.
   Prompt: [`3b_iterate_audit.md`](starter/prompts/3b_iterate_audit.md)

Acceptance criteria belong to one story; the Definition of Done applies to every story.
