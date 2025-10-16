import 'package:flutter/material.dart';

class QrPaymentScreen extends StatelessWidget {
  final Function(int ticketCount) onQrScanned;

  const QrPaymentScreen({super.key, required this.onQrScanned});

  @override
  Widget build(BuildContext context) {
    int ticketCount = 1;

    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR Code")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.qr_code_scanner, size: 150),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                  labelText: "Number of Tickets", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                ticketCount = int.tryParse(val) ?? 1;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onQrScanned(ticketCount);
                Navigator.pop(context);
              },
              child: const Text("Simulate Scan & Pay"),
            )
          ],
        ),
      ),
    );
  }
}
