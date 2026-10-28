# SoopiFood Release 1: Scope Changes

Baseline: the plan in `moscow.md` (50 of 50 points planned, Must 30 / Should 10 / Could 10).
Change requests: `change_requests.yaml`. Capacity does not change: 50 points.

## 1. Decisions

| CR | decision | trade-off | why |
|----|----------|-----------|-----|
| CR-01 Allergen information on every dish (2 pts, Legal) | **Must** | Adds 2 planned points. Pay for it by dropping **SF-15 Dark mode (3 pts, Could → Won't)**. This frees 3 points, which is 1 more than needed, so 1 point is left as buffer. | It is a legal requirement from the launch date, so launching without it is not allowed. That is the definition of Must. Dark mode is purely cosmetic, and in round 2 it was only in the plan to fill the Could budget (no stakeholder note asked for it), so it is the cheapest thing to lose. |
| CR-02 Split the bill in a group order (8 pts, Marketing) | **Won't** (this release) | Adds no planned points, so nothing is demoted or dropped. | Marketing says the campaign can still run without it, so a workaround exists and it is not a Must. It is also the second largest story in the backlog. Making it a Should or Could would mean dropping Should or Could stories that stakeholders asked for (SF-10, SF-14, SF-08) or most of the Could budget (SF-11 and SF-09 are only 7 points), to pay for a "would like". Defer to Release 2. |

Alternatives considered for paying for CR-01: dropping SF-09 (2 pts) would be an exact fit and give 64/20/16, but one-tap reorder helps repeat customers, while dark mode helps nobody launch. Dropping SF-11 (5 pts) would free more than needed.

## 2. Updated prioritisation

| id | title | points | priority | change |
|----|-------|--------|----------|--------|
| SF-01 | Sign up and log in with phone number + OTP | 3 | Must | |
| SF-02 | Browse restaurants and menus near my address | 5 | Must | |
| SF-03 | Add dishes to a cart and place an order | 5 | Must | |
| SF-04 | Pay by card or e-wallet | 5 | Must | |
| SF-05 | Restaurant accepts or rejects an incoming order | 3 | Must | |
| SF-06 | Apply a promo code at checkout | 3 | Must | |
| SF-07 | Order status updates | 3 | Must | |
| SF-13 | Pay cash on delivery | 3 | Must | |
| CR-01 | Show allergen information on every dish | 2 | Must | new |
| SF-08 | See the driver's live location on a map | 5 | Should | |
| SF-10 | Rate and review a restaurant after delivery | 3 | Should | |
| SF-14 | Add special instructions for the restaurant | 2 | Should | |
| SF-09 | Reorder a previous order in one tap | 2 | Could | |
| SF-11 | Schedule an order for a later time | 5 | Could | |
| SF-15 | Dark mode | 3 | Won't | was Could |
| SF-12 | SoopiCoins loyalty points on every order | 8 | Won't | |
| CR-02 | Split the bill in a group order | 8 | Won't | new |

## 3. Updated summary

| category | stories | points | % of planned |
|----------|---------|--------|--------------|
| Must | SF-01, 02, 03, 04, 05, 06, 07, 13, CR-01 | 32 | 65% |
| Should | SF-08, 10, 14 | 10 | 20% |
| Could | SF-09, 11 | 7 | 14% |
| **Planned (M+S+C)** | 14 items | **49** | 100% |
| Won't | SF-12, SF-15, CR-02 | 19 | not planned |
| Total including CRs | 17 items | 68 | |

Planned 49 points vs capacity 50 points: 1 point of headroom.

## 4. Self-check

- **Must + Should + Could fit in capacity:** MET. 49 ≤ 50.
- **Split roughly 60/20/20:** MET, but it drifted slightly. Must 32/49 = 65%, Should 10/49 = 20%, Could 7/49 = 14%. Must grew because of the legal requirement, and Could shrank to pay for it. Against the full capacity of 50 the split is 64% / 20% / 14%. This is a result of the change, so I did not promote stories to force the exact split.
- **Every story and CR prioritised:** MET. 17 of 17 items. The points add up: 32 + 10 + 7 + 19 = 68, which is the 58-point backlog plus 10 points from the two CRs.
- **Every change has a cause:** MET. CR-01 is the legal requirement, CR-02 was deferred because of its workaround, and SF-15 was dropped to pay for CR-01.

---

## 5. Marketing pushback: "Split the bill (CR-02) must be in Release 1"

Marketing now says CR-02 is the headline of the launch campaign. Earlier, they said the campaign could run without it, and the Founder said the campaign is built around promo codes (SF-06). Those statements do not match, so Marketing and the Founder should agree what the headline is. That agreement changes how much CR-02 is worth, but the options below hold either way.

**The arithmetic.** The plan is at 49 of 50 points. Adding CR-02 (8 points) gives 57, so **7 points must leave the plan**. Capacity stays at 50.

### Options

| option | what leaves the plan | points freed | what it costs the release goal | resulting split (M / S / C, of planned) |
|--------|----------------------|--------------|--------------------------------|------------------------------------------|
| **0. Keep CR-02 out** (current plan) | nothing | 0 | Nothing on the goal. Marketing loses its headline feature, and its campaign has to use promo codes instead. | 32 / 10 / 7 = 49 (65% / 20% / 14%) |
| **A. Cut all Could stories** | SF-09 reorder (2) and SF-11 schedule order (5), both Could → Won't | 7 | None on find, order, pay, receive. Repeat customers rebuild their cart by hand, and nobody can pre-order. Neither is tied to a stakeholder note. | 32 / 10 / 8 (CR-02 as Could) = 50 (64% / 20% / 16%) |
| **B. Cut Should stories** | SF-08 live driver map (5) and SF-14 special instructions (2), both Should → Won't | 7 | Hurts "receive it": customers fall back on status updates. It also drops the Restaurants request, so wrong orders stay a problem. | 32 / 3 + 8 / 7 = 50 if CR-02 is Should |
| **C. Cut ratings plus the map** | SF-10 rate and review (3) and SF-08 live map (5), both Should → Won't | 8 | Removes the trust signal Marketing asked for in the notes, so Marketing would trade one request for another. | 32 / 2 + 8 / 7 = 49 |
| **D. Demote Musts** | e.g. SF-06 promo (3) and SF-13 COD (3), plus 1 more point from a Could | 7 | Hurts "pay it": it loses the Founder's campaign and about 70% of first-time payers. This breaks the release goal. | Not recommended, so not worked out. |

All options keep the capacity at 50. Options B and C pay for the feature with stories that stakeholders asked for, and D pays with the release goal. A is the only one that pays with stories nobody asked for.

### Recommendation: Option A

Accept CR-02 into Release 1 as a **Could** and pay for it with SF-09 and SF-11 (both move to Won't).

- **Why:** the only things lost are reorder and scheduling, which are conveniences not connected to find, order, pay or receive, and no stakeholder note supports them. All Musts and Shoulds stay, so the Founder's, Operations', Marketing's and Restaurants' requests are all kept.
- **The split holds:** 32 / 10 / 8 = 50, or 64% / 20% / 16%, which is close to 60/20/20 and fits capacity exactly.
- **Condition 1: CR-02 is a Could, not a Should or Must.** Marketing said earlier that the campaign can run without it, so a workaround exists. To protect it, schedule it first among the Could work, so it is not the story left unfinished.
- **Condition 2: there is now no buffer.** The plan goes from 1 point of headroom to 0, and CR-02 is an 8-point story that is new and not yet designed (group state, split payments). If it slips, drop it back out to Won't. Do not take points from the Musts to save it.
- **Condition 3: Marketing should accept that this is the price.** If they will not give up reorder and scheduling, the real trade is Option B or C, and they should see that cost.

### Updated summary if Option A is accepted

| category | stories | points | % of planned |
|----------|---------|--------|--------------|
| Must | SF-01, 02, 03, 04, 05, 06, 07, 13, CR-01 | 32 | 64% |
| Should | SF-08, 10, 14 | 10 | 20% |
| Could | CR-02 | 8 | 16% |
| **Planned (M+S+C)** | 13 items | **50** | 100% |
| Won't | SF-09, SF-11, SF-12, SF-15 | 18 | not planned |

Planned 50 vs capacity 50: fits, with no headroom.

Self-check: capacity MET (50 ≤ 50). Split MET (64 / 20 / 16, roughly 60/20/20). Every item prioritised MET (17 of 17: 32 + 10 + 8 + 18 = 68). This is a recommendation only. The agreed plan in section 3 stands until Marketing and the Founder decide.

### New allocation table (Option A, capacity fixed at 50)

| id | title | points | priority | change vs section 2 |
|----|-------|--------|----------|---------------------|
| SF-01 | Sign up and log in with phone number + OTP | 3 | Must | |
| SF-02 | Browse restaurants and menus near my address | 5 | Must | |
| SF-03 | Add dishes to a cart and place an order | 5 | Must | |
| SF-04 | Pay by card or e-wallet | 5 | Must | |
| SF-05 | Restaurant accepts or rejects an incoming order | 3 | Must | |
| SF-06 | Apply a promo code at checkout | 3 | Must | |
| SF-07 | Order status updates | 3 | Must | |
| SF-13 | Pay cash on delivery | 3 | Must | |
| CR-01 | Show allergen information on every dish | 2 | Must | |
| SF-08 | See the driver's live location on a map | 5 | Should | |
| SF-10 | Rate and review a restaurant after delivery | 3 | Should | |
| SF-14 | Add special instructions for the restaurant | 2 | Should | |
| CR-02 | Split the bill in a group order | 8 | Could | was Won't |
| SF-09 | Reorder a previous order in one tap | 2 | Won't | was Could |
| SF-11 | Schedule an order for a later time | 5 | Won't | was Could |
| SF-15 | Dark mode | 3 | Won't | |
| SF-12 | SoopiCoins loyalty points on every order | 8 | Won't | |
| | **Planned (Must + Should + Could)** | **50 / 50** | | Must 32, Should 10, Could 8 |
