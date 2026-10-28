# Tutorial: Requirements Engineering with AI agents (SoopiFood)

**Chapter:** 2 · **Led by:** Group 2 · **Format:** in teams
**Tools:** your AI coding agent (any agent that can read and write files in this repository)

## Learning objectives

By the end of this tutorial you will be able to:

1. Use an agent to draft an interview guide, personas, functional and non-functional requirements, and a backlog of epics and stories, and review each against its sources
2. Use an agent to prioritise a backlog with MoSCoW, and see how the result changes when you give it the stakeholders' context
3. Use an agent to handle a change request as an explicit trade-off rather than scope creep
4. Use one agent to write Gherkin acceptance criteria and a second agent to review them against the business rules
5. Use an agent to audit a "done" claim against a Definition of Done, and check that every tick is backed by evidence

## Before you start

- [ ] Clone this repository and open it with your agent
- [ ] Follow the setup and run order in [`README.md`](README.md)

**The app:** SoopiFood, a food ordering and delivery app. Starter files are in [`starter/`](starter/README.md);
copy-paste prompts are in [`starter/prompts/`](starter/prompts/). Agents write to `tutorial/workspace/`.

**Parts A–E build on each other:** B needs the output of A, C needs the output of B, D needs the output of C, and E needs the outputs of B, C and D. Keep your own outputs from `workspace/` and run the parts in order. Parts F–I use the ready-made files in `starter/`.

**How every part works:** you go round the loop at least twice.

```
Round 1 (agent) → Review (you, or a second agent) → Iterate: Round 2 with more context (agent) → Review (you)
```

In every review, ask the same question: **what did the agent not know?** The fix is usually more context, not a longer instruction.

## Plan

| Part | Activity |
|---|---|
| A. Interview guide | Draft a guide for a restaurant manager → review the questions for bias → rewrite neutrally |
| B. Personas | Synthesise interview notes into personas → check every bullet against its sources |
| C. Functional requirements | Write FRs for the restaurant tablet → check one behaviour per requirement and no invented values |
| D. Non-functional requirements | Write NFRs from the constraints → check metrics, thresholds and `[TBC]` |
| E. Backlog | Decompose requirements into epics, features and stories → check coverage |
| F. Prioritise | Round 1 on the backlog only → review against the stakeholder notes → round 2 with the notes |
| G. New changes | Two change requests → review the trade-off → iterate on a stakeholder push-back |
| H. Acceptance criteria | Writer → reviewer (new session) → writer with the rules → final check |
| I. Definition of Done | Audit a pull request → review the evidence → iterate |

## Part A: Create an interview guide

**Task:** Prepare a 45–60 minute interview with a restaurant manager for the SoopiFood delivery system, at the early discovery stage.

1. **Round 1.** Prompt: [`01_interview_guide.md`](starter/prompts/01_interview_guide.md). The agent drafts a semi-structured guide: 8–10 open questions with probes.
2. **Review.** Read every question as the manager would.
   - Does a question assume a negative experience or a feature (for example "juggle", "most frustrating")?
   - Are there yes/no questions? Do the sections follow the requested order?
3. **Iterate.** In the same session, give the agent your findings.
   Prompt: [`02_interview_guide_iterate.md`](starter/prompts/02_interview_guide_iterate.md). Does the rewrite let the manager describe a positive or a negative experience?

## Part B: Synthesise personas

**Task:** Turn interview notes (I1–I8) and observations (O1–O2) into 2–3 personas of restaurant managers.

**Needs from Part A:** the final interview guide (`workspace` output of step 2). Use it to run the interviews (or to simulate them with teammates or an agent playing the manager), then write the notes I1–I8 and O1–O2. Do not start Part B without them.

1. **Round 1.** Paste the interview and observation notes where the prompt says so.
   Prompt: [`03_personas.md`](starter/prompts/03_personas.md)
2. **Review.**
   - Does every bullet carry a source tag, and does the source really say that?
   - Are the goals end goals rather than tasks? Is each persona distinct from the others?
   - Did the agent add demographic details or behaviours that no note supports?
3. **Iterate.** Ask the agent to remove or mark every bullet you could not trace, then pick the persona you will use for the later parts.

## Part C: Write functional requirements

**Task:** Functional requirements for the restaurant tablet only, from user stories for your chosen persona and notes from prototype walkthroughs (W1–W4).

**Needs from Part B:** the persona you chose (output of Part B). Write the user stories for that persona, run the prototype walkthroughs, and note the results as W1–W4. Do not start Part C without the persona.

1. **Round 1.** Paste the persona's user stories and the walkthrough notes.
   Prompt: [`04_functional_requirements.md`](starter/prompts/04_functional_requirements.md)
2. **Review.**
   - Does each requirement have the form "The system shall …" and exactly one behaviour (no "and")?
   - Does it describe behaviour, not UI or technology?
   - Where a value is missing from the sources, is there a `[TBC]` rather than an invented number?
3. **Iterate.** Split any requirement that joins two behaviours, and list the `[TBC]` values as questions for stakeholders.

## Part D: Write non-functional requirements

**Needs from Part C:** the final functional requirements (FR-01 to FR-24 in the sample). Do not start Part D without them.

**Task:** Non-functional requirements for the tablet and the order service behind it, from the stakeholder constraints (peak load, shared Wi-Fi, glanceable screen, GDPR, third-party payments).

1. **Round 1.** Paste the functional requirements from Part C.
   Prompt: [`05_non_functional_requirements.md`](starter/prompts/05_non_functional_requirements.md)
2. **Review.**
   - Does every requirement have a metric and a threshold, and a way to test it?
   - Is every number either in the constraints or marked `[TBC]` with a question to ask?
   - Does each requirement link to FRs that exist?
3. **Iterate.** Take the `[TBC]` questions to a "stakeholder" (a teammate) and put the answers back into the requirements.

## Part E: Build the backlog

**Needs from Parts B, C and D:** the persona, the functional requirements and the non-functional requirements.

**Task:** Decompose the persona, FRs and NFRs into epics, features and user stories for a team of 5 developers in 2-week sprints.

1. **Round 1.** Paste the persona, FRs and NFRs.
   Prompt: [`06_epics_stories.md`](starter/prompts/06_epics_stories.md)
2. **Review.**
   - Is each story a vertical slice a manager could see working, with 2–4 Given/When/Then criteria?
   - Check the closing list: is every FR and NFR covered by a story, or listed as uncovered?
   - Did the agent assign story points although the prompt said not to?
3. **Iterate.** Ask the agent to cover the missing FRs/NFRs. Part F uses a ready-made SoopiFood backlog (`backlog.yaml`), so you can compare it with yours.

## Part F: Prioritise with MoSCoW

**Task:** Prioritise SoopiFood Release 1: 15 stories in [`backlog.yaml`](starter/backlog.yaml), capacity 50 points, about 60/20/20.

1. **Round 1**. The agent gets the backlog only.
   Prompt: [`07_moscow_round1.md`](starter/prompts/07_moscow_round1.md) → `workspace/moscow_round1.md`
2. **Review**. Read [`stakeholder_notes.md`](starter/stakeholder_notes.md) yourself (the agent has not seen it). Then check the agent's plan:
   - Add up the points. Does the self-check match your numbers?
   - Where did it put promo codes (SF-06), cash on delivery (SF-13) and reviews (SF-10)? Would the stakeholders agree?
   - For each wrong call: was the agent wrong, or did it just not know?
3. **Iterate: round 2**. Give the agent the stakeholder notes.
   Prompt: [`08_moscow_round2.md`](starter/prompts/08_moscow_round2.md) → `workspace/moscow.md`. Read its "Changes from round 1". Is every change explained by a note?

## Part G: Handle new changes without scope creep

**Task:** Two requests arrive after the plan is agreed ([`change_requests.yaml`](starter/change_requests.yaml)): allergen information (Legal, 2 points) and "split the bill" (Marketing, 8 points). The capacity does not change.

1. **Round 1**. Prompt: [`09_change_requests.md`](starter/prompts/09_change_requests.md) → `workspace/scope_changes.md`
2. **Review**.
   - Is every added point paid for by a demotion? Re-add the points.
   - If the agent said yes to a request without removing anything, the plan is over capacity: that is scope creep.
3. **Iterate**. Marketing pushes back on CR-02.
   Prompt: [`10_change_pushback.md`](starter/prompts/10_change_pushback.md). Does the agent show what each option costs, or does it give in?

## Part H: Write and verify acceptance criteria

**Task:** Acceptance criteria for *SF-06: as a customer, I want to apply a promo code at checkout so that I pay less*.

1. **Round 1: writer**. The user story only, no business rules.
   Prompt: [`11_criteria_writer.md`](starter/prompts/11_criteria_writer.md) → `workspace/discount.feature`
   It will look complete: valid Gherkin, concrete numbers, happy/error/edge tags.
2. **Review: a second agent**. Open a **new agent session**. It gets the feature file and [`business_rules.md`](starter/business_rules.md), and reports contradictions, untested boundaries and invented rules.
   Prompt: [`12_criteria_reviewer.md`](starter/prompts/12_criteria_reviewer.md) → `workspace/review.md`
3. **Iterate: round 2, writer**. Back in the writer's session, give it the review and the rules.
   Prompt: [`13_criteria_rewrite.md`](starter/prompts/13_criteria_rewrite.md) → `workspace/discount_v2.feature`
4. **Review: you**. Pick two findings from `review.md` and check them yourself against `business_rules.md`; the reviewer is an agent too. Then check that every rule R1–R7 has a scenario in `discount_v2.feature`. Optionally, run the reviewer prompt again on v2.

**Takeaway:** round 1 failed because the writer had no business context, and it cost you a review and a rewrite to find out. On a real project, design the context up front: [`14_criteria_writer_with_context.md`](starter/prompts/14_criteria_writer_with_context.md) gives the writer the rules, the error codes and the coverage you expect in the first prompt.

## Part I: Check the Definition of Done

**Task:** Pull request [`pr_sf06.md`](starter/pr_sf06.md) says story SF-06 is "ready to merge, story is done 🎉". Is it?

**How an audit works:** (1) collect the evidence: CI log, diff, changed files, reviewers, not the description; (2) go item by item: ✅ / ❌ / ❓ with the exact line quoted; (3) put every claim in the PR next to what the evidence says; (4) give a verdict and the list of what must happen before Done.

1. **Round 1**. The agent audits the PR against [`DEFINITION_OF_DONE.md`](starter/DEFINITION_OF_DONE.md), item by item, quoting evidence.
   Prompt: [`15_dod_audit.md`](starter/prompts/15_dod_audit.md) → `workspace/dod_audit.md`
2. **Review**. For two ticks or crosses, find the quoted line in the PR yourself. Watch for:
   - ticks taken from the author's **claims** ("All acceptance tests pass ✅") instead of the **CI log**;
   - "reviewed by Copilot" counted as review by another team member;
   - "SKIPPED" read as "passed";
   - problems visible only in the diff.
3. **Iterate**. Challenge a judgement call (D3) and turn the verdict into tasks.
   Prompt: [`16_dod_audit_iterate.md`](starter/prompts/16_dod_audit_iterate.md)

Acceptance criteria belong to one story; the Definition of Done applies to every story.
