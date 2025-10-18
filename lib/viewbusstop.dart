import 'package:flutter/material.dart';

class BusStopsScreen extends StatefulWidget {
  const BusStopsScreen({super.key});

  @override
  State<BusStopsScreen> createState() => _BusStopsScreenState();
}

class _BusStopsScreenState extends State<BusStopsScreen>
    with SingleTickerProviderStateMixin {
  static const primaryColor = Color(0xFFF07B11);
  late TabController _tabController;

  // 🗺️ Example Bus Stops (with numeric distance)
  final List<Map<String, dynamic>> allStops = [
    {
      'id': 'BS101',
      'name': 'Manjeri Bus Stand',
      'landmark': 'Near City Mall',
      'distance': 0.5,
      'photo': 'https://images.unsplash.com/photo-1605379399642-870262d3d051'
    },
    {
      'id': 'BS102',
      'name': 'Kottakkal Stop',
      'landmark': 'Opposite Apollo Clinic',
      'distance': 2.1,
      'photo': 'https://images.unsplash.com/photo-1506629082955-511b1aa562c8'
    },
    {
      'id': 'BS103',
      'name': 'Cherani Junction',
      'landmark': 'Near Petrol Pump',
      'distance': 1.3,
      'photo': 'https://images.unsplash.com/photo-1528909514045-2fa4ac7a08ba'
    },
    {
      'id': 'BS104',
      'name': 'Pandikkad Stop',
      'landmark': 'Beside SBI Bank',
      'distance': 4.8,
      'photo': 'https://images.unsplash.com/photo-1520975918318-3e5f3f54b84b'
    },
    {
      'id': 'BS105',
      'name': 'Malappuram KSRTC',
      'landmark': 'Main City Junction',
      'distance': 1.4,
      'photo': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308'
    },
  ];

  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // Filter nearby stops dynamically based on distance ≤ 1.5 km
    final nearbyStops =
        allStops.where((stop) => stop['distance'] <= 1.5).toList();

    // Filter full list by search query
    final filteredStops = allStops
        .where((stop) =>
            stop['name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
            stop['id'].toLowerCase().contains(searchQuery.toLowerCase()) ||
            stop['landmark'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Bus Stops",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, Colors.orangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          tabs: const [
            Tab(text: "Nearby"),
            Tab(text: "All Stops"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          /// 🗺️ Nearby Stops
          nearbyStops.isEmpty
              ? const Center(
                  child: Text(
                    "No nearby stops within 1.5 km",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: nearbyStops.length,
                  itemBuilder: (context, index) {
                    final stop = nearbyStops[index];
                    return _buildStopCard(
                      id: stop['id'],
                      name: stop['name'],
                      landmark: stop['landmark'],
                      photo: stop['photo'],
                      trailing: Text(
                        "${stop['distance']} km",
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),

          /// 🚏 All Stops
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: primaryColor),
                    hintText: "Search by ID, name or landmark...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) => setState(() => searchQuery = value),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredStops.length,
                    itemBuilder: (context, index) {
                      final stop = filteredStops[index];
                      return _buildStopCard(
                        id: stop['id'],
                        name: stop['name'],
                        landmark: stop['landmark'],
                        photo: stop['photo'],
                        trailing: Text(
                          "${stop['distance']} km",
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStopCard({
    required String id,
    required String name,
    required String landmark,
    required String photo,
    Widget? trailing,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            photo,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID: $id",
                style: const TextStyle(fontSize: 13, color: Colors.black54)),
            Text("Landmark: $landmark",
                style: const TextStyle(fontSize: 13, color: Colors.black54)),
          ],
        ),
        trailing: trailing,
      ),
    );
  }
}
