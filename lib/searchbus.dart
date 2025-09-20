

// import 'package:flutter/material.dart';

// class SearchbusScreen extends StatefulWidget {
//   const SearchbusScreen({super.key});

//   @override
//   State<SearchbusScreen> createState() => _SearchbusScreenState();
// }

// class _SearchbusScreenState extends State<SearchbusScreen> {
//   String? selectedStop;
//   String? selectedRouteKey;
//   int? selectedBusId;

//   /// Sample bus data with intermediate stops
//   final List<Map<String, dynamic>> buses = [
//     {
//       'id': 1,
//       'source': 'Manjeri',
//       'destination': 'Kozhikode',
//       'stops': ['Manjeri', 'Kottakkal', 'Ramanattukara'],
//       'time': '08:00 AM',
//       'bus': 'Bus A',
//     },
//     {
//       'id': 2,
//       'source': 'Manjeri',
//       'destination': 'Kozhikode',
//       'stops': ['Manjeri', 'Areekode', 'Feroke'],
//       'time': '09:00 AM',
//       'bus': 'Bus B',
//     },
//     {
//       'id': 3,
//       'source': 'Areekode',
//       'destination': 'Malappuram',
//       'stops': ['Areekode', 'Manjeri'],
//       'time': '10:00 AM',
//       'bus': 'Bus C',
//     },
//     {
//       'id': 4,
//       'source': 'Mongam',
//       'destination': 'Kondotty',
//       'stops': ['Mongam', 'Kondotty'],
//       'time': '11:30 AM',
//       'bus': 'Bus D',
//     },
//     {
//       'id': 5,
//       'source': 'Manjeri',
//       'destination': 'Nilambur',
//       'stops': ['Manjeri', 'Edavanna'],
//       'time': '01:00 PM',
//       'bus': 'Bus E',
//     },
//   ];

//   /// Get unique stops from all routes
//   List<String> get uniqueStops {
//     final allStops = buses.expand((bus) => bus['stops'] as List<String>);
//     return allStops.toSet().toList();
//   }

//   /// Get (source → destination) route keys passing through the selected stop
//   List<String> get availableRouteKeys {
//     if (selectedStop == null) return [];
//     return buses
//         .where((bus) => (bus['stops'] as List<String>).contains(selectedStop))
//         .map((bus) => "${bus['source']} → ${bus['destination']}")
//         .toSet()
//         .toList();
//   }

//   /// Get buses matching selected route key and stop
//   List<Map<String, dynamic>> get availableBuses {
//     if (selectedRouteKey == null || selectedStop == null) return [];
//     final parts = selectedRouteKey!.split(" → ");
//     return buses.where((bus) {
//       return bus['source'] == parts[0] &&
//           bus['destination'] == parts[1] &&
//           (bus['stops'] as List<String>).contains(selectedStop);
//     }).toList();
//   }

//   /// Get selected bus details
//   Map<String, dynamic>? get selectedBus {
//     if (selectedBusId == null) return null;
//     return buses.firstWhere(
//       (bus) => bus['id'] == selectedBusId,
//       orElse: () => {},
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Search Bus"),
//         backgroundColor: Colors.blueAccent,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             /// 1️⃣ Select Bus Stop
//             DropdownButtonFormField<String>(
//               value: selectedStop,
//               items: uniqueStops.map((stop) {
//                 return DropdownMenuItem(
//                   value: stop,
//                   child: Text(stop),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedStop = value;
//                   selectedRouteKey = null;
//                   selectedBusId = null;
//                 });
//               },
//               decoration: const InputDecoration(
//                 labelText: "Select Bus Stop",
//                 border: OutlineInputBorder(),
//               ),
//             ),

//             const SizedBox(height: 20),

//             /// 2️⃣ Select Route (source → destination)
//             if (selectedStop != null)
//               DropdownButtonFormField<String>(
//                 value: selectedRouteKey,
//                 items: availableRouteKeys.map((routeKey) {
//                   return DropdownMenuItem(
//                     value: routeKey,
//                     child: Text(routeKey),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedRouteKey = value;
//                     selectedBusId = null;
//                   });
//                 },
//                 decoration: const InputDecoration(
//                   labelText: "Select Route",
//                   border: OutlineInputBorder(),
//                 ),
//               ),

//             const SizedBox(height: 20),

//             /// 3️⃣ Select Specific Bus
//             if (selectedRouteKey != null)
//               DropdownButtonFormField<int>(
//                 value: selectedBusId,
//                 items: availableBuses.map((bus) {
//                   return DropdownMenuItem(
//                     value: bus['id'] as int,
//                     child: Text("${bus['bus']} - ${bus['time']}"),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedBusId = value;
//                   });
//                 },
//                 decoration: const InputDecoration(
//                   labelText: "Select Bus",
//                   border: OutlineInputBorder(),
//                 ),
//               ),

//             const SizedBox(height: 30),

//             /// 🚌 Show Bus Details
//             if (selectedBus != null && selectedBus!.isNotEmpty)
//               Card(
//                 elevation: 4,
//                 child: ListTile(
//                   leading: const Icon(Icons.directions_bus, color: Colors.blue),
//                   title: Text("Bus: ${selectedBus!['bus']}"),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Time: ${selectedBus!['time']}"),
//                       Text(
//                           "Route: ${selectedBus!['source']} → ${selectedBus!['destination']}"),
//                       Text(
//                           "Stops: ${(selectedBus!['stops'] as List<String>).join(', ')}"),
//                     ],
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class SearchbusScreen extends StatefulWidget {
  const SearchbusScreen({super.key});

  @override
  State<SearchbusScreen> createState() => _SearchbusScreenState();
}

class _SearchbusScreenState extends State<SearchbusScreen> {
  String? selectedSource;
  String? selectedDestination;
  int? selectedBusId;

  /// Sample route data
  final List<Map<String, dynamic>> buses = [
    {
      'id': 1,
      'source': 'Manjeri',
      'destination': 'Kozhikode',
      'stops': ['Manjeri', 'Kottakkal', 'Ramanattukara', 'Kozhikode'],
      'time': '08:00 AM',
      'bus': 'Bus A',
    },
    {
      'id': 2,
      'source': 'Manjeri',
      'destination': 'Kozhikode',
      'stops': ['Manjeri', 'Areekode', 'Feroke', 'Kozhikode'],
      'time': '09:00 AM',
      'bus': 'Bus B',
    },
    {
      'id': 3,
      'source': 'Areekode',
      'destination': 'Malappuram',
      'stops': ['Areekode', 'Manjeri', 'Malappuram'],
      'time': '10:00 AM',
      'bus': 'Bus C',
    },
    {
      'id': 4,
      'source': 'Mongam',
      'destination': 'Kondotty',
      'stops': ['Mongam', 'Kondotty'],
      'time': '11:30 AM',
      'bus': 'Bus D',
    },
    {
      'id': 5,
      'source': 'Manjeri',
      'destination': 'Nilambur',
      'stops': ['Manjeri', 'Edavanna', 'Nilambur'],
      'time': '01:00 PM',
      'bus': 'Bus E',
    },
  ];

  /// Get unique sources
  List<String> get uniqueSources {
    return buses.map((bus) => bus['source'] as String).toSet().toList();
  }

  /// Get destinations for selected source
  List<String> get destinationsForSelectedSource {
    if (selectedSource == null) return [];
    return buses
        .where((bus) => bus['source'] == selectedSource)
        .map((bus) => bus['destination'] as String)
        .toSet()
        .toList();
  }

  /// Get buses for selected source and destination
  List<Map<String, dynamic>> get availableRoutes {
    if (selectedSource == null || selectedDestination == null) return [];
    return buses.where((bus) {
      return bus['source'] == selectedSource &&
          bus['destination'] == selectedDestination;
    }).toList();
  }

  /// Get selected bus
  Map<String, dynamic>? get selectedBus {
    if (selectedBusId == null) return null;
    return buses.firstWhere(
      (bus) => bus['id'] == selectedBusId,
      orElse: () => {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Bus"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// 1️⃣ Source Dropdown
            DropdownButtonFormField<String>(
              value: selectedSource,
              items: uniqueSources.map((source) {
                return DropdownMenuItem(
                  value: source,
                  child: Text(source),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSource = value;
                  selectedDestination = null;
                  selectedBusId = null;
                });
              },
              decoration: const InputDecoration(
                labelText: "Select Source",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            /// 2️⃣ Destination Dropdown
            if (selectedSource != null)
              DropdownButtonFormField<String>(
                value: selectedDestination,
                items: destinationsForSelectedSource.map((dest) {
                  return DropdownMenuItem(
                    value: dest,
                    child: Text(dest),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDestination = value;
                    selectedBusId = null;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Select Destination",
                  border: OutlineInputBorder(),
                ),
              ),

            const SizedBox(height: 20),

            /// 3️⃣ Route Dropdown
            if (selectedDestination != null)
              DropdownButtonFormField<int>(
                value: selectedBusId,
                items: availableRoutes.map((bus) {
                  return DropdownMenuItem(
                    value: bus['id'] as int,
                    child: Text("${bus['bus']} - ${bus['time']}"),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBusId = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Select Bus Route",
                  border: OutlineInputBorder(),
                ),
              ),

            const SizedBox(height: 30),

            /// 4️⃣ Show Bus Details
            if (selectedBus != null && selectedBus!.isNotEmpty)
              Card(
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.directions_bus, color: Colors.blue),
                  title: Text("Bus: ${selectedBus!['bus']}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Time: ${selectedBus!['time']}"),
                      Text(
                          "Route: ${selectedBus!['source']} → ${selectedBus!['destination']}"),
                      Text(
                          "Stops: ${(selectedBus!['stops'] as List<String>).join(', ')}"),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
