// import 'package:buzbee/home.dart';
// import 'package:buzbee/qr.dart';
// import 'package:buzbee/upi.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class BookTicketScreen extends StatefulWidget {
//   const BookTicketScreen({super.key});

//   @override
//   State<BookTicketScreen> createState() => _BookTicketScreenState();
// }

// class _BookTicketScreenState extends State<BookTicketScreen> {
//   static const Color primaryColor = Color(0xFFF07B11);

//   String? selectedSource;
//   String? selectedDestination;
//   DateTime? selectedDate;
//   int? selectedBusId;

//   double walletBalance = 100.0;

//   final List<Map<String, dynamic>> buses = [
//     {
//       'id': 1,
//       'source': 'Manjeri',
//       'destination': 'Kozhikode',
//       'stops': ['Manjeri', 'Kottakkal', 'Ramanattukara', 'Kozhikode'],
//       'time': '08:00 AM',
//       'bus': 'Bus A',
//       'number': 'KL-01-A-1234',
//       'price': 150.0,
//     },
//     {
//       'id': 2,
//       'source': 'Manjeri',
//       'destination': 'Kozhikode',
//       'stops': ['Manjeri', 'Areekode', 'Feroke', 'Kozhikode'],
//       'time': '09:00 AM',
//       'bus': 'Bus B',
//       'number': 'KL-01-B-5678',
//       'price': 150.0,
//     },
//     {
//       'id': 3,
//       'source': 'Areekode',
//       'destination': 'Malappuram',
//       'stops': ['Areekode', 'Manjeri', 'Malappuram'],
//       'time': '10:00 AM',
//       'bus': 'Bus C',
//       'number': 'KL-02-C-9012',
//       'price': 100.0,
//     },
//   ];

//   // Get unique sources
//   List<String> get uniqueSources =>
//       buses.map((bus) => bus['source'] as String).toSet().toList();

//   // Get destination options based on selected source
//   List<String> get destinationsForSelectedSource {
//     if (selectedSource == null) return [];
//     return buses
//         .where((bus) => bus['source'] == selectedSource)
//         .map((bus) => bus['destination'] as String)
//         .toSet()
//         .toList();
//   }

//   // Filter buses based on selections
//   List<Map<String, dynamic>> get availableBuses {
//     if (selectedSource == null ||
//         selectedDestination == null ||
//         selectedDate == null) return [];
//     return buses.where((bus) =>
//         bus['source'] == selectedSource &&
//         bus['destination'] == selectedDestination).toList();
//   }

//   // Get selected bus
//   Map<String, dynamic>? get selectedBus {
//     if (selectedBusId == null) return null;
//     return buses.firstWhere(
//       (bus) => bus['id'] == selectedBusId,
//       orElse: () => {},
//     );
//   }

//   // Pick date
//   Future<void> pickDate() async {
//     final now = DateTime.now();
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? now,
//       firstDate: now,
//       lastDate: now.add(const Duration(days: 30)),
//     );
//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//         selectedBusId = null;
//       });
//     }
//   }

//   // Prompt for ticket count
//   // void _askTicketCountAndBook(String method) {
//   //   final controller = TextEditingController();
//   //   showDialog(
//   //     context: context,
//   //     builder: (_) => AlertDialog(
//   //       title: const Text("Number of Tickets"),
//   //       content: TextField(
//   //         controller: controller,
//   //         keyboardType: TextInputType.number,
//   //         decoration: const InputDecoration(hintText: "Enter number of tickets"),
//   //       ),
//   //       actions: [
//   //         TextButton(
//   //           onPressed: () {
//   //             final input = int.tryParse(controller.text.trim());
//   //             if (input == null || input <= 0) {
//   //               ScaffoldMessenger.of(context).showSnackBar(
//   //                 const SnackBar(content: Text("Enter a valid number")),
//   //               );
//   //               return;
//   //             }
//   //             Navigator.pop(context);
//   //             _bookTicket(method, input);
//   //           },
//   //           child: const Text("Continue"),
//   //         )
//   //       ],
//   //     ),
//   //   );
//   // }
//   void _askTicketCountAndBook(String method) {
//   final controller = TextEditingController();

//   showDialog(
//     context: context,
//     builder: (_) => AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       title: const Text(
//         "Number of Tickets",
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 10),
//           TextField(
//             controller: controller,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               hintText: "Enter number of tickets",
//               filled: true,
//               fillColor: Colors.grey[100],
//               contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 16, vertical: 14),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text(
//             "Cancel",
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: MyApp.primaryColor,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           onPressed: () {
//             final input = int.tryParse(controller.text.trim());

//             if (input == null || input <= 0) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                     content: Text("Enter a valid number")),
//               );
//               return;
//             }

//             Navigator.pop(context);
//             _bookTicket(method, input);
//           },
//           child: const Text("Continue"),
//         ),
//       ],
//     ),
//   );
// }

//   // Book ticket logic
//   void _bookTicket(String method, int count) {
//     if (selectedBus == null) return;

//     final price = selectedBus!['price'] as double;
//     final total = price * count;

//     if (method == "Wallet" && walletBalance < total) {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: const Text("Insufficient Balance"),
//           content: Text(
//               "Wallet balance is ₹${walletBalance.toStringAsFixed(2)}, but total is ₹${total.toStringAsFixed(2)}"),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("OK"),
//             )
//           ],
//         ),
//       );
//       return;
//     }

//     if (method == "Wallet") {
//       walletBalance -= total;
//     }

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Ticket Booked!"),
//         content: Text(
//           "Bus: ${selectedBus!['bus']}\n"
//           "Time: ${selectedBus!['time']}\n"
//           "Date: ${DateFormat('dd MMM yyyy').format(selectedDate!)}\n"
//           "Tickets: $count\n"
//           "Payment: $method\n"
//           "Total: ₹${total.toStringAsFixed(2)}",
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           )
//         ],
//       ),
//     );
//   }

//   // Payment button widget
//   Widget _paymentButton(String method) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 4),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.white,
//             foregroundColor: primaryColor,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             side: const BorderSide(color: primaryColor),
//             minimumSize: const Size.fromHeight(50),
//           ),
//           onPressed: () {
//             if (method == "Wallet") {
//               _askTicketCountAndBook(method);
//             } else if (method == "UPI") {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => UpiPaymentScreen(
//                     onPaymentConfirm: (upiMethod, count) {
//                       _bookTicket("UPI - $upiMethod", count);
//                     },
//                   ),
//                 ),
//               );
//             } else if (method == "QR") {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => QrPaymentScreen(
//                     onQrScanned: (count) {
//                       _bookTicket("QR Code", count);
//                     },
//                   ),
//                 ),
//               );
//             }
//           },
//           child: Text(
//             method == "Wallet"
//                 ? "$method (₹${walletBalance.toStringAsFixed(2)})"
//                 : method,
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text("Book Ticket"),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [primaryColor, Colors.orangeAccent],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Source Dropdown
//             DropdownButtonFormField<String>(
//               value: selectedSource,
//               items: uniqueSources
//                   .map((src) => DropdownMenuItem(value: src, child: Text(src)))
//                   .toList(),
//               onChanged: (val) {
//                 setState(() {
//                   selectedSource = val;
//                   selectedDestination = null;
//                   selectedDate = null;
//                   selectedBusId = null;
//                 });
//               },
//               decoration: _dropdownDecoration("Select Source"),
//             ),
//             const SizedBox(height: 16),

//             // Destination Dropdown
//             if (selectedSource != null)
//               DropdownButtonFormField<String>(
//                 value: selectedDestination,
//                 items: destinationsForSelectedSource
//                     .map((dest) =>
//                         DropdownMenuItem(value: dest, child: Text(dest)))
//                     .toList(),
//                 onChanged: (val) {
//                   setState(() {
//                     selectedDestination = val;
//                     selectedDate = null;
//                     selectedBusId = null;
//                   });
//                 },
//                 decoration: _dropdownDecoration("Select Destination"),
//               ),
//             const SizedBox(height: 16),

//             // Date Picker
//             if (selectedDestination != null)
//               GestureDetector(
//                 onTap: pickDate,
//                 child: Container(
//                   width: double.infinity,
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: Text(
//                     selectedDate == null
//                         ? "Select Date"
//                         : DateFormat('dd MMM yyyy').format(selectedDate!),
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: selectedDate == null ? Colors.grey : Colors.black,
//                     ),
//                   ),
//                 ),
//               ),

//             const SizedBox(height: 20),

//             // Available Buses
//             if (availableBuses.isNotEmpty)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Available Buses",
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[800])),
//                   const SizedBox(height: 10),
//                   ...availableBuses.map((bus) {
//                     final isSelected = selectedBusId == bus['id'];
//                     return GestureDetector(
//                       onTap: () => setState(() {
//                         selectedBusId = bus['id'] as int;
//                       }),
//                       child: Card(
//                         color: isSelected ? Colors.orange[100] : Colors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16)),
//                         elevation: 4,
//                         child: ListTile(
//                           leading: const Icon(Icons.directions_bus,
//                               color: primaryColor),
//                           title: Text("${bus['bus']} - ${bus['time']}"),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Bus No: ${bus['number']}"),
//                               Text(
//                                   "Stops: ${(bus['stops'] as List<String>).join(', ')}"),
//                               Text("Price: ₹${bus['price']}"),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ],
//               ),
//             const SizedBox(height: 20),

//             // Payment Methods
//             if (selectedBus != null)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Select Payment Method",
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[800])),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       _paymentButton("Wallet"),
//                       _paymentButton("UPI"),
//                       _paymentButton("QR"),
//                     ],
//                   )
//                 ],
//               ),
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }

//   InputDecoration _dropdownDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: Colors.white,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
// }

// import 'package:buzbee/home.dart';
// import 'package:buzbee/qr.dart';
// import 'package:buzbee/upi.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class BookTicketScreen extends StatefulWidget {
//   const BookTicketScreen({super.key});

//   @override
//   State<BookTicketScreen> createState() => _BookTicketScreenState();
// }

// class _BookTicketScreenState extends State<BookTicketScreen> {
//   static const Color primaryColor = Color(0xFFF07B11);

//   String? selectedSource;
//   String? selectedDestination;
//   DateTime? selectedDate;
//   int? selectedBusId;

//   double walletBalance = 100.0;

//   final TextEditingController sourceController = TextEditingController();
//   final TextEditingController destinationController = TextEditingController();

//   final List<Map<String, dynamic>> buses = [
//     {
//       'id': 1,
//       'source': 'Manjeri',
//       'destination': 'Kozhikode',
//       'stops': ['Manjeri', 'Kottakkal', 'Ramanattukara', 'Kozhikode'],
//       'time': '08:00 AM',
//       'bus': 'Bus A',
//       'number': 'KL-01-A-1234',
//       'price': 150.0,
//     },
//     {
//       'id': 2,
//       'source': 'Manjeri',
//       'destination': 'Kozhikode',
//       'stops': ['Manjeri', 'Areekode', 'Feroke', 'Kozhikode'],
//       'time': '09:00 AM',
//       'bus': 'Bus B',
//       'number': 'KL-01-B-5678',
//       'price': 150.0,
//     },
//     {
//       'id': 3,
//       'source': 'Areekode',
//       'destination': 'Malappuram',
//       'stops': ['Areekode', 'Manjeri', 'Malappuram'],
//       'time': '10:00 AM',
//       'bus': 'Bus C',
//       'number': 'KL-02-C-9012',
//       'price': 100.0,
//     },
//   ];

//   // Filter logic updated for search
//   List<Map<String, dynamic>> get availableBuses {
//     if (selectedSource == null ||
//         selectedDestination == null ||
//         selectedSource!.isEmpty ||
//         selectedDestination!.isEmpty ||
//         selectedDate == null) return [];

//     final src = selectedSource!.toLowerCase();
//     final dest = selectedDestination!.toLowerCase();

//     return buses.where((bus) =>
//         bus['source'].toLowerCase().contains(src) &&
//         bus['destination'].toLowerCase().contains(dest)).toList();
//   }

//   Map<String, dynamic>? get selectedBus {
//     if (selectedBusId == null) return null;
//     return buses.firstWhere(
//       (bus) => bus['id'] == selectedBusId,
//       orElse: () => {},
//     );
//   }

//   Future<void> pickDate() async {
//     final now = DateTime.now();
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? now,
//       firstDate: now,
//       lastDate: now.add(const Duration(days: 30)),
//     );
//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//         selectedBusId = null;
//       });
//     }
//   }

//   void _askTicketCountAndBook(String method) {
//     final controller = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         title: const Text("Number of Tickets",
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         content: TextField(
//           controller: controller,
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//             hintText: "Enter number of tickets",
//             filled: true,
//             fillColor: Colors.grey[100],
//             contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 16, vertical: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: MyApp.primaryColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             onPressed: () {
//               final count = int.tryParse(controller.text.trim());

//               if (count == null || count <= 0) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("Enter a valid number")),
//                 );
//                 return;
//               }

//               Navigator.pop(context);
//               _bookTicket(method, count);
//             },
//             child: const Text("Continue"),
//           ),
//         ],
//       ),
//     );
//   }

//   void _bookTicket(String method, int count) {
//     if (selectedBus == null) return;

//     final price = selectedBus!['price'] as double;
//     final total = price * count;

//     if (method == "Wallet" && walletBalance < total) {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: const Text("Insufficient Balance"),
//           content: Text(
//               "Wallet balance: ₹${walletBalance.toStringAsFixed(2)}\nRequired: ₹${total.toStringAsFixed(2)}"),
//           actions: [
//             TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text("OK")),
//           ],
//         ),
//       );
//       return;
//     }

//     if (method == "Wallet") walletBalance -= total;

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Ticket Booked!"),
//         content: Text(
//           "Bus: ${selectedBus!['bus']}\n"
//           "Time: ${selectedBus!['time']}\n"
//           "Date: ${DateFormat('dd MMM yyyy').format(selectedDate!)}\n"
//           "Payment: $method\n"
//           "Tickets: $count\n"
//           "Total: ₹${total.toStringAsFixed(2)}",
//         ),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("OK")),
//         ],
//       ),
//     );
//   }

//   Widget _paymentButton(String method) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 4),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.white,
//             foregroundColor: primaryColor,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             side: const BorderSide(color: primaryColor),
//             minimumSize: const Size.fromHeight(50),
//           ),
//           onPressed: () {
//             if (method == "Wallet") {
//               _askTicketCountAndBook("Wallet");
//             } else if (method == "UPI") {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => UpiPaymentScreen(
//                     onPaymentConfirm: (upi, count) {
//                       _bookTicket("UPI - $upi", count);
//                     },
//                   ),
//                 ),
//               );
//             } else if (method == "QR") {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => QrPaymentScreen(
//                     onQrScanned: (count) {
//                       _bookTicket("QR Code", count);
//                     },
//                   ),
//                 ),
//               );
//             }
//           },
//           child: Text(
//             method == "Wallet"
//                 ? "$method (₹${walletBalance.toStringAsFixed(2)})"
//                 : method,
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text("Book Ticket"),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [primaryColor, Colors.orangeAccent],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // INPUTS
//             TextField(
//               controller: sourceController,
//               onChanged: (value) {
//                 setState(() {
//                   selectedSource = value.trim();
//                   destinationController.clear();
//                   selectedDestination = null;
//                   selectedDate = null;
//                   selectedBusId = null;
//                 });
//               },
//               decoration: _dropdownDecoration("Search Source"),
//             ),
//             const SizedBox(height: 16),

//             if (selectedSource != null && selectedSource!.isNotEmpty)
//               TextField(
//                 controller: destinationController,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedDestination = value.trim();
//                     selectedDate = null;
//                     selectedBusId = null;
//                   });
//                 },
//                 decoration: _dropdownDecoration("Search Destination"),
//               ),
//             const SizedBox(height: 16),

//             if (selectedDestination != null &&
//                 selectedDestination!.isNotEmpty)
//               GestureDetector(
//                 onTap: pickDate,
//                 child: Container(
//                   width: double.infinity,
//                   padding:
//                   const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: Text(
//                     selectedDate == null
//                         ? "Select Date"
//                         : DateFormat('dd MMM yyyy').format(selectedDate!),
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: selectedDate == null ? Colors.grey : Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             const SizedBox(height: 20),

//             // Matching Buses + No bus message
//             if (selectedDate != null)
//               Column(
//                 children: [
//                   if (availableBuses.isNotEmpty)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Matching Buses",
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey[800])),
//                         const SizedBox(height: 10),
//                         ...availableBuses.map((bus) {
//                           final isSelected = selectedBusId == bus['id'];
//                           return GestureDetector(
//                             onTap: () => setState(() {
//                               selectedBusId = bus['id'];
//                             }),
//                             child: Card(
//                               color: isSelected
//                                   ? Colors.orange[100]
//                                   : Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               elevation: 3,
//                               margin: const EdgeInsets.only(bottom: 10),
//                               child: ListTile(
//                                 leading: const Icon(Icons.directions_bus,
//                                     color: primaryColor),
//                                 title: Text("${bus['bus']} - ${bus['time']}"),
//                                 subtitle: Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Bus No: ${bus['number']}"),
//                                     Text(
//                                         "Stops: ${(bus['stops'] as List).join(', ')}"),
//                                     Text("Price: ₹${bus['price']}"),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                       ],
//                     )
//                   else
//                     const Center(
//                       child: Text(
//                         "No buses match the search",
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),

//             const SizedBox(height: 20),

//             if (selectedBus != null)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Select Payment Method",
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[800])),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       _paymentButton("Wallet"),
//                       _paymentButton("UPI"),
//                       _paymentButton("QR"),
//                     ],
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   InputDecoration _dropdownDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: Colors.white,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
// }

import 'package:buzbee/API/registerAPI.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'bus_list_screen.dart';

class SearchBusStopScreen extends StatefulWidget {
  const SearchBusStopScreen({super.key});

  @override
  State<SearchBusStopScreen> createState() => _SearchBusStopScreenState();
}

class _SearchBusStopScreenState extends State<SearchBusStopScreen> {
  static const Color primaryColor = Color(0xFFF07B11);

  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> busRoutes = [];

  final Dio dio = Dio();

  /// 🔎 API 1: Fetch Routes Based On Stop Search
  Future<void> fetchBusStops(String keyword) async {
    if (keyword.isEmpty) {
      setState(() => busRoutes.clear());
      return;
    }

    try {
      final response = await dio.get(
        "$baseurl/FetchRoutesByStop",
        queryParameters: {"Stopname": keyword},
      );

      print("Fetched Routes → ${response.data}");

      if (response.statusCode == 200) {
        setState(() {
          busRoutes = List<Map<String, dynamic>>.from(
            response.data["routes"] ?? [],
          );
        });
      }
    } catch (e) {
      print("⚠️ Error fetching bus stops: $e");
    }
  }

  /// 🚍 API 2: Fetch Bus Details Using Route ID
  Future<void> fetchBuses(int routeId) async {
    try {
      final response = await dio.get("$baseurl/ViewBusByRoute/$routeId");

      print("Fetched Buses → ${response.data}");

      // Convert to List of Maps
      List<Map<String, dynamic>> buses =
          List<Map<String, dynamic>>.from(response.data ?? []);

      // Navigate to bus screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BusListScreen(buses: buses),
        ),
      );
    } catch (e) {
      print("⚠️ Error fetching buses: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Search Bus Route"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: fetchBusStops,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: primaryColor),
                hintText: "Search by stop name",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: busRoutes.isEmpty
                  ? const Center(
                      child: Text("Type to search bus routes",
                          style: TextStyle(color: Colors.grey)),
                    )
                  : ListView.separated(
                      itemCount: busRoutes.length,
                      separatorBuilder: (_, __) =>
                          const Divider(height: 1, color: Colors.black12),
                      itemBuilder: (context, index) {
                        final route = busRoutes[index];
                        final id = route["id"];
                        final src = route["Source"];
                        final dest = route["Destination"];

                        return ListTile(
                          leading: const Icon(Icons.directions_bus,
                              color: primaryColor),
                          title: Text("$src → $dest"),
                          subtitle: Text("Route ID: $id"),
                          onTap: () {
                            fetchBuses(id);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Selected Route: $src → $dest"),
                                backgroundColor: primaryColor,
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:buzbee/API/registerAPI.dart';
// import 'package:flutter/mater

class BusListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> buses;

  const BusListScreen({super.key, required this.buses});

  @override
  State<BusListScreen> createState() => _BusListScreenState();
}

class _BusListScreenState extends State<BusListScreen> {
  static const Color primaryColor = Color(0xFFF07B11);

  double walletBalance = 200.0; // user wallet for demo

  Map<String, dynamic>? selectedBus;
  DateTime? selectedDate;

  /// Pick travel date
  Future<void> pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  /// Ask ticket count before payment method
  void askTicketCount(String method) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Number of Tickets"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: "Enter ticket count",
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              final count = int.tryParse(controller.text.trim()) ?? 0;
              if (count <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Enter valid number")),
                );
                return;
              }

              Navigator.pop(context);
              bookTicket(method, count);
            },
            child: const Text("Continue"),
          )
        ],
      ),
    );
  }

  /// Book Ticket Logic
  void bookTicket(String method, int count) {
    if (selectedBus == null || selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select date first")),
      );
      return;
    }

    final price = 80.0; // Default price (your DB may have)
    final total = price * count;

    if (method == "Wallet" && walletBalance < total) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Insufficient Wallet Balance"),
          content: Text(
              "Your balance: ₹${walletBalance.toStringAsFixed(2)}\nRequired: ₹${total.toStringAsFixed(2)}"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
          ],
        ),
      );
      return;
    }

    if (method == "Wallet") {
      setState(() => walletBalance -= total);
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Ticket Booked!"),
        content: Text(
          "Bus: ${selectedBus!['bus_name']}\n"
          "Bus No: ${selectedBus!['bus_no']}\n"
          "Date: ${DateFormat('dd MMM yyyy').format(selectedDate!)}\n"
          "Payment: $method\n"
          "Tickets: $count\n"
          "Total: ₹${total.toStringAsFixed(2)}",
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Buses"),
        backgroundColor: primaryColor,
      ),
      body: widget.buses.isEmpty
          ? const Center(child: Text("No buses found"))
          : ListView.builder(
              itemCount: widget.buses.length,
              itemBuilder: (context, index) {
                final bus = widget.buses[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage("$baseurl${bus['bus_Photo']}"),
                        ),
                        title: Text(
                          bus["bus_name"] ?? "Bus",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Bus No: ${bus['bus_no']}\n"
                          "Start: ${bus['Start_Time']} → End: ${bus['End_Time']}",
                        ),
                      ),

                      /// SELECT DATE BUTTON
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: primaryColor,
                          ),
                          onPressed: () async {
                            selectedBus = bus;
                            await pickDate(context);
                            setState(() {});
                          },
                          child: Text(
                            selectedDate == null
                                ? "Select Date"
                                : "Date: ${DateFormat('dd MMM yyyy').format(selectedDate!)}",
                          ),
                        ),
                      ),

                      /// PAYMENT BUTTONS AFTER DATE SELECTED
                      if (selectedBus != null && selectedBus == bus && selectedDate != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                  ),
                                  onPressed: () => askTicketCount("Wallet"),
                                  child: Text("Wallet (₹${walletBalance.toStringAsFixed(2)})"),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: () => askTicketCount("UPI"),
                                  child: const Text("UPI"),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  onPressed: () => askTicketCount("QR"),
                                  child: const Text("QR Code"),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
