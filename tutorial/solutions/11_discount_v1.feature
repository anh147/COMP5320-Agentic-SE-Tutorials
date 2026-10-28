# Acceptance criteria for SF-06.
# The story gives no promo rules, so the values below are ASSUMPTIONS to be confirmed with the Founder:
#   - Code SAVE20: 20% off the food subtotal, capped at 40,000 VND, minimum subtotal 100,000 VND,
#     valid until 2026-12-31 (inclusive), one use per customer.
#   - Code FREESHIP is not a valid code.
#   - The delivery fee is never discounted. Amounts are in VND, whole numbers, rounded down.
#   - Today is 2026-10-25. One promo code per order.

Feature: Apply a promo code at checkout
  As a customer
  I want to apply a promo code at checkout
  So that I pay less

  Background:
    Given today is 2026-10-25
    And the promo code "SAVE20" gives 20% off the food subtotal, capped at 40,000 VND
    And "SAVE20" requires a food subtotal of at least 100,000 VND
    And "SAVE20" is valid until 2026-12-31
    And I am logged in as a customer who has not used "SAVE20"
    And the delivery fee is 15,000 VND

  @happy
  Scenario: A valid code reduces the total
    Given my cart has a food subtotal of 150,000 VND
    When I apply the promo code "SAVE20"
    Then the discount shown is 30,000 VND
    And the total I pay is 135,000 VND

  @happy
  Scenario: The code is accepted regardless of letter case and surrounding spaces
    Given my cart has a food subtotal of 150,000 VND
    When I apply the promo code " save20 "
    Then the discount shown is 30,000 VND
    And the total I pay is 135,000 VND

  @happy
  Scenario: Removing the code restores the full price
    Given my cart has a food subtotal of 150,000 VND
    And I have applied the promo code "SAVE20"
    When I remove the promo code
    Then no discount is shown
    And the total I pay is 165,000 VND

  @happy
  Scenario: The discount is recalculated when the cart changes
    Given my cart has a food subtotal of 150,000 VND
    And I have applied the promo code "SAVE20"
    When I add a dish of 50,000 VND to the cart
    Then the discount shown is 40,000 VND
    And the total I pay is 175,000 VND

  @error
  Scenario: An unknown code is rejected
    Given my cart has a food subtotal of 150,000 VND
    When I apply the promo code "FREESHIP"
    Then I see the message "This promo code is not valid"
    And no discount is shown
    And the total I pay is 165,000 VND

  @error
  Scenario: An expired code is rejected
    Given today is 2027-01-01
    And my cart has a food subtotal of 150,000 VND
    When I apply the promo code "SAVE20"
    Then I see the message "This promo code has expired"
    And the total I pay is 165,000 VND

  @error
  Scenario: A code is rejected when the subtotal is below the minimum
    Given my cart has a food subtotal of 99,000 VND
    When I apply the promo code "SAVE20"
    Then I see the message "Minimum order for this code is 100,000 VND"
    And the total I pay is 114,000 VND

  @error
  Scenario: A code the customer already used is rejected
    Given I have already completed an order using "SAVE20"
    And my cart has a food subtotal of 150,000 VND
    When I apply the promo code "SAVE20"
    Then I see the message "You have already used this promo code"
    And the total I pay is 165,000 VND

  @error
  Scenario: An empty code is rejected
    Given my cart has a food subtotal of 150,000 VND
    When I apply the promo code ""
    Then I see the message "Enter a promo code"
    And the total I pay is 165,000 VND

  @error
  Scenario: A second code cannot replace the first without removing it
    Given a second valid code "WELCOME10" gives 10% off the food subtotal
    And my cart has a food subtotal of 150,000 VND
    And I have applied the promo code "SAVE20"
    When I apply the promo code "WELCOME10"
    Then I see the message "Only one promo code can be used per order"
    And the discount shown is still 30,000 VND
    And the total I pay is 135,000 VND

  @edge
  Scenario: A subtotal exactly at the minimum qualifies
    Given my cart has a food subtotal of 100,000 VND
    When I apply the promo code "SAVE20"
    Then the discount shown is 20,000 VND
    And the total I pay is 95,000 VND

  @edge
  Scenario: The discount is capped at 40,000 VND
    Given my cart has a food subtotal of 300,000 VND
    When I apply the promo code "SAVE20"
    Then the discount shown is 40,000 VND
    And the total I pay is 275,000 VND

  @edge
  Scenario: The code is still valid on its last day
    Given today is 2026-12-31
    And my cart has a food subtotal of 150,000 VND
    When I apply the promo code "SAVE20"
    Then the discount shown is 30,000 VND
    And the total I pay is 135,000 VND

  @edge
  Scenario: A discount that is not a whole number is rounded down
    Given my cart has a food subtotal of 123,456 VND
    When I apply the promo code "SAVE20"
    Then the discount shown is 24,691 VND
    And the total I pay is 113,765 VND

  @edge
  Scenario: Removing items below the minimum removes the discount
    Given my cart has a food subtotal of 120,000 VND
    And I have applied the promo code "SAVE20"
    When I remove a dish of 30,000 VND from the cart
    Then I see the message "Minimum order for this code is 100,000 VND"
    And no discount is shown
    And the total I pay is 105,000 VND

  @edge
  Scenario: A code that expires while checking out is rejected at payment
    Given today is 2026-12-31
    And my cart has a food subtotal of 150,000 VND
    And I have applied the promo code "SAVE20"
    When the date changes to 2027-01-01 before I tap "Pay"
    Then I see the message "This promo code has expired"
    And the total I pay is 165,000 VND
    And the payment is not taken until I confirm the new total
