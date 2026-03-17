import '../models/gift.dart';
import '../../utils/app_constants.dart';

class GiftService {
  // Simulating a local database/state for the demo
  static Gift _mockGift = Gift(
    id: "GIFT_123",
    eventId: "EVENT_001",
    guestId: "GUEST_999",
    qrToken: "SECURE_TOKEN_2024",
    status: GiftStatus.locked, // Change this to 'unlocked' or 'redeemed' to test other UIs
  );

  Future<Gift> getGiftStatus(String id) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network lag
    return _mockGift;
  }

  Future<void> unlockGift(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Update local mock state
    _mockGift = Gift(
      id: _mockGift.id,
      eventId: _mockGift.eventId,
      guestId: _mockGift.guestId,
      qrToken: _mockGift.qrToken,
      status: GiftStatus.unlocked, // Feature 1.2: Status changes after scratch
      unlockedAt: DateTime.now(),  // Feature 1.2: Recording unlock time
    );
  }

  Future<String> redeemGift(String token, String hostId) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_mockGift.status == GiftStatus.redeemed) {
      return "This gift has already been redeemed."; // Feature 3: Double scan logic
    }
    if (_mockGift.status == GiftStatus.locked) {
      return "QR not yet unlocked."; // Edge Case 2
    }
    
    _mockGift = Gift(
      id: _mockGift.id,
      eventId: _mockGift.eventId,
      guestId: _mockGift.guestId,
      qrToken: _mockGift.qrToken,
      status: GiftStatus.redeemed, // Feature 3: Mark as redeemed
      redeemedAt: DateTime.now(),
      redeemedBy: hostId,
    );
    return "Success";
  }
}