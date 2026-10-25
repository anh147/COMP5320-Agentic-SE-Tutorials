# SoopiFood business rules: promo codes (story SF-06)

Source: SoopiFood product owner. All amounts are in Vietnamese dong (VND), whole numbers.
A promo code is either a **percentage** off (optionally with a cap) or a **flat** amount off.

| ID | Rule |
|---|---|
| R1 | **Minimum order.** A code can only be applied if the food subtotal is at least **100,000 VND**. The minimum is checked on the food subtotal **before** any discount; the delivery fee does not count. Otherwise: `MIN_ORDER_NOT_MET`. |
| R2 | **What is discounted.** A promo only reduces the **food** subtotal, never the delivery fee. A flat discount never exceeds the food subtotal. |
| R3 | **Rounding.** A percentage discount is rounded **down** to the nearest **1,000 VND** (20% of 123,500 is 24,700, so the discount is 24,000). |
| R4 | **Cap.** A percentage discount never exceeds the code's cap, if it has one. |
| R5 | **Validity.** A code is valid up to **and including** its valid-until date. From the next day on: `EXPIRED`. |
| R6 | **One promo per order.** If a code is already applied, a new code **replaces** it only if the new code gives a **strictly bigger** discount on the current cart. Otherwise the new code is rejected with `ONE_PROMO_PER_ORDER` and the old code stays. |
| R7 | **Typing codes.** Codes are not case-sensitive and surrounding spaces are ignored (`" soopi20 "` works like `"SOOPI20"`). A code that does not exist: `UNKNOWN_CODE`. |

**Order of checks:** unknown code → expired → minimum order → one promo per order.

**Total to pay** = food subtotal − discount + delivery fee.
