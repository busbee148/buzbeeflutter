// import 'package:flutter/material.dart';

// class QrPaymentScreen extends StatelessWidget {
//   final Function(int ticketCount) onQrScanned;

//   const QrPaymentScreen({super.key, required this.onQrScanned});

//   @override
//   Widget build(BuildContext context) {
//     int ticketCount = 1;

//     return Scaffold(
//       appBar: AppBar(title: const Text("Scan QR Code")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const Icon(Icons.qr_code_scanner, size: 150),
//             const SizedBox(height: 20),
//             TextField(
//               decoration: const InputDecoration(
//                   labelText: "Number of Tickets", border: OutlineInputBorder()),
//               keyboardType: TextInputType.number,
//               onChanged: (val) {
//                 ticketCount = int.tryParse(val) ?? 1;
//               },
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 onQrScanned(ticketCount);
//                 Navigator.pop(context);
//               },
//               child: const Text("Simulate Scan & Pay"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:buzbee/main.dart'; // for MyApp.primaryColor

class QrPaymentScreen extends StatelessWidget {
  final Function(int ticketCount) onQrScanned;

  const QrPaymentScreen({super.key, required this.onQrScanned});

  @override
  Widget build(BuildContext context) {
    int ticketCount = 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
        backgroundColor: MyApp.primaryColor,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // QR Scanner Icon with card background
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: const Icon(
                Icons.qr_code_scanner,
                size: 150,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 30),

            // Ticket input box
            TextField(
              decoration: InputDecoration(
                labelText: "Number of Tickets",
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                ticketCount = int.tryParse(val) ?? 1;
              },
            ),

            const SizedBox(height: 30),

            // Scan & Pay Button (Orange theme)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyApp.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  onQrScanned(ticketCount);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Stimulate Scan & Pay",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
