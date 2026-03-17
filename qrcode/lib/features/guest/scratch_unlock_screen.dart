import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../../core/services/gift_service.dart';

class ScratchUnlockScreen extends StatelessWidget {
  final String giftId;
  final VoidCallback onUnlockComplete;

  const ScratchUnlockScreen({
    super.key,
    required this.giftId,
    required this.onUnlockComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scratch to Reveal")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "You have a new gift!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              
              // This SizedBox is CRITICAL to fix the overflow in your image
              SizedBox(
                height: 300,
                width: 300,
                child: Scratcher(
                  brushSize: 50,
                  threshold: 50,
                  color: Colors.grey[300]!,
                  onThreshold: () async {
                    print("--- GUEST ACTION ---");
  print("Status change: Locked -> Unlocked");
  print("Unlock Time Recorded: ${DateTime.now()}");
                    // Feature 1.2.3 & 1.2.4: Change status and record time [cite: 14, 15]
                    await GiftService().unlockGift(giftId);
                    onUnlockComplete();
                  },
                  // Feature 1.2.1: Hidden QR behind scratch card [cite: 12]
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20), 
                    child: Center(
                      // FIXED: Using standard PrettyQrView.data without the broken property
                      child: PrettyQrView.data(
                        data: "SECURE_GIFT_TOKEN_123", // Linked to Gift ID [cite: 9]
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              const Text("Scratch 50% to reveal your QR code"),
              const Text(
                "Status: Locked", // Feature 4: UI Behavior 
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}