import 'package:buzbee/API/registerAPI.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  TextEditingController complaint = TextEditingController();
  List<dynamic> Bus = [];
  String? selectedBusId;

  Future<void> SubmitComplaint() async {
    final complaintText = complaint.text;
    if (complaintText.isEmpty || selectedBusId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a complaint and select a bus')),
      );
      return;
    }

    try {
      Response response = await dio.post(
        '$baseurl/ComplaintAPI/$LID',
        data: {
          'Complaint': complaintText,
          'BUS': selectedBusId, // 👈 sending bus ID to backend
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Complaint sent successfully')),
        );
        complaint.clear();
        setState(() => selectedBusId = null);
      }
    } catch (e) {
      debugPrint('Error submitting complaint: $e');
    }
  }

  Future<void> _fetchBus() async {
    try {
      final response = await dio.get('$baseurl/ViewbusAPI');
      print(response.data);
      if (response.statusCode == 200 && response.data != null) {
        setState(() {
          Bus = response.data;
        });
      }
    } catch (e) {
      debugPrint('Error fetching buses: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Complaints"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.directions_bus, color: Colors.black12),
                hintText: "Select Bus",
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              value: selectedBusId,
              items: Bus
                  .map<DropdownMenuItem<String>>(
                    (bus) => DropdownMenuItem(
                      value: bus['id'].toString(), // 👈 storing bus ID
                      child: Text('${bus['Busname']} - ${bus['Bus_NO']}' ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => selectedBusId = value);
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: complaint,
              decoration: InputDecoration(
                hintText: "Complaint Details",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: SubmitComplaint,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
