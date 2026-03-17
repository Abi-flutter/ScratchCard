import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart'; 
import 'package:share_plus/share_plus.dart';

import '../host/host_scanner_screen.dart'; 

class QRDisplayScreen extends StatelessWidget {
  final String qrToken;
  const QRDisplayScreen({super.key, required this.qrToken});

  @override
  Widget build(BuildContext context) {
    print("--- QR DISPLAY ---");
    print("Displaying QR for Token: $qrToken");
    return Scaffold(
      appBar: AppBar(
      title: const Text("Gift App"),
      actions: [
        IconButton(
          icon: const Icon(Icons.qr_code_scanner),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HostScannerScreen()),
            ), // Go back to Guest Home
        ),
      ],
    ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(padding: const EdgeInsets.all(20), child: Center(child: PrettyQrView.data(data: qrToken))), 
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Share.share("Here is my gift QR: $qrToken"), 
                child: const Text("Share with Family"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}