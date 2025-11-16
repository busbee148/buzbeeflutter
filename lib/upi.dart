// import 'package:flutter/material.dart';
// import 'package:buzbee/main.dart'; // for MyApp.primaryColor

// class UpiPaymentScreen extends StatelessWidget {
//   final Function(String upiMethod, int ticketCount) onPaymentConfirm;

//   const UpiPaymentScreen({super.key, required this.onPaymentConfirm});

//   @override
//   Widget build(BuildContext context) {
//     int ticketCount = 1;
//     String selectedUpi = "Google Pay";

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Select UPI Method"),
//         backgroundColor: MyApp.primaryColor,
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 10),

//             // UPI Selection Card
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 8,
//                     offset: Offset(0, 4),
//                   )
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Choose UPI App",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 12),

//                   DropdownButtonFormField<String>(
//                     value: selectedUpi,
//                     items: ["Google Pay", "PhonePe", "Paytm"]
//                         .map((e) => DropdownMenuItem(
//                               value: e,
//                               child: Text(e),
//                             ))
//                         .toList(),
//                     onChanged: (value) {
//                       selectedUpi = value!;
//                     },
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 14),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(14),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 25),

//             // Ticket count input
//             TextField(
//               decoration: InputDecoration(
//                 labelText: "Number of Tickets",
//                 filled: true,
//                 fillColor: Colors.grey[100],
//                 contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 16, vertical: 14),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//               keyboardType: TextInputType.number,
//               onChanged: (val) {
//                 ticketCount = int.tryParse(val) ?? 1;
//               },
//             ),

//             const SizedBox(height: 30),

//             // Submit button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: MyApp.primaryColor,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onPressed: () {
//                   onPaymentConfirm(selectedUpi, ticketCount);
//                   Navigator.pop(context);
//                 },
//                 child: const Text(
//                   "Confirm Payment",
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:buzbee/home.dart';
import 'package:flutter/material.dart';
import 'package:buzbee/main.dart' hide MyApp;

class UpiPaymentScreen extends StatefulWidget {
  final Function(String upiMethod, int ticketCount) onPaymentConfirm;

  const UpiPaymentScreen({super.key, required this.onPaymentConfirm});

  @override
  State<UpiPaymentScreen> createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> {
  int ticketCount = 1;
  String selectedUpi = "Google Pay";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select UPI Method"),
        backgroundColor: MyApp.primaryColor,
      ),

      body: SingleChildScrollView(   // <-- FIXED OVERFLOW
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // ---- UPI Selection Card ----
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Choose UPI App",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ---- Radio Buttons ----
                    RadioListTile(
                      value: "Google Pay",
                      groupValue: selectedUpi,
                      activeColor: MyApp.primaryColor,
                      title: const Text("Google Pay"),
                      onChanged: (value) {
                        setState(() => selectedUpi = value!);
                      },
                    ),

                    RadioListTile(
                      value: "PhonePe",
                      groupValue: selectedUpi,
                      activeColor: MyApp.primaryColor,
                      title: const Text("PhonePe"),
                      onChanged: (value) {
                        setState(() => selectedUpi = value!);
                      },
                    ),

                    RadioListTile(
                      value: "Paytm",
                      groupValue: selectedUpi,
                      activeColor: MyApp.primaryColor,
                      title: const Text("Paytm"),
                      onChanged: (value) {
                        setState(() => selectedUpi = value!);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ---- Ticket Count Input ----
              TextField(
                decoration: InputDecoration(
                  labelText: "Number of Tickets",
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
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

              // ---- Submit Button ----
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
                    // Call parent function
                    widget.onPaymentConfirm(selectedUpi, ticketCount);

                    // Navigate to success screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PaymentSuccessScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Confirm Payment",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {

  @override
  void initState() {
    super.initState();

    // Auto navigation after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const PassengerHomePage()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 120,
                color: MyApp.primaryColor,
              ),
              const SizedBox(height: 20),

              const Text(
                "Payment Successful!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Your tickets have been booked.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Redirecting to home...",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
