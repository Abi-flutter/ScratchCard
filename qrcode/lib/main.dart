import 'package:flutter/material.dart';
import 'features/guest/guest_home_screen.dart';
import 'features/guest/qr_display_screen.dart';
import 'features/guest/success_screen.dart';
import 'features/host/host_scanner_screen.dart';

void main() => runApp(const GiftApp());

class GiftApp extends StatelessWidget {
  const GiftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', 
      routes: {
  // Use a controller screen as the starting point
  '/': (context) => const GuestHomeScreen(giftId: "GIFT_123"), 
  '/qr_display': (context) => const QRDisplayScreen(qrToken: "TOKEN_ABC"),
  '/host': (context) => const HostScannerScreen(),
  '/success': (context) => const SuccessScreen(),
},
    );
  }
}