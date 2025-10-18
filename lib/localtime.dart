import 'package:flutter/material.dart';
import 'main.dart';

class BusNotificationsScreen extends StatefulWidget {
  const BusNotificationsScreen({super.key});

  @override
  State<BusNotificationsScreen> createState() => _BusNotificationsScreenState();
}

class _BusNotificationsScreenState extends State<BusNotificationsScreen> {
  bool enableLocalTimeNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: SwitchListTile(
                title: const Text(
                  "Enable Local Time Notifications",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "All bus alerts will follow your device's local time",
                ),
                value: enableLocalTimeNotifications,
                activeColor: MyApp.primaryColor,
                onChanged: (val) {
                  setState(() {
                    enableLocalTimeNotifications = val;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
