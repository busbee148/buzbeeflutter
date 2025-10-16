import 'package:buzbee/qr.dart';
import 'package:buzbee/upi.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookTicketScreen extends StatefulWidget {
  const BookTicketScreen({super.key});

  @override
  State<BookTicketScreen> createState() => _BookTicketScreenState();
}

class _BookTicketScreenState extends State<BookTicketScreen> {
  static const Color primaryColor = Color(0xFFF07B11);

  String? selectedSource;
  String? selectedDestination;
  DateTime? selectedDate;
  int? selectedBusId;

  double walletBalance = 100.0;

  final List<Map<String, dynamic>> buses = [
    {
      'id': 1,
      'source': 'Manjeri',
      'destination': 'Kozhikode',
      'stops': ['Manjeri', 'Kottakkal', 'Ramanattukara', 'Kozhikode'],
      'time': '08:00 AM',
      'bus': 'Bus A',
      'number': 'KL-01-A-1234',
      'price': 150.0,
    },
    {
      'id': 2,
      'source': 'Manjeri',
      'destination': 'Kozhikode',
      'stops': ['Manjeri', 'Areekode', 'Feroke', 'Kozhikode'],
      'time': '09:00 AM',
      'bus': 'Bus B',
      'number': 'KL-01-B-5678',
      'price': 150.0,
    },
    {
      'id': 3,
      'source': 'Areekode',
      'destination': 'Malappuram',
      'stops': ['Areekode', 'Manjeri', 'Malappuram'],
      'time': '10:00 AM',
      'bus': 'Bus C',
      'number': 'KL-02-C-9012',
      'price': 100.0,
    },
  ];

  // Get unique sources
  List<String> get uniqueSources =>
      buses.map((bus) => bus['source'] as String).toSet().toList();

  // Get destination options based on selected source
  List<String> get destinationsForSelectedSource {
    if (selectedSource == null) return [];
    return buses
        .where((bus) => bus['source'] == selectedSource)
        .map((bus) => bus['destination'] as String)
        .toSet()
        .toList();
  }

  // Filter buses based on selections
  List<Map<String, dynamic>> get availableBuses {
    if (selectedSource == null ||
        selectedDestination == null ||
        selectedDate == null) return [];
    return buses.where((bus) =>
        bus['source'] == selectedSource &&
        bus['destination'] == selectedDestination).toList();
  }

  // Get selected bus
  Map<String, dynamic>? get selectedBus {
    if (selectedBusId == null) return null;
    return buses.firstWhere(
      (bus) => bus['id'] == selectedBusId,
      orElse: () => {},
    );
  }

  // Pick date
  Future<void> pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedBusId = null;
      });
    }
  }

  // Prompt for ticket count
  void _askTicketCountAndBook(String method) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Number of Tickets"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Enter number of tickets"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final input = int.tryParse(controller.text.trim());
              if (input == null || input <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Enter a valid number")),
                );
                return;
              }
              Navigator.pop(context);
              _bookTicket(method, input);
            },
            child: const Text("Continue"),
          )
        ],
      ),
    );
  }

  // Book ticket logic
  void _bookTicket(String method, int count) {
    if (selectedBus == null) return;

    final price = selectedBus!['price'] as double;
    final total = price * count;

    if (method == "Wallet" && walletBalance < total) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Insufficient Balance"),
          content: Text(
              "Wallet balance is ₹${walletBalance.toStringAsFixed(2)}, but total is ₹${total.toStringAsFixed(2)}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
      return;
    }

    if (method == "Wallet") {
      walletBalance -= total;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Ticket Booked!"),
        content: Text(
          "Bus: ${selectedBus!['bus']}\n"
          "Time: ${selectedBus!['time']}\n"
          "Date: ${DateFormat('dd MMM yyyy').format(selectedDate!)}\n"
          "Tickets: $count\n"
          "Payment: $method\n"
          "Total: ₹${total.toStringAsFixed(2)}",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  // Payment button widget
  Widget _paymentButton(String method) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: const BorderSide(color: primaryColor),
            minimumSize: const Size.fromHeight(50),
          ),
          onPressed: () {
            if (method == "Wallet") {
              _askTicketCountAndBook(method);
            } else if (method == "UPI") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UpiPaymentScreen(
                    onPaymentConfirm: (upiMethod, count) {
                      _bookTicket("UPI - $upiMethod", count);
                    },
                  ),
                ),
              );
            } else if (method == "QR") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QrPaymentScreen(
                    onQrScanned: (count) {
                      _bookTicket("QR Code", count);
                    },
                  ),
                ),
              );
            }
          },
          child: Text(
            method == "Wallet"
                ? "$method (₹${walletBalance.toStringAsFixed(2)})"
                : method,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Book Ticket"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, Colors.orangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Source Dropdown
            DropdownButtonFormField<String>(
              value: selectedSource,
              items: uniqueSources
                  .map((src) => DropdownMenuItem(value: src, child: Text(src)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedSource = val;
                  selectedDestination = null;
                  selectedDate = null;
                  selectedBusId = null;
                });
              },
              decoration: _dropdownDecoration("Select Source"),
            ),
            const SizedBox(height: 16),

            // Destination Dropdown
            if (selectedSource != null)
              DropdownButtonFormField<String>(
                value: selectedDestination,
                items: destinationsForSelectedSource
                    .map((dest) =>
                        DropdownMenuItem(value: dest, child: Text(dest)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedDestination = val;
                    selectedDate = null;
                    selectedBusId = null;
                  });
                },
                decoration: _dropdownDecoration("Select Destination"),
              ),
            const SizedBox(height: 16),

            // Date Picker
            if (selectedDestination != null)
              GestureDetector(
                onTap: pickDate,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    selectedDate == null
                        ? "Select Date"
                        : DateFormat('dd MMM yyyy').format(selectedDate!),
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedDate == null ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Available Buses
            if (availableBuses.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Available Buses",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800])),
                  const SizedBox(height: 10),
                  ...availableBuses.map((bus) {
                    final isSelected = selectedBusId == bus['id'];
                    return GestureDetector(
                      onTap: () => setState(() {
                        selectedBusId = bus['id'] as int;
                      }),
                      child: Card(
                        color: isSelected ? Colors.orange[100] : Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        child: ListTile(
                          leading: const Icon(Icons.directions_bus,
                              color: primaryColor),
                          title: Text("${bus['bus']} - ${bus['time']}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Bus No: ${bus['number']}"),
                              Text(
                                  "Stops: ${(bus['stops'] as List<String>).join(', ')}"),
                              Text("Price: ₹${bus['price']}"),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            const SizedBox(height: 20),

            // Payment Methods
            if (selectedBus != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Payment Method",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800])),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _paymentButton("Wallet"),
                      _paymentButton("UPI"),
                      _paymentButton("QR"),
                    ],
                  )
                ],
              ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
