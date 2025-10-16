
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

  static const primaryColor = Color(0xFFF07B11);

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

  List<String> get uniqueSources {
    return buses.map((bus) => bus['source'] as String).toSet().toList();
  }

  List<String> get destinationsForSelectedSource {
    if (selectedSource == null) return [];
    return buses
        .where((bus) => bus['source'] == selectedSource)
        .map((bus) => bus['destination'] as String)
        .toSet()
        .toList();
  }

  List<Map<String, dynamic>> get availableRoutes {
    if (selectedSource == null || selectedDestination == null) return [];
    return buses.where((bus) {
      return bus['source'] == selectedSource &&
          bus['destination'] == selectedDestination;
    }).toList();
  }

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Search Bus"),
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
        child: Column(
          children: [
            // 🔶 Header
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                children: const [
                  Icon(Icons.directions_bus, color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "Find Your Bus",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Select source, destination & route",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✨ Search Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
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
                    decoration: InputDecoration(
                      labelText: "Select Source",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                      decoration: InputDecoration(
                        labelText: "Select Destination",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
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
                      decoration: InputDecoration(
                        labelText: "Select Bus Route",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            if (selectedBus != null && selectedBus!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  child: ListTile(
                    leading:
                        const Icon(Icons.directions_bus, color: primaryColor),
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
              ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
