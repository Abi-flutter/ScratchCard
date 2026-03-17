import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../core/services/gift_service.dart';

class HostScannerScreen extends StatefulWidget {
  const HostScannerScreen({super.key});

  @override
  State<HostScannerScreen> createState() => _HostScannerScreenState();
}

class _HostScannerScreenState extends State<HostScannerScreen> {
  bool isScanning = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Host: Scan Gift QR")),
      body: MobileScanner(
        onDetect: (capture) async {
          final code = capture.barcodes.first.rawValue;
  if (code != null) {
    print("--- HOST SCANNER ---");
    print("Scanned Token: $code");
    
    final result = await GiftService().redeemGift(code, "HOST_123");
    
    print("Backend Response: $result"); 
    // This will show "Success" or "This gift has already been redeemed" [cite: 26]
  }
          if (!isScanning) return; // Prevent multiple scans at once
          
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
            setState(() => isScanning = false); // Pause scanner
            
            final String qrToken = barcodes.first.rawValue!;
            
            // Feature 2.2 & 2.3: Validate with backend and mark as redeemed
            final resultMessage = await GiftService().redeemGift(qrToken, "HOST_ID_001");

            if (!mounted) return;

            // Feature 3: Display status message
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(resultMessage == "Success" ? "Redeemed" : "Alert"),
                content: Text(resultMessage == "Success" 
                  ? "Gift marked as redeemed successfully!" 
                  : resultMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() => isScanning = true); // Resume scanner
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}