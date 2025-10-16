import 'package:flutter/material.dart';

class UpiPaymentScreen extends StatelessWidget {
  final Function(String upiMethod, int ticketCount) onPaymentConfirm;

  const UpiPaymentScreen({super.key, required this.onPaymentConfirm});

  @override
  Widget build(BuildContext context) {
    int ticketCount = 1;
    String selectedUpi = "Google Pay";

    return Scaffold(
      appBar: AppBar(title: const Text("Select UPI Method")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedUpi,
              items: ["Google Pay", "PhonePe", "Paytm"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                selectedUpi = value!;
              },
              decoration: const InputDecoration(labelText: "UPI Method"),
            ),
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
                onPaymentConfirm(selectedUpi, ticketCount);
                Navigator.pop(context);
              },
              child: const Text("Confirm Payment"),
            )
          ],
        ),
      ),
    );
  }
}
