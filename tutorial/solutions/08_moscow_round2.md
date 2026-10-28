# SoopiFood Release 1: MoSCoW Round 2 (with stakeholder notes)

Release goal: a customer can find food, order it, pay, and receive it. Capacity: 50 points.
Inputs: `backlog.yaml` and `stakeholder_notes.md`.

## 1. Prioritisation

| id | title | points | priority | reason |
|----|-------|--------|----------|--------|
| SF-01 | Sign up and log in with phone number + OTP | 3 | Must | Orders and payments need an identified customer. |
| SF-02 | Browse restaurants and menus near my address | 5 | Must | "Find food" is the first step of the release goal. |
| SF-03 | Add dishes to a cart and place an order | 5 | Must | "Order it" is part of the release goal. |
| SF-04 | Pay by card or e-wallet | 5 | Must | "Pay" is part of the release goal, for customers who pay online. |
| SF-05 | Restaurant accepts or rejects an incoming order | 3 | Must | Without it, no order can reach the restaurant and be fulfilled. |
| SF-07 | Order status updates (placed, cooking, on the way, delivered) | 3 | Must | The customer needs to know the order is "received". |
| SF-06 | Apply a promo code at checkout | 3 | Must | Founder: no promo codes means no launch campaign. |
| SF-13 | Pay cash on delivery | 3 | Must | Operations: about 70% of first-time customers pay cash on delivery. |
| SF-08 | See the driver's live location on a map | 5 | Should | Valued by customers, but status updates (SF-07) are the workaround. |
| SF-10 | Rate and review a restaurant after delivery | 3 | Should | Marketing: ratings are the main trust signal. A workaround exists, since launch can happen without them and they build up over time. |
| SF-14 | Add special instructions for the restaurant | 2 | Should | Restaurants: changes are made by phone today and orders go wrong. Phone is the workaround. |
| SF-09 | Reorder a previous order in one tap | 2 | Could | Convenience for repeat customers, who can rebuild a cart manually. |
| SF-11 | Schedule an order for a later time | 5 | Could | No note supports it, so it is only here to use the remaining capacity if time permits. |
| SF-15 | Dark mode | 3 | Could | No note supports it, so it is cosmetic and only here to use the remaining capacity if time permits. |
| SF-12 | SoopiCoins loyalty points on every order | 8 | Won't | Largest story and a retention feature, not needed to launch. |

## 2. Summary

| category | stories | points | % of planned |
|----------|---------|--------|--------------|
| Must | SF-01, 02, 03, 04, 05, 06, 07, 13 | 30 | 60% |
| Should | SF-08, 10, 14 | 10 | 20% |
| Could | SF-09, 11, 15 | 10 | 20% |
| **Planned (M+S+C)** | 14 stories | **50** | 100% |
| Won't | SF-12 | 8 | not planned |
| Backlog total | 15 stories | 58 | |

Planned 50 points vs capacity 50 points: no headroom.

## 3. Changes from round 1

| id | round 1 | round 2 | note that caused it |
|----|---------|---------|---------------------|
| SF-06 Promo code | Should | **Must** | Founder: the launch campaign is built around first-order promo codes. |
| SF-13 Cash on delivery | Could | **Must** | Operations: about 70% of first-time customers pay cash on delivery. |
| SF-10 Rate and review | Could | **Should** | Marketing: new users pick restaurants by star rating, and ratings are the main trust signal. |
| SF-14 Special instructions | Won't | **Should** | Restaurants: customers ask for changes and phone orders go wrong. |
| SF-11 Schedule order | Won't | **Could** | No note. It was moved only to fill the capacity freed by the stricter 60/20/20 split. |
| SF-15 Dark mode | Won't | **Could** | No note. It was moved only to fill the capacity freed by the stricter 60/20/20 split. |

Unchanged: SF-01, 02, 03, 04, 05, 07 (Must), SF-08 (Should), SF-09 (Could), SF-12 (Won't).

SF-10 is Should rather than Must because a launch is still possible without ratings, which build up after launch.

## 4. Final allocation table (after the changes)

| id | title | points | priority | round 1 → round 2 |
|----|-------|--------|----------|-------------------|
| SF-01 | Sign up and log in with phone number + OTP | 3 | Must | unchanged |
| SF-02 | Browse restaurants and menus near my address | 5 | Must | unchanged |
| SF-03 | Add dishes to a cart and place an order | 5 | Must | unchanged |
| SF-04 | Pay by card or e-wallet | 5 | Must | unchanged |
| SF-05 | Restaurant accepts or rejects an incoming order | 3 | Must | unchanged |
| SF-07 | Order status updates (placed, cooking, on the way, delivered) | 3 | Must | unchanged |
| SF-06 | Apply a promo code at checkout | 3 | Must | Should → Must (Founder) |
| SF-13 | Pay cash on delivery | 3 | Must | Could → Must (Operations) |
| SF-08 | See the driver's live location on a map | 5 | Should | unchanged |
| SF-10 | Rate and review a restaurant after delivery | 3 | Should | Could → Should (Marketing) |
| SF-14 | Add special instructions for the restaurant | 2 | Should | Won't → Should (Restaurants) |
| SF-09 | Reorder a previous order in one tap | 2 | Could | unchanged |
| SF-11 | Schedule an order for a later time | 5 | Could | Won't → Could (capacity fill, no note) |
| SF-15 | Dark mode | 3 | Could | Won't → Could (capacity fill, no note) |
| SF-12 | SoopiCoins loyalty points on every order | 8 | Won't | unchanged |
| | **Planned (Must + Should + Could)** | **50 / 50** | | Must 30 (60%), Should 10 (20%), Could 10 (20%) |

## 5. Self-check

- **Must + Should + Could fit in capacity:** MET. 50 ≤ 50, with no headroom.
- **Split roughly 60/20/20:** MET. Must 30/50 = 60%, Should 10/50 = 20%, Could 10/50 = 20%. This time the percentages are against capacity too, because planned equals capacity.
- **Every story prioritised:** MET. 15 of 15 stories. The points add up: 30 + 10 + 10 + 8 = 58.
- **Every change traced to a note:** PARTLY. Four of the six changes come from a stakeholder note. SF-11 and SF-15 do not, and they are only there to fill the Could budget. Dropping them back to Won't would give 42 planned points (about 71% Must, 24% Should, 5% Could) and 8 points of buffer, which is a decision for the team.
