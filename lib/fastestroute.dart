// import 'package:flutter/material.dart';
// import 'main.dart';

// class FastestRouteScreen extends StatefulWidget {
//   const FastestRouteScreen({super.key});

//   @override
//   State<FastestRouteScreen> createState() => _FastestRouteScreenState();
// }

// class _FastestRouteScreenState extends State<FastestRouteScreen> {
//   String? selectedSource;
//   String? selectedDestination;
//   String? selectedTime;

//   /// Sample bus data
//   final List<Map<String, dynamic>> buses = [
//     {
//       'id': 1,
//       'bus': 'Bus A',
//       'source': 'Manjeri',
//       'destination': 'Kozhikode',
//       'departure': '08:00 AM',
//       'duration': 70, // minutes
//     },
//     {
//       'id': 2,
//       'bus': 'Bus B',
//       'source': 'Manjeri',
//       'destination': 'Kozhikode',
//       'departure': '08:30 AM',
//       'duration': 60,
//     },
//     {
//       'id': 3,
//       'bus': 'Bus C',
//       'source': 'Manjeri',
//       'destination': 'Nilambur',
//       'departure': '09:00 AM',
//       'duration': 90,
//     },
//     {
//       'id': 4,
//       'bus': 'Bus D',
//       'source': 'Areekode',
//       'destination': 'Malappuram',
//       'departure': '10:00 AM',
//       'duration': 45,
//     },
//   ];

//   /// Extract unique sources and destinations
//   List<String> get sources => buses.map((b) => b['source'] as String).toSet().toList();
//   List<String> get destinations => buses.map((b) => b['destination'] as String).toSet().toList();

//   /// Filtered & sorted buses
//   List<Map<String, dynamic>> get availableBuses {
//     final filtered = buses.where((bus) {
//       final sourceMatch = selectedSource == null || bus['source'] == selectedSource;
//       final destMatch = selectedDestination == null || bus['destination'] == selectedDestination;
//       return sourceMatch && destMatch;
//     }).toList();

//     filtered.sort((a, b) => a['duration'].compareTo(b['duration']));
//     return filtered;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Fastest Route",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [MyApp.primaryColor],
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
//             // 🔹 Source
//             DropdownButtonFormField<String>(
//               value: selectedSource,
//               items: sources.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
//               onChanged: (v) => setState(() => selectedSource = v),
//               decoration: const InputDecoration(
//                 labelText: "Select Source",
//                 border: OutlineInputBorder(),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // 🔹 Destination
//             DropdownButtonFormField<String>(
//               value: selectedDestination,
//               items: destinations.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
//               onChanged: (v) => setState(() => selectedDestination = v),
//               decoration: const InputDecoration(
//                 labelText: "Select Destination",
//                 border: OutlineInputBorder(),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // 🔹 Time Picker
//             TextFormField(
//               readOnly: true,
//               decoration: const InputDecoration(
//                 labelText: "Select Preferred Time",
//                 border: OutlineInputBorder(),
//                 suffixIcon: Icon(Icons.access_time),
//               ),
//               onTap: () async {
//                 final picked = await showTimePicker(
//                   context: context,
//                   initialTime: TimeOfDay.now(),
//                 );
//                 if (picked != null) {
//                   setState(() {
//                     selectedTime = picked.format(context);
//                   });
//                 }
//               },
//               controller: TextEditingController(text: selectedTime ?? ""),
//             ),

//             const SizedBox(height: 30),

//             if (availableBuses.isEmpty)
//               const Text("No matching routes found.")
//             else
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Available Fastest Routes",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 12),
//                   ...availableBuses.map((bus) => _buildBusCard(bus)),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBusCard(Map<String, dynamic> bus) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 4,
//       child: ListTile(
//         leading: const Icon(Icons.directions_bus, color: Colors.orange),
//         title: Text(
//           "${bus['bus']}  (${bus['source']} → ${bus['destination']})",
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(
//           "Departs: ${bus['departure']}\nDuration: ${bus['duration']} mins",
//         ),
//         trailing: ElevatedButton(
//           onPressed: () {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text("Selected ${bus['bus']}")),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: MyApp.primaryColor,
//             foregroundColor: Colors.white,
//           ),
//           child: const Text("Select"),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'main.dart';

class FastestRouteScreen extends StatefulWidget {
  const FastestRouteScreen({super.key});

  @override
  State<FastestRouteScreen> createState() => _FastestRouteScreenState();
}

class _FastestRouteScreenState extends State<FastestRouteScreen> {
  String? selectedSource;
  String? selectedDestination;
  String? selectedTime;

  /// Sample bus data
  final List<Map<String, dynamic>> buses = [
    {
      'id': 1,
      'bus': 'Bus A',
      'source': 'Manjeri',
      'destination': 'Kozhikode',
      'departure': '08:00 AM',
      'duration': 70,
    },
    {
      'id': 2,
      'bus': 'Bus B',
      'source': 'Manjeri',
      'destination': 'Kozhikode',
      'departure': '08:30 AM',
      'duration': 60,
    },
    {
      'id': 3,
      'bus': 'Bus C',
      'source': 'Manjeri',
      'destination': 'Nilambur',
      'departure': '09:00 AM',
      'duration': 90,
    },
    {
      'id': 4,
      'bus': 'Bus D',
      'source': 'Areekode',
      'destination': 'Malappuram',
      'departure': '10:00 AM',
      'duration': 45,
    },
  ];

  /// Filter based on text search
  List<Map<String, dynamic>> get availableBuses {
    return buses.where((bus) {
      final sourceMatch = selectedSource == null ||
          selectedSource!.isEmpty ||
          bus['source'].toLowerCase().contains(selectedSource!.toLowerCase());

      final destMatch = selectedDestination == null ||
          selectedDestination!.isEmpty ||
          bus['destination'].toLowerCase().contains(selectedDestination!.toLowerCase());

      return sourceMatch && destMatch;
    }).toList()
      ..sort((a, b) => a['duration'].compareTo(b['duration']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fastest Route",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyApp.primaryColor, Colors.orangeAccent],
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
            /// 🔹 Search Source
            TextField(
              decoration: const InputDecoration(
                labelText: "Search Source",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  selectedSource = value.trim();
                });
              },
            ),

            const SizedBox(height: 20),

            /// 🔹 Search Destination
            TextField(
              decoration: const InputDecoration(
                labelText: "Search Destination",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  selectedDestination = value.trim();
                });
              },
            ),

            const SizedBox(height: 20),

            /// 🔹 Time Picker
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Select Preferred Time",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.access_time),
              ),
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  setState(() {
                    selectedTime = picked.format(context);
                  });
                }
              },
              controller: TextEditingController(text: selectedTime ?? ""),
            ),

            const SizedBox(height: 30),

            /// 🔹 Results
            availableBuses.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "No matching routes found.",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Available Fastest Routes",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      /// Generate each bus card
                      ...availableBuses.map((bus) => _buildBusCard(bus)),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Bus Card Widget
  Widget _buildBusCard(Map<String, dynamic> bus) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.directions_bus, color: Colors.orange),
        title: Text(
          "${bus['bus']}  (${bus['source']} → ${bus['destination']})",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Departs: ${bus['departure']}\nDuration: ${bus['duration']} mins",
        ),
        trailing: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Selected ${bus['bus']}")),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MyApp.primaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text("Select"),
        ),
      ),
    );
  }
}
