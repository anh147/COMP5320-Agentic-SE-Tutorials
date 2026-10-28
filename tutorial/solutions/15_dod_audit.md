# DoD audit: SF-06 (PR #42)

Sources: `DEFINITION_OF_DONE.md` and `pr_sf06.md` (PR description, changed files, diff excerpt, CI log run #318).
Claims in the PR description are not used as evidence. They are quoted only to show where they conflict with the CI log.

## Audit table

| ID | Item | Status | Evidence |
|----|------|--------|----------|
| D1 | All acceptance criteria pass | ❌ not met | CI log: `13 scenarios (12 passed, 1 failed)` and `FAILED: Code still valid on its valid-until date` / `expected: promo accepted` / `got:      rejected with reason EXPIRED`. The PR description says "All acceptance tests pass ✅", which the CI log contradicts. |
| D2 | Unit tests passing, at least 80% coverage of changed code | ❌ not met | CI log: `[unit] pytest tests/ ... 9 passed` but `[coverage] src/soopifood/promo.py ......... 72%`. 72% is below 80%. `promo.py` is a new file (`+96`), so all of it counts as changed code. |
| D3 | Integration tests written and passing | ❓ cannot tell | CI log: `[integration] pytest tests/integration ... 4 passed`. They pass, but the changed files contain no integration test (only `tests/test_promo.py`), so it cannot be shown that any of the 4 tests exercise the new `POST /cart/promo` endpoint. "Written" is not shown. |
| D4 | Reviewed by at least one other team member | ❌ not met | PR header: `**Reviewers:** none requested`. The description says "Self-reviewed, and reviewed by Copilot: no issues found". A self-review and an AI tool are not "an approving review from a person who is not the author". |
| D5 | Linter and type checker pass with no errors | ❌ not met | CI log: `[lint] ruff check src tests ... passed` but `[typecheck] mypy src ... SKIPPED (job disabled in ci.yml)`. Both must pass, and the type checker did not run. |
| D6 | API documentation updated (if the API changed) | ❌ not met | The API changed: `src/soopifood/api/cart.py +31 (new endpoint POST /cart/promo)`. The changed files list contains no docs file (`promo.py`, `cart.py`, `test_promo.py`, `discount.feature`). |
| D7 | No new security vulnerabilities (automated scan) | ❌ not met | CI log: `Issue: [B101:assert_used] Use of assert detected.` / `Severity: Low` / `Location: src/soopifood/promo.py:12`. It is in a file added by this PR, so it is a new finding. Severity is low, but the item says no new findings. |
| D8 | Deployed to staging and manually tested | ❌ not met | CI log: `[deploy] staging ... not run (manual trigger)`. The PR says "Will deploy to staging after merge". There is no staging link and no test note. |
| D9 | Money stored and calculated as integer VND (no floating point) | ❌ not met | Diff: `raw = cart.food_subtotal * promo.value / 100`. In Python, `/` is float division, so `raw` is a float, and `raw // 1000` is a float operation before `int(...)`. The result is converted back to an int, but the calculation uses floating point. Integer division (`//`) with a multiply first would avoid it. |
| D10 | Every AI-generated change was read and understood by a human | ❌ not met | No human reviewer confirmed it in a review (see D4). The PR says "Code generated with Claude Code, then cleaned up by me", which is the author's claim, and "reviewed by Copilot", which is not a human. |
| D11 | AI usage recorded in `verification/AI_USAGE_LOG.md` | ❌ not met | The PR states AI use ("Code generated with Claude Code"), but the changed files list does not include `verification/AI_USAGE_LOG.md`. |

Totals: 0 met, 10 not met, 1 cannot tell.

## Verdict

**SF-06 is not Done.** The DoD needs every item met with evidence, and none of the 11 items is. The `ready-to-merge` label and "story is done 🎉" in the PR description are not supported by the CI log.

The most serious problems are:
- D1: one acceptance scenario fails. It is the valid-until-date boundary (rule R5: a code is valid up to and including its date), so a code is rejected on its last valid day.
- D9: money is calculated with floating point.
- D4 and D10: nobody other than the author has reviewed AI-generated code.

## What must happen before it is Done

1. **D1:** fix the expiry check so a code is accepted on its valid-until date, then re-run `behave` and show 13 of 13 passing in CI.
2. **D9:** replace the float division in `discount_for` with integer arithmetic, e.g. `cart.food_subtotal * promo.value // 100`, and show it in the diff.
3. **D2:** add unit tests until `promo.py` coverage is at least 80% (it is 72%) and show the new CI log.
4. **D3:** show integration tests that cover `POST /cart/promo` (add one if none does) and show them passing in CI.
5. **D5:** re-enable the `mypy` job in `ci.yml` and show it passing.
6. **D7:** remove the `assert` in `promo.py` (replace it with real validation, which also still runs under `python -O`), or document it as a decision, and show a clean `bandit` run.
7. **D6:** add the `POST /cart/promo` documentation to the API docs.
8. **D8:** deploy to staging, test manually, and record the link and what was tested.
9. **D4 and D10:** request a review from another team member, who confirms in the review that they read and understood the AI-generated code.
10. **D11:** add the AI usage entry to `verification/AI_USAGE_LOG.md`. The repository rules say humans write files in `verification/`, so a human should add it.

Then re-run the audit on the new CI run and the new review.

---

# Follow-up 1: how to read D3

First, a correction: the table above marks D3 as **❓ cannot tell**, not ❌. The reasoning below shows why it could become ❌ under one of the two readings.

D3 says: *"Integration tests written and passing"*. Evidence: *"CI log"*.

## Reading A (the team's): "the integration suite passes"

For:
- The evidence column is only "CI log", and a CI log can show whether tests pass. It cannot show who wrote them or when.
- Integration tests protect against breaking other parts of the system, so a green suite is useful even if this story added nothing to it.
- It is simple to check: one line in the CI log.

Against:
- It ignores the word "written". If "written" meant nothing, D3 would just say "Integration tests passing".
- A story could add a new endpoint, write no integration test and still meet D3, because the old tests stay green. That is the case in PR #42.

Under this reading D3 is **✅ met**: `[integration] pytest tests/integration ... 4 passed`.

## Reading B (mine): "integration tests for this story are written, and they pass"

For:
- The word "written" is a verb about new work, and D3 sits next to D2, which is explicitly about this story's work ("at least 80% coverage of changed code"). The sibling item that is about the whole suite would say so.
- The Definition of Done applies to a story, and each item is a check on that story's change. The opening line says a story is Done only when every item is ticked with evidence.
- The endpoint `POST /cart/promo` is new. No test that existed before this PR can call an endpoint that did not exist, so none of the 4 passing tests can have been testing it. The changed files list shows no integration test file. So under this reading, D3 is **❌ not met**, not just ❓.

Against:
- D3 does not say "for this story" or "for the changed code", unlike D2, so the story-scoped reading has to be inferred.
- The evidence column ("CI log") cannot show that a test was written. A reviewer has to look at the diff, which the column does not mention.
- "Integration tests written" could mean "the team has written integration tests at some point".

## Which one the wording supports

**Reading B**, narrowly. "Written and passing" has two conditions, and reading A drops the first one. D3 copies the structure of D2 ("Unit tests written and passing"), which is plainly about this story's tests, so the same words in D3 most naturally have the same scope.

But the wording does not make it certain: there is no "for this story", and the evidence column checks only "passing". That gap is why the team could reasonably read it as A, so the fix is to reword D3, not to argue about it.

## Suggested rewording

| | Text |
|---|---|
| **Item** | Integration tests cover this story's new or changed endpoints and external interactions, and the whole integration suite passes. |
| **What counts as evidence** | The changed files include an integration test that calls each new or changed endpoint, and the CI log shows the whole integration suite passing. |

If the team really wants reading A, say so in the item ("the integration suite passes; no new tests required"). Then D3 would be ✅ for PR #42, and the gap should be closed another way, for example by making D1 cover the endpoint.

---

# Follow-up 2: tasks for the author, ordered by risk

Ordered by what the problem can do to customers or money first, then by effort. Tasks 1 to 6 change the code, so they come before the human review (task 9) and the staging test (task 8), which must look at the final code. "Closes" is the DoD item whose evidence the task produces.

| # | Task for the author (minh-dev) | Closes | Risk it removes | Needs |
|---|--------------------------------|--------|-----------------|-------|
| 0 | Remove the `ready-to-merge` label until the other tasks are done. | none | Someone merges a PR that fails 10 of 11 DoD items. | |
| 1 | Fix the expiry check so a code is accepted on its valid-until date (R5). Re-run `behave` and show 13 of 13 scenarios passing. | D1 | Customers with a valid code on its last day are rejected with `EXPIRED`. It also fails an acceptance test. | |
| 2 | Replace `cart.food_subtotal * promo.value / 100` with integer arithmetic (e.g. `cart.food_subtotal * promo.value // 100`, then round down to 1,000). Add a test for 123,456 giving 24,000. | D9 | Float rounding can make a discount wrong by one step, and floats must not be used for money. | |
| 3 | Remove the `assert promo.value > 0` in `discount_for` and replace it with explicit validation that raises an error (or rejects the promo), so the check still runs under `python -O`. Re-run `bandit` clean. | D7 | The check disappears in optimised mode, so a zero or negative promo value could produce a wrong discount. | |
| 4 | Add unit tests until `promo.py` coverage is at least 80% (now 72%). Cover cap, flat limit, rounding, the boundaries from tasks 1 to 3 and the replace branch. | D2 | Untested branches of money logic. | 1, 2, 3 |
| 5 | Write an integration test that calls `POST /cart/promo` (apply, replace, reject) and shows it passing. | D3 (under the reworded item) | The new endpoint has no integration test. Under the team's reading D3 is already met, and this task is still needed for the reworded item. | |
| 6 | Re-enable the `mypy` job in `ci.yml`, fix any errors and show it passing. | D5 | The type checker has not run, so type errors are unseen. | 1, 2, 3 |
| 7 | Add the `POST /cart/promo` request and response, including the `EXPIRED`, `MIN_ORDER_NOT_MET`, `UNKNOWN_CODE` and `ONE_PROMO_PER_ORDER` codes, to the API docs. | D6 | Clients cannot use the endpoint correctly. | |
| 8 | Deploy to staging, test by hand (apply, replace, expiry date, minimum, cap) and record the link and what was tested. | D8 | Real-environment problems appear only after merge. | 1 to 7 |
| 9 | Ask another team member to review the final PR. The reviewer reads the AI-generated code, and the approval says they did. | D4, D10 | Nobody but the author has read AI-generated money code. | 1 to 8 |
| 10 | Ask a human to add the AI usage entry for this PR to `verification/AI_USAGE_LOG.md` (the repo rules say humans write that folder). | D11 | The AI use is untraceable. | |

Every DoD item D1 to D11 is closed by at least one task. After task 10, re-run this audit on the new CI run and the review; the story is Done only when the audit shows every item met with evidence.
