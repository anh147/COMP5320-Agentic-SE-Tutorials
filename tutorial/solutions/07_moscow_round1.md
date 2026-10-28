# SoopiFood Release 1: MoSCoW Round 1

Release goal: a customer can find food, order it, pay, and receive it. Capacity: 50 points.

## 1. Prioritisation

| id | title | points | priority | reason |
|----|-------|--------|----------|--------|
| SF-01 | Sign up and log in with phone number + OTP | 3 | Must | Orders and payments need an identified customer. |
| SF-02 | Browse restaurants and menus near my address | 5 | Must | "Find food" is the first step of the release goal. |
| SF-03 | Add dishes to a cart and place an order | 5 | Must | "Order it" is part of the release goal. |
| SF-04 | Pay by card or e-wallet | 5 | Must | "Pay" is part of the release goal, and it is the only payment method in the Must set. |
| SF-05 | Restaurant accepts or rejects an incoming order | 3 | Must | Without it, no order can reach the restaurant and be fulfilled. |
| SF-07 | Order status updates (placed, cooking, on the way, delivered) | 3 | Must | The customer needs to know the order is "received", and there is no other way to tell. |
| SF-06 | Apply a promo code at checkout | 3 | Should | Important for acquisition, but customers can still order at full price. |
| SF-08 | See the driver's live location on a map | 5 | Should | Valued by customers, but status updates (SF-07) are the workaround. |
| SF-13 | Pay cash on delivery | 3 | Could | Widens reach, but card and e-wallet already cover paying. |
| SF-10 | Rate and review a restaurant after delivery | 3 | Could | Useful feedback loop, but it happens after the order journey is complete. |
| SF-09 | Reorder a previous order in one tap | 2 | Could | Convenience for repeat customers, who can rebuild a cart manually. |
| SF-11 | Schedule an order for a later time | 5 | Won't | Adds scheduling complexity, and ordering for now is enough for an MVP. |
| SF-12 | SoopiCoins loyalty points on every order | 8 | Won't | Largest story and a retention feature, not needed to launch. |
| SF-14 | Add special instructions for the restaurant | 2 | Won't | Customers can phone the restaurant, and the points are better spent on the planned scope. |
| SF-15 | Dark mode | 3 | Won't | Cosmetic, with no effect on the release goal. |

## 2. Summary

| category | stories | points | % of planned |
|----------|---------|--------|--------------|
| Must | SF-01, 02, 03, 04, 05, 07 | 24 | 60% |
| Should | SF-06, 08 | 8 | 20% |
| Could | SF-13, 10, 09 | 8 | 20% |
| **Planned (M+S+C)** | 11 stories | **40** | 100% |
| Won't | SF-11, 12, 14, 15 | 18 | not planned |
| Backlog total | 15 stories | 58 | |

Planned 40 points vs capacity 50 points: 10 points (20%) of headroom.

## 3. Self-check

- **Must + Should + Could fit in capacity:** MET. 40 ≤ 50.
- **Split roughly 60/20/20:** MET. Must 24/40 = 60%, Should 8/40 = 20%, Could 8/40 = 20%.
- **Every story prioritised:** MET. 15 of 15 stories, with 11 planned and 4 Won't. The points add up: 24 + 8 + 8 + 18 = 58.

Note: the 60/20/20 split is measured against planned points (40), not against capacity (50). Against capacity, Must is 48%. Reaching 60% of 50 (30 points) would mean promoting stories that are not truly Must, such as live tracking or cash on delivery. The 10 spare points are a buffer. SF-14 (2 points) would be the first story to pull in from Won't if there is room.
