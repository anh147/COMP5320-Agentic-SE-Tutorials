# Run the tutorial from start to finish

Chapter 2, Requirements Engineering with AI agents (SoopiFood). The tutorial is one sequence of 16 numbered prompts, grouped into Parts A–I. The handout with the learning objectives and review questions is [`TUTORIAL.md`](TUTORIAL.md).

## Setup

1. Clone the repository and open it with your AI coding agent. The agent must be able to read and write files.
2. Work from the repository root. Agents write to `tutorial/workspace/` (git-ignored; only `.gitkeep` is tracked).
3. Open a new agent session for each part (A–I). Part H (steps 11–13) needs **two** sessions: a writer and a reviewer.

## Layout

```
tutorial/
├── TUTORIAL.md          handout: objectives, plan, review questions
├── README.md            this file
├── starter/
│   ├── prompts/         01 … 16: copy-paste prompts, in order
│   └── backlog.yaml, stakeholder_notes.md, change_requests.yaml,
│       business_rules.md, DEFINITION_OF_DONE.md, pr_sf06.md   input files
├── solutions/           sample outputs, same numbering as the prompts
└── workspace/           your agent's output goes here
```

## Steps

Each step: paste the prompt (or tell the agent to read it), check the output in `workspace/`, then compare with `solutions/` **only after** you have reviewed it yourself.

### Parts A–E: Elicit and specify

These parts must be run in order, and each needs the output of the one before: **B needs A's interview guide** (use it to run the interviews and write notes I1–I8, O1–O2), **C needs B's persona** (write its user stories and walkthrough notes W1–W4), **D needs C's FRs**, and **E needs B, C and D**. Paste the inputs where the prompt says `[Paste … here]`.

| # | Part | Prompt in `starter/prompts/` | Input you provide | Compare with `solutions/` |
|---|---|---|---|---|
| 1 | A | `01_interview_guide.md` | none | `01_interview_guide.md` |
| 2 | A | `02_interview_guide_iterate.md` (in the same session) | the guide from step 1 | `02_interview_guide_iterate.md` |
| 3 | B | `03_personas.md` | interview and observation notes (I1–I8, O1–O2), from running the interviews with the guide from step 2 | `03_personas.md` |
| 4 | C | `04_functional_requirements.md` | the persona from step 3 → its user stories, plus walkthrough notes (W1–W4) | `04_functional_requirements.md` |
| 5 | D | `05_non_functional_requirements.md` | the FRs from step 4 | `05_non_functional_requirements.md` |
| 6 | E | `06_epics_stories.md` | persona, FRs, NFRs from steps 3–5 | `06_epics_stories.md` |

### Parts F–I: Plan, specify, verify

All inputs are in `starter/`. Output file names below are the ones the prompts tell the agent to write in `workspace/`.

| # | Part | Prompt | Agent output (`workspace/`) | Compare with `solutions/` |
|---|---|---|---|---|
| 7 | F | `07_moscow_round1.md`: backlog only | `moscow_round1.md` | `07_moscow_round1.md` |
| 8 | F | `08_moscow_round2.md`: add `stakeholder_notes.md` | `moscow.md` | `08_moscow_round2.md` |
| 9 | G | `09_change_requests.md` | `scope_changes.md` | `09_scope_changes.md` |
| 10 | G | `10_change_pushback.md` (appends to the file above) | `scope_changes.md` | — |
| 11 | H | `11_criteria_writer.md`: writer, no business rules | `discount.feature` | `11_discount_v1.feature` |
| 12 | H | `12_criteria_reviewer.md`: **new session** | `review.md` | `12_review.md` |
| 13 | H | `13_criteria_rewrite.md`: back in the writer's session | `discount_v2.feature` | `13_discount_v2.feature` |
| 14 | H | `14_criteria_writer_with_context.md`: what you should have done up front (optional) | — | — |
| 15 | I | `15_dod_audit.md` | `dod_audit.md` | `15_dod_audit.md` |
| 16 | I | `16_dod_audit_iterate.md` (appends to the file above) | `dod_audit.md` | — |

## Review after every step

Use the loop from the handout: **Round 1 → Review → Iterate with more context → Review**. Always ask: *what did the agent not know?* Details and the checks for each part are in [`TUTORIAL.md`](TUTORIAL.md).

## Notes

- Agent output differs from run to run, so the files in `solutions/` are samples, not expected answers.
- Do not edit `solutions/`; copy your own outputs from `workspace/` into your team's submission.
- Nothing in this folder is committed automatically.
