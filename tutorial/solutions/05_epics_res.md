* **Epic 1: Order Intake & Flow Control**
* **Feature 1.1: Order Visibility & Alerting**
* **US-01: Receive & View New Orders**
* **Story:** As David, the Omnipresent Operator, I want the system to generate audible alerts and display full order details upon order receipt, so that I can quickly start bagging the correct items without double-entry.


* **Acceptance Criteria:**
* Given the tablet app is active, when a customer completes checkout, then the order service delivers the new order payload to the tablet within `[TBC]` seconds.


* Given a new order is received, when I look at the tablet, then critical alerting text is legible from a minimum distance of `[TBC]` meters.


* Given I tap the new order alert, when the order opens, then full order details (items, modifiers, customer info) are displayed.




* **Coverage:** OI-03, OI-05, NFR-01, NFR-05.




* **US-02: Mute Order Alerts**
* **Story:** As Mateo, the Floor-First Manager, I want to manually mute audible alerts, so that loud tablet pinging doesn't disrupt the dine-in ambiance or distract front-of-house staff.


* **Acceptance Criteria:**
* Given the tablet is sounding new order alerts, when I manually trigger the mute toggle, then the tablet stops making sounds.


* Given the tablet is muted, when a new order payload arrives, then the visual alert displays without triggering an audible chime.


* **Coverage:** OI-04.






* **Feature 1.2: Kitchen Pacing**
* **US-03: Pause Incoming Orders**
* **Story:** As Mateo, the Floor-First Manager, I want to manually trigger the system to pause incoming orders, so that I can temporarily throttle delivery volume and prioritize dine-in guests during dinner rushes.


* **Acceptance Criteria:**
* Given the system is actively accepting orders, when I manually trigger the pause function, then the system stops routing new orders to the tablet.


* Given the restaurant experiences a localized Wi-Fi dropout, when I trigger the pause function and the network is later restored, then the tablet successfully syncs the pause state to the backend within `[TBC]` seconds.




* **Coverage:** OI-01, NFR-02.




* **US-04: Extend Prep Times**
* **Story:** As Sarah, the High-Volume Orchestrator, I want to manually extend order preparation times by `[TBC]` minutes, so that I can dynamically adjust expectations based on real-time kitchen capacity.


* **Acceptance Criteria:**
* Given an active order is in progress, when I select the extend time option, then the system adds `[TBC]` minutes to the prep time.


* Given I extend the prep time during a Wi-Fi dropout, when the network restores, then the extension successfully syncs to the backend within `[TBC]` seconds.




* **Coverage:** OI-02, NFR-02.








* **Epic 2: Menu & Delivery Coordination**
* **Feature 2.1: Menu Availability Management**
* **US-05: Mark Menu Items Unavailable (86ing)**
* **Story:** As Sarah, the High-Volume Orchestrator, I want to mark menu items as unavailable until a `[TBC]` condition is met, so that I avoid tedious manual cancellations and refunds when ingredients run out mid-service.


* **Acceptance Criteria:**
* Given an ingredient runs out, when I mark the associated item as unavailable, then the customer app immediately blocks new orders for that item.
* Given an item is marked out of stock, when the `[TBC]` condition is met (e.g., end of shift), then the system automatically marks it as available again.


* Given a localized Wi-Fi dropout occurs, when I mark an item unavailable and the network restores, then the state change queues and syncs within `[TBC]` seconds.




* **Coverage:** MA-01, NFR-02.






* **Feature 2.2: Rider Tracking & Verification**
* **US-06: Track Rider ETA**
* **Story:** As Sarah, the High-Volume Orchestrator, I want the system to display and dynamically update rider estimated arrival times for active orders, so that I can perfectly time food bagging and prevent orders from sitting under heat lamps.


* **Acceptance Criteria:**
* Given an order is active and assigned, when I look at the tablet, then I can see the rider's estimated arrival time.


* Given a rider is en route, when `[TBC]` intervals pass, then the ETA dynamically updates on the screen.




* **Coverage:** KP-01, KP-02.




* **US-07: Verify & Record Handover**
* **Story:** As Sarah, the High-Volume Orchestrator, I want to display the order number for identity verification and record the actual arrival time upon rider arrival, so that I can strictly enforce rider pick-up protocols and ensure a frictionless handoff.


* **Acceptance Criteria:**
* Given a rider arrives, when I view the active order on the tablet, then the order number is prominently displayed for verification.


* Given the rider's identity is verified, when handover is complete, then the system records the rider's actual arrival time.




* **Coverage:** RH-01, RH-02.








* **Epic 3: Issue Resolution & Support**
* **Feature 3.1: Customer Direct Communication**
* **US-08: Access Customer Phone Number**
* **Story:** As David, the Omnipresent Operator, I want the system to display customer phone numbers for active orders, so that I can call them directly to resolve out-of-stock issues rather than using app-chat.


* **Acceptance Criteria:**
* Given an order is active, when I open the issue handling screen, then the customer phone number is displayed in the UI.


* Given an order is completed or cancelled, when `[TBC]` minutes pass, then the system automatically masks or purges the phone number from the tablet UI to maintain GDPR compliance.




* **Coverage:** IH-04, NFR-08.






* **Feature 3.2: Cancellations & Refunds**
* **US-09: Cancel Order & Process Full Refund**
* **Story:** As Sarah, the High-Volume Orchestrator, I want to manually trigger active order cancellations, so that the system automatically processes full order refunds when we cannot fulfill an order.


* **Acceptance Criteria:**
* Given an order is unfulfillable, when I manually trigger a cancellation, then the system cancels the active order immediately.


* Given the order is cancelled, when the backend processes the change, then the system seamlessly initiates a full order refund to the customer.


* Given a network dropout, when I cancel an order and connectivity returns, then the cancellation state queues and syncs fully within `[TBC]` seconds.




* **Coverage:** IH-01, IH-02, NFR-02.




* **US-10: Process Partial Refunds**
* **Story:** As David, the Omnipresent Operator, I want to manually trigger partial order refunds, so that I can quickly compensate customers for missing items over the phone without cancelling the entire ticket.


* **Acceptance Criteria:**
* Given an order has a missing or incorrect item, when I select the specific items to remove, then I can trigger a partial order refund.


* Given I submit a partial refund offline during a localized dropout, when the network restores, then the partial refund state syncs to the backend within `[TBC]` seconds.




* **Coverage:** IH-03, NFR-02.









---

**Uncovered Requirements**
All Functional Requirements (FRs) are successfully mapped to the user stories above. The following Non-Functional Requirements (NFRs) were deliberately excluded from user stories because they represent global architectural guardrails, security compliance policies, or CI/CD pipeline prerequisites rather than actionable software features a manager interacts with:

* **NFR-03 (Security):** The requirement to store `0` payment card data elements (PAN, CVV).


* **NFR-04 (Scalability):** The requirement for the order service to maintain response times under `[TBC]` milliseconds under peak throughput.


* **NFR-06 (Maintainability):** The requirement to block CI/CD pipeline deployments if automated test coverage drops below `> [TBC]%`.


* **NFR-07 (Portability):** The requirement for the application UI to render without clipping on hardware with minimum resolutions of `[TBC]` pixels.