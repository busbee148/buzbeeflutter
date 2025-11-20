import 'package:buzbee/complaint.dart';
import 'package:buzbee/feedback.dart';
import 'package:buzbee/main.dart';
import 'package:flutter/material.dart';


class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        backgroundColor: MyApp.primaryColor,
      ),

      body: ListView(
        children: [

          // Register Complaint
          ListTile(
            leading: const Icon(Icons.report_problem, color: Colors.redAccent),
            title: const Text("Register Complaint"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ComplaintScreen()),
              );
            },
          ),
          const Divider(),

          // Feedback Screen
          ListTile(
            leading: const Icon(Icons.rate_review, color: Colors.orangeAccent),
            title: const Text("Feedback & Ratings"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FeedbackScreen()),
              );
            },
          ),
          const Divider(),

          // Multilingual
          ListTile(
            leading: const Icon(Icons.language, color: Colors.green),
            title: const Text("Multilingual Support"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => const EmptyPage(title: "Multilingual Support"),
              //   ),
              // );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
