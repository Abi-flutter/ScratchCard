📜 QR Scratch & Redeem System
A Flutter application featuring a secure, two-step gift redemption process. The app handles the complete lifecycle of a digital gift: from a hidden scratch card to a one-time-use QR code.

🚀 Key Features
1. Guest Experience (Scratch to Reveal)
Scratch Card UI: Gifts are initially "Locked" and hidden behind a scratchable surface.

Threshold Detection: The QR code is revealed only after 50% of the surface is scratched.

Time Tracking: The exact moment of the "Unlock" action is recorded and sent to the backend.

2. Host Experience (QR Scanner)
Camera Integration: A dedicated Host mode using mobile_scanner to read guest QR tokens.

Instant Validation: The system checks the backend to ensure the QR is both Unlocked and Not Yet Redeemed.

3. Advanced Security Logic
Single-Use Only: Once a Host scans a QR, the status updates to "Redeemed." Any further scan attempts return an "Already Redeemed" error.

Sequence Enforcement: Prevents Hosts from scanning a QR if the Guest hasn't scratched the card yet.

🛠 Tech Stack
Frontend: Flutter (Dart)

State Management: setState with FutureBuilder for dynamic UI updates.

Scanning: mobile_scanner for high-speed QR detection.

Animations: scratcher package for the scratch-to-reveal effect.

📸 Project Flow
LOCKED: Guest sees a gray scratch card.

UNLOCKED: Guest scratches the card; unlocked_at timestamp is saved; QR is displayed.

REDEEMED: Host scans the QR; redeemed_at timestamp is saved; QR becomes invalid.

🚦 How to Run & Test
Prerequisites
Flutter SDK installed.

An Android/iOS device (for camera functionality).

Testing on a Single Device
Launch the app and enter Guest Mode.

Scratch the card to reveal the QR code.

Take a screenshot of the QR code and send it to a computer screen.

Navigate to Host Mode within the app.

Point your phone camera at the computer screen to scan the screenshot.

Observe the console logs for Backend Response: Success.

📄 API / Backend Simulation
The app interacts with a GiftService that manages the following states:
| Status | Meaning |
| :--- | :--- |
| locked | Initial state; scratch card visible. |
| unlocked | Scratched; QR visible; timestamp recorded. |
| redeemed | Scanned by host; gift finalized; QR disabled. |
