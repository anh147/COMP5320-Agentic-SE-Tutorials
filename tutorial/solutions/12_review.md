# Review of discount.feature against business_rules.md (SF-06)

Scenarios are cited by their title. I recomputed every total with: total = food subtotal − discount + delivery fee (15,000 VND, from the Background). Only one scenario has wrong numbers (section 2); one more has a misleading title.

## 1. Traceability: rules R1-R7

| Rule | Scenario(s) that check it | Notes |
|---|---|---|
| R1 Minimum order | "A code is rejected when the subtotal is below the minimum" (99,000); "A subtotal exactly at the minimum qualifies" (100,000); "Removing items below the minimum removes the discount" | The 99,000 case has a subtotal + fee of 114,000, so it also shows the delivery fee does not count towards the minimum. |
| R2 What is discounted | **Delivery part:** every scenario whose total adds 15,000 after the discount, e.g. "A valid code reduces the total". **Flat-discount part:** NOT COVERED | There is no flat-amount code in the feature, so "a flat discount never exceeds the food subtotal" is untested. |
| R3 Rounding | "A discount that is not a whole number is rounded down" | Covered, but with the **wrong expected values** (see section 2). |
| R4 Cap | "The discount is capped at 40,000 VND" (300,000 subtotal); "The discount is recalculated when the cart changes" (200,000 subtotal gives exactly 40,000) | |
| R5 Validity | "An expired code is rejected" (2027-01-01); "The code is still valid on its last day" (2026-12-31); "A code that expires while checking out…" | |
| R6 One promo per order | "A second code cannot replace the first without removing it" | Only the **reject** branch is covered. The **replace** branch is NOT COVERED (see section 3). |
| R7 Typing codes | "The code is accepted regardless of letter case and surrounding spaces"; "An unknown code is rejected" | |

No rule is entirely uncovered. R2's flat-discount clause and R6's replace branch are the two gaps.

## 2. Scenarios that contradict a rule

### 2a. "A discount that is not a whole number is rounded down": wrong values

- Scenario lines:
  - `Given my cart has a food subtotal of 123,456 VND`
  - `Then the discount shown is 24,691 VND`
  - `And the total I pay is 113,765 VND`
- Rule R3: "A percentage discount is rounded **down** to the nearest **1,000 VND** (20% of 123,500 is 24,700, so the discount is 24,000)."
- 20% of 123,456 is 24,691.2. Rounded down to the nearest 1,000 VND, the discount should be **24,000 VND**, not 24,691.
- The total should be 123,456 − 24,000 + 15,000 = **114,456 VND**, not 113,765.
- The feature's header comment repeats the mistake: "Amounts are in VND, whole numbers, rounded down". That rounds to 1 VND, while R3 rounds to 1,000 VND. The scenario title ("not a whole number") also frames the rule as whole-number rounding.

### 2b. "A second code cannot replace the first without removing it": title and message contradict R6

- Scenario lines:
  - Title: `A second code cannot replace the first without removing it`
  - `Then I see the message "Only one promo code can be used per order"`
- Rule R6: a new code "**replaces** it only if the new code gives a **strictly bigger** discount on the current cart. Otherwise the new code is rejected with `ONE_PROMO_PER_ORDER` and the old code stays."
- The title says a replacement never happens without removing the old code. The rule says a replacement happens automatically when the new code is strictly better.
- The numbers in this scenario are consistent with R6: WELCOME10 gives 10% of 150,000 = 15,000, which is less than 30,000. So the rejection is correct, but only for that reason.
- The title should say the code is rejected because it is not strictly bigger. As written, it would pass an implementation that always rejects a second code, which violates R6.

## 3. Boundaries that are not tested

| Rule | Boundary | Status |
|---|---|---|
| R1 | Exactly 100,000 and 99,000 | Tested. |
| R1 | Minimum is on the subtotal **before** discount | Not tested. The "removing items" scenario only checks 90,000. No case shows a subtotal ≥ 100,000 that would fall below it after discount (e.g. 100,000 − 20,000 = 80,000 must still be accepted). The exact-minimum scenario does show this case implicitly (accepted, discount 20,000). |
| R3 | A percentage discount that is already an exact multiple of 1,000 (e.g. 150,000 → 30,000) | Tested by other scenarios. |
| R3 | A discount just under a 1,000 boundary (e.g. 20% of 129,999 = 25,999.8, so 25,000) | Not tested, and the one rounding scenario has the wrong numbers. |
| R4 | Exactly at the cap (200,000 → 40,000) | Only implicitly, in "recalculated when the cart changes". |
| R4 | Just over the cap (e.g. 200,005) | Not tested. |
| R4 | A percentage code **without** a cap | Not tested. WELCOME10 appears, but only as the rejected second code. |
| R5 | Last valid day and the first day after | Tested. |
| R6 | New code gives a **strictly bigger** discount, so it replaces the old one | Not tested. |
| R6 | New code gives an **equal** discount, so it is rejected and the old code stays | Not tested. This is the boundary the word "strictly" creates. |
| R6 | Re-applying the same code that is already applied | Not tested. It is an equal-discount case, so it should be rejected. |
| R2 | Flat discount larger than the food subtotal, so it is limited to the subtotal | Not tested. There is no flat code. |
| Order of checks | unknown → expired → minimum → one promo | Not tested with combinations. E.g. an expired code on a below-minimum cart must give `EXPIRED`, not `MIN_ORDER_NOT_MET`. Unknown code on a below-minimum cart must give `UNKNOWN_CODE`. |
| R7 | Lowercase and padded input | Tested together in one scenario. Tabs and internal spaces are not tested; that is a minor gap. |

## 4. Content in the feature that is not in the rules (invented)

1. **One use per customer.** The header says "one use per customer". The Background has "a customer who has not used SAVE20". The scenario "A code the customer already used is rejected" has the message "You have already used this promo code". None of this is in R1-R7. There is also no error code for it.
2. **Empty code.** The scenario "An empty code is rejected" has the message "Enter a promo code". The rules have no empty-input case. Under R7 it is arguably `UNKNOWN_CODE`, so this needs a decision.
3. **Removing a promo code.** The scenario "Removing the code restores the full price" tests a feature the rules never mention. Its total (165,000) follows the total formula, but removal itself is unspecified.
4. **Re-validation when the cart changes.** Two scenarios assume the discount is recalculated and the minimum is re-checked when items are added or removed: "The discount is recalculated…" and "Removing items below the minimum…". R1 says only when a code "can be applied". Behaviour after it is applied is not defined.
5. **Re-validation at payment.** The scenario "A code that expires while checking out…" invents a payment-time check, a "date changes before I tap Pay" event, and the line "payment is not taken until I confirm the new total". None of that is in the rules.
6. **User-facing message texts.** The rules define error **codes** (`MIN_ORDER_NOT_MET`, `EXPIRED`, `UNKNOWN_CODE`, `ONE_PROMO_PER_ORDER`). The feature invents the wording ("This promo code is not valid", "Minimum order for this code is 100,000 VND", and so on) and a UI. Only the messages for the four coded rules have a counterpart. The other messages are fully invented.
7. **Promo code values.** SAVE20, 20%, the 40,000 cap, valid until 2026-12-31, FREESHIP (not valid), WELCOME10 (10%), today = 2026-10-25 and a 15,000 delivery fee all come from the feature's own assumption header, not the rules. The rules' only example code is `SOOPI20`, and it is never used. The header is honest about this ("ASSUMPTIONS to be confirmed with the Founder"). The values affect every expected number, so they need confirming.
8. **The "Only one promo code can be used per order" message** is described in the rules as `ONE_PROMO_PER_ORDER`. The wording is invented, and as noted in 2b it implies a stricter rule than R6.
