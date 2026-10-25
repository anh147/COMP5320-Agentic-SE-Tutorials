<!-- (Use this on your own projects: it gives the writer the business context from the start,
so you do not spend a round finding out what it guessed.) -->

Write Gherkin acceptance criteria for this SoopiFood user story:

  SF-06: As a customer, I want to apply a promo code at checkout so that I pay less.

Context (read these files):
- tutorial/starter/business_rules.md: the product owner's rules R1-R7. They are the only
  source of truth. Do not add rules that are not there.
- Error codes the system returns: UNKNOWN_CODE, EXPIRED, MIN_ORDER_NOT_MET, ONE_PROMO_PER_ORDER.
  Use these codes, not your own message texts.
- Test data is yours to choose (promo codes, dates, the delivery fee), but say in a comment
  that it is test data, not a rule.

Output format (tutorial/workspace/discount.feature):
- Every rule R1-R7 has at least one scenario, including its boundary
  (exactly the minimum, the last valid day, an equal discount).
- Tag every scenario with exactly one of @happy, @error, @edge.
- Put a comment above each scenario naming the rule(s) it checks, e.g. `# R3`.
- If something is not covered by the rules, list it as an open question at the top of the
  file instead of inventing an answer.
