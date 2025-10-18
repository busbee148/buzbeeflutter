// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For vibration
import 'package:audioplayers/audioplayers.dart'; // For sound
import 'main.dart';

class DepartureAlertScreen extends StatefulWidget {
  const DepartureAlertScreen({super.key});

  @override
  State<DepartureAlertScreen> createState() => _DepartureAlertScreenState();
}

class _DepartureAlertScreenState extends State<DepartureAlertScreen> {
  String? selectedSource;
  String? selectedDestination;
  int? selectedBusId;
  int? alertMinutes;

  bool enableAlert = false;
  String alertType = 'Sound'; // "Sound" or "Vibration"

  Timer? countdownTimer;
  Duration? remainingTime;

  final player = AudioPlayer();

  final List<Map<String, dynamic>> busesTemplate = [
    {
      'id': 1,
      'bus': 'Bus A',
      'source': 'Manjeri',
      'destination': 'Kozhikode',
      'departure': '08:00 AM',
      'hour': 8,
      'minute': 0,
    },
    {
      'id': 2,
      'bus': 'Bus B',
      'source': 'Manjeri',
      'destination': 'Nilambur',
      'departure': '09:00 AM',
      'hour': 9,
      'minute': 0,
    },
    {
      'id': 3,
      'bus': 'Bus C',
      'source': 'Areekode',
      'destination': 'Malappuram',
      'departure': '01:00 PM',
      'hour': 13,
      'minute': 0,
    },
  ];

  late final List<Map<String, dynamic>> buses;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    buses = busesTemplate.map((bus) {
      return {
        ...bus,
        'time': DateTime(today.year, today.month, today.day, bus['hour'], bus['minute']),
      };
    }).toList();
  }

  List<String> get sources => buses.map((b) => b['source'] as String).toSet().toList();
  List<String> get destinations => buses.map((b) => b['destination'] as String).toSet().toList();

  List<Map<String, dynamic>> get filteredBuses {
    return buses.where((bus) {
      final sMatch = selectedSource == null || bus['source'] == selectedSource;
      final dMatch = selectedDestination == null || bus['destination'] == selectedDestination;
      return sMatch && dMatch;
    }).toList();
  }

  Map<String, dynamic>? get selectedBus {
    if (selectedBusId == null) return null;
    return buses.firstWhere((b) => b['id'] == selectedBusId, orElse: () => {});
  }

  void startAlertCountdown() {
    if (selectedBus == null || alertMinutes == null || !enableAlert) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enable alert and select all options")),
      );
      return;
    }

    final busTime = selectedBus!['time'] as DateTime;
    final alertTime = busTime.subtract(Duration(minutes: alertMinutes!));
    final now = DateTime.now();
    final diff = alertTime.difference(now);

    if (diff.isNegative) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Too late to set an alert!")),
      );
      return;
    }

    remainingTime = diff;
    countdownTimer?.cancel();

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime!.inSeconds <= 0) {
        timer.cancel();
        triggerAlert();
      } else {
        setState(() {
          remainingTime = Duration(seconds: remainingTime!.inSeconds - 1);
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Departure alert set successfully")),
    );
  }

  void triggerAlert() async {
    if (alertType == 'Vibration') {
      HapticFeedback.vibrate();
    } else {
      await player.play(AssetSource('sounds/alert_tone.mp3')); // Add a tone in assets/sounds/
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("🚍 Departure Alert!"),
        content: Text("Your bus ${selectedBus!['bus']} is departing soon!"),
        actions: [
          TextButton(
            onPressed: () {
              player.stop();
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Departure Alert"),
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
            DropdownButtonFormField<String>(
              value: selectedSource,
              items: sources.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() {
                selectedSource = v;
                selectedDestination = null;
                selectedBusId = null;
              }),
              decoration: const InputDecoration(
                labelText: "Select Source",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedDestination,
              items: destinations.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() {
                selectedDestination = v;
                selectedBusId = null;
              }),
              decoration: const InputDecoration(
                labelText: "Select Destination",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            if (selectedSource != null && selectedDestination != null)
              DropdownButtonFormField<int>(
                value: selectedBusId,
                items: filteredBuses.map((bus) {
                  return DropdownMenuItem(
                    value: bus['id'] as int,
                    child: Text("${bus['bus']} - ${bus['departure']}"),
                  );
                }).toList(),
                onChanged: (v) => setState(() => selectedBusId = v),
                decoration: const InputDecoration(
                  labelText: "Select Bus",
                  border: OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 20),

            if (selectedBus != null)
              DropdownButtonFormField<int>(
                value: alertMinutes,
                items: [3, 5, 10]
                    .map((m) => DropdownMenuItem(value: m, child: Text("$m minutes before")))
                    .toList(),
                onChanged: (v) => setState(() => alertMinutes = v),
                decoration: const InputDecoration(
                  labelText: "Alert Before Departure",
                  border: OutlineInputBorder(),
                ),
              ),

            const SizedBox(height: 20),

            SwitchListTile(
              title: const Text("Enable Departure Alert"),
              activeColor: MyApp.primaryColor,
              value: enableAlert,
              onChanged: (v) => setState(() => enableAlert = v),
            ),

            if (enableAlert)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                    value: 'Sound',
                    groupValue: alertType,
                    onChanged: (v) => setState(() => alertType = v!),
                  ),
                  const Text("Sound"),
                  Radio<String>(
                    value: 'Vibration',
                    groupValue: alertType,
                    onChanged: (v) => setState(() => alertType = v!),
                  ),
                  const Text("Vibration"),
                ],
              ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: startAlertCountdown,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyApp.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text("Set Alert"),
            ),

            if (remainingTime != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "⏰ Alert in ${remainingTime!.inMinutes}:${(remainingTime!.inSeconds % 60).toString().padLeft(2, '0')} mins",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
