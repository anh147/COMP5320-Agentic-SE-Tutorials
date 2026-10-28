# SoopiFood Definition of Done

A story is **Done** only when **every** item is ticked **with evidence**.
"The author says so" is not evidence. Items D1–D8 follow the textbook's example DoD (section 2.9);
D9 is specific to SoopiFood; D10–D11 exist because our code is written with AI agents.

| ID | Item | What counts as evidence |
|---|---|---|
| D1 | All acceptance criteria pass | CI log shows every scenario of the story's `.feature` passing |
| D2 | Unit tests written and passing, at least 80% coverage of changed code | CI log: tests pass and coverage ≥ 80% |
| D3 | Integration tests written and passing | CI log |
| D4 | Code reviewed by at least one **other team member** | An approving review from a person who is not the author |
| D5 | Linter and type checker pass with no errors | CI log for both |
| D6 | API documentation updated (if the API changed) | Docs file in the changed files |
| D7 | No new security vulnerabilities (automated scan) | Security scan in CI log with no new findings |
| D8 | Deployed to staging and manually tested | Staging deploy link and a note of what was tested |
| D9 | Money is stored and calculated as integer VND (no floating point) | The diff |
| D10 | Every AI-generated change was read and understood by a human | A human reviewer confirms it in the review |
| D11 | AI usage recorded in `verification/AI_USAGE_LOG.md` | The log file in the changed files |

Acceptance criteria (D1) belong to **one story**. This Definition of Done applies to **every story**.
