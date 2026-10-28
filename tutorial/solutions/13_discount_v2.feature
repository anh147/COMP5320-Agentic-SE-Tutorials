# Acceptance criteria for SF-06 (v2), checked against business_rules.md R1-R7 and review.md.
#
# Only the rules in business_rules.md are specified here. Removed from v1 because the rules do not
# define them: one use per customer, empty codes, removing a code, re-checking the cart after a code
# is applied, and re-checking at payment. Errors use the rules' error codes, not invented message text.
#
# ASSUMPTIONS (code definitions are not in the rules, to be confirmed with the product owner):
#   SOOPI20   20% off the food subtotal, cap 40,000 VND, valid until 2026-12-31
#   WELCOME10 10% off the food subtotal, no cap, valid until 2026-12-31
#   FLAT30K   flat 30,000 VND off, valid until 2026-12-31
#   FLAT150K  flat 150,000 VND off, valid until 2026-12-31
#   OLD10     10% off the food subtotal, no cap, valid until 2026-09-30
#   Today is 2026-10-25 and the delivery fee is 15,000 VND.
# Total to pay = food subtotal - discount + delivery fee (business_rules.md).
# Check order (business_rules.md): unknown code, expired, minimum order, one promo per order.

Feature: Apply a promo code at checkout
  As a customer
  I want to apply a promo code at checkout
  So that I pay less

  Background:
    Given today is 2026-10-25
    And the delivery fee is 15,000 VND
    And these promo codes exist:
      | code      | type       | amount  | cap    | valid until |
      | SOOPI20   | percentage | 20%     | 40,000 | 2026-12-31  |
      | WELCOME10 | percentage | 10%     | none   | 2026-12-31  |
      | FLAT30K   | flat       | 30,000  | n/a    | 2026-12-31  |
      | FLAT150K  | flat       | 150,000 | n/a    | 2026-12-31  |
      | OLD10     | percentage | 10%     | none   | 2026-09-30  |

  # ---------------------------------------------------------------- happy path

  # R2 (delivery fee is not discounted), R3 (24,000 is already a multiple of 1,000), R4 (below the cap)
  @happy
  Scenario: A percentage code reduces the food subtotal but not the delivery fee
    Given my cart has a food subtotal of 150,000 VND
    When I apply the promo code "SOOPI20"
    Then the discount is 30,000 VND
    And the delivery fee is still 15,000 VND
    And the total to pay is 135,000 VND

  # R2
  @happy
  Scenario: A flat code reduces the food subtotal by its amount
    Given my cart has a food subtotal of 150,000 VND
    When I apply the promo code "FLAT30K"
    Then the discount is 30,000 VND
    And the total to pay is 135,000 VND

  # R4 (a percentage code without a cap is not limited)
  @happy
  Scenario: A percentage code without a cap is not limited
    Given my cart has a food subtotal of 500,000 VND
    When I apply the promo code "WELCOME10"
    Then the discount is 50,000 VND
    And the total to pay is 465,000 VND

  # R6 (new code strictly bigger, so it replaces the old one)
  @happy
  Scenario: A strictly better code replaces the applied code
    Given my cart has a food subtotal of 150,000 VND
    And I have applied the promo code "WELCOME10"
    When I apply the promo code "SOOPI20"
    Then the applied promo code is "SOOPI20"
    And the discount is 30,000 VND
    And the total to pay is 135,000 VND

  # R7
  @happy
  Scenario: Codes ignore letter case and surrounding spaces
    Given my cart has a food subtotal of 150,000 VND
    When I apply the promo code " soopi20 "
    Then the applied promo code is "SOOPI20"
    And the discount is 30,000 VND
    And the total to pay is 135,000 VND

  # ---------------------------------------------------------------- error cases

  # R7
  @error
  Scenario: A code that does not exist is rejected
    Given my cart has a food subtotal of 150,000 VND
    When I apply the promo code "SOOPI21"
    Then the code is rejected with UNKNOWN_CODE
    And no promo code is applied
    And the total to pay is 165,000 VND

  # R5
  @error
  Scenario: An expired code is rejected
    Given my cart has a food subtotal of 150,000 VND
    When I apply the promo code "OLD10"
    Then the code is rejected with EXPIRED
    And no promo code is applied
    And the total to pay is 165,000 VND

  # R1 (the delivery fee does not count: 99,999 + 15,000 would pass if it did)
  @error
  Scenario: A subtotal below the minimum is rejected
    Given my cart has a food subtotal of 99,999 VND
    When I apply the promo code "SOOPI20"
    Then the code is rejected with MIN_ORDER_NOT_MET
    And no promo code is applied
    And the total to pay is 114,999 VND

  # R6 (new code gives a smaller discount: 15,000 < 30,000)
  @error
  Scenario: A worse code does not replace the applied code
    Given my cart has a food subtotal of 150,000 VND
    And I have applied the promo code "SOOPI20"
    When I apply the promo code "WELCOME10"
    Then the code is rejected with ONE_PROMO_PER_ORDER
    And the applied promo code is still "SOOPI20"
    And the discount is 30,000 VND
    And the total to pay is 135,000 VND

  # Order of checks: unknown code comes before minimum order
  @error
  Scenario: An unknown code on a cart below the minimum reports UNKNOWN_CODE
    Given my cart has a food subtotal of 50,000 VND
    When I apply the promo code "SOOPI21"
    Then the code is rejected with UNKNOWN_CODE

  # Order of checks: expired comes before minimum order (R5, R1)
  @error
  Scenario: An expired code on a cart below the minimum reports EXPIRED
    Given my cart has a food subtotal of 50,000 VND
    When I apply the promo code "OLD10"
    Then the code is rejected with EXPIRED

  # Order of checks: expired comes before one promo per order (R5, R6)
  @error
  Scenario: An expired code while another code is applied reports EXPIRED
    Given my cart has a food subtotal of 150,000 VND
    And I have applied the promo code "SOOPI20"
    When I apply the promo code "OLD10"
    Then the code is rejected with EXPIRED
    And the applied promo code is still "SOOPI20"

  # Order of checks: minimum order comes before one promo per order (R1, R6)
  # With an applied code the cart is already at least 100,000 VND, so this is covered by the
  # R1 and R6 scenarios above and cannot be set up separately without inventing cart changes.

  # ---------------------------------------------------------------- edge cases

  # R1 (exactly at the minimum is accepted; the minimum is on the subtotal before discount,
  # so the 80,000 VND left after the discount is still accepted)
  @edge
  Scenario: A subtotal exactly at the minimum is accepted
    Given my cart has a food subtotal of 100,000 VND
    When I apply the promo code "SOOPI20"
    Then the discount is 20,000 VND
    And the total to pay is 95,000 VND

  # R3 (20% of 123,456 is 24,691.2, rounded down to the nearest 1,000)
  @edge
  Scenario: A percentage discount is rounded down to the nearest 1,000 VND
    Given my cart has a food subtotal of 123,456 VND
    When I apply the promo code "SOOPI20"
    Then the discount is 24,000 VND
    And the total to pay is 114,456 VND

  # R3 (20% of 129,999 is 25,999.8, which stays below the 26,000 boundary)
  @edge
  Scenario: A discount just under a 1,000 VND boundary is rounded down
    Given my cart has a food subtotal of 129,999 VND
    When I apply the promo code "SOOPI20"
    Then the discount is 25,000 VND
    And the total to pay is 119,999 VND

  # R3, R4 (20% of 199,999 is 39,999.8, rounded down to 39,000, which is under the cap)
  @edge
  Scenario: Rounding applies before the cap is reached
    Given my cart has a food subtotal of 199,999 VND
    When I apply the promo code "SOOPI20"
    Then the discount is 39,000 VND
    And the total to pay is 175,999 VND

  # R4 (20% of 200,000 is exactly the cap)
  @edge
  Scenario: A discount exactly at the cap is allowed
    Given my cart has a food subtotal of 200,000 VND
    When I apply the promo code "SOOPI20"
    Then the discount is 40,000 VND
    And the total to pay is 175,000 VND

  # R4 (20% of 210,000 is 42,000, above the cap)
  @edge
  Scenario: A discount above the cap is limited to the cap
    Given my cart has a food subtotal of 210,000 VND
    When I apply the promo code "SOOPI20"
    Then the discount is 40,000 VND
    And the total to pay is 185,000 VND

  # R2 (a flat discount of 150,000 is limited to the food subtotal of 100,000; delivery fee still paid)
  @edge
  Scenario: A flat discount never exceeds the food subtotal
    Given my cart has a food subtotal of 100,000 VND
    When I apply the promo code "FLAT150K"
    Then the discount is 100,000 VND
    And the total to pay is 15,000 VND

  # R5 (valid up to and including the valid-until date)
  @edge
  Scenario: A code is still valid on its last day
    Given today is 2026-12-31
    And my cart has a food subtotal of 150,000 VND
    When I apply the promo code "SOOPI20"
    Then the discount is 30,000 VND
    And the total to pay is 135,000 VND

  # R5 (the day after the valid-until date)
  @edge
  Scenario: A code is expired the day after its last day
    Given today is 2027-01-01
    And my cart has a food subtotal of 150,000 VND
    When I apply the promo code "SOOPI20"
    Then the code is rejected with EXPIRED
    And the total to pay is 165,000 VND

  # R6 (equal discount is not strictly bigger: both give 30,000)
  @edge
  Scenario: A code with an equal discount does not replace the applied code
    Given my cart has a food subtotal of 150,000 VND
    And I have applied the promo code "SOOPI20"
    When I apply the promo code "FLAT30K"
    Then the code is rejected with ONE_PROMO_PER_ORDER
    And the applied promo code is still "SOOPI20"
    And the total to pay is 135,000 VND

  # R6 (applying the same code again is an equal discount)
  @edge
  Scenario: Applying the same code twice is rejected
    Given my cart has a food subtotal of 150,000 VND
    And I have applied the promo code "SOOPI20"
    When I apply the promo code "SOOPI20"
    Then the code is rejected with ONE_PROMO_PER_ORDER
    And the applied promo code is still "SOOPI20"
    And the total to pay is 135,000 VND

  # R4, R6 (the comparison uses the capped discount: SOOPI20 gives 40,000, not 60,000)
  @edge
  Scenario: Replacement compares the capped discount
    Given my cart has a food subtotal of 300,000 VND
    And I have applied the promo code "SOOPI20"
    When I apply the promo code "FLAT30K"
    Then the code is rejected with ONE_PROMO_PER_ORDER
    And the applied promo code is still "SOOPI20"
    And the discount is 40,000 VND
    And the total to pay is 275,000 VND

  # R7 (mixed case)
  @edge
  Scenario: Mixed-case codes are accepted
    Given my cart has a food subtotal of 150,000 VND
    When I apply the promo code "SoOpI20"
    Then the applied promo code is "SOOPI20"
    And the discount is 30,000 VND
