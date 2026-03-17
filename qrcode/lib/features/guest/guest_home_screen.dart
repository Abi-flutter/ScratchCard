import 'package:flutter/material.dart';
import '../../core/models/gift.dart';
import '../../core/services/gift_service.dart';
import '../../utils/app_constants.dart';
import 'scratch_unlock_screen.dart';
import 'qr_display_screen.dart';

class GuestHomeScreen extends StatefulWidget {
  final String giftId;
  const GuestHomeScreen({super.key, required this.giftId});

  @override
  State<GuestHomeScreen> createState() => _GuestHomeScreenState();
}

class _GuestHomeScreenState extends State<GuestHomeScreen> {
  late Future<Gift> giftFuture;
  Key _refreshKey = UniqueKey();

  void _refreshData() {
    setState(() {
      _refreshKey = UniqueKey();
    });
  }

  @override
  void initState() {
    super.initState();
    // Fetch initial status from backend 
    giftFuture = GiftService().getGiftStatus(widget.giftId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Gift>(
      key: _refreshKey, // Key helps Flutter know when to restart the Future
      future: GiftService().getGiftStatus(widget.giftId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        
        if (snapshot.hasError || !snapshot.hasData) {
          return const Scaffold(body: Center(child: Text("Error loading gift info")));
        }

        final gift = snapshot.data!;

        // Feature 4: Logic to switch UI based on Status 
        switch (gift.status) {
          case GiftStatus.locked:
            return ScratchUnlockScreen(
              giftId: gift.id, 
              onUnlockComplete: _refreshData, // Pass the refresh function
            );          
          case GiftStatus.unlocked:
            return QRDisplayScreen(qrToken: gift.qrToken); // QR visible and share enabled 
          
          case GiftStatus.redeemed:
            return const Scaffold(
              body: Center(child: Text("✅ This gift has already been redeemed.")), // Redeemed confirmation [cite: 26, 28]
            );
        }
      },
    );
  }
}