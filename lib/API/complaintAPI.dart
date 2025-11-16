import 'package:buzbee/API/registerAPI.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<bool> postComplaint({
  required String complaint,
  required BuildContext context,
}) async {
  try {
    final response = await dio.post(
      '$baseurl/ComplaintAPI/$LID',
      data: {
        "Complaint": complaint,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }

  } catch (e) {
    print("Error posting complaint: $e");
    return false;
  }
}


Future<List<dynamic>> fetchComplaints() async {
  try {
    final response = await dio.get('$baseurl/ComplaintAPI/$LID');
print(response.data);
    if (response.statusCode == 200) {
      return response.data; 
    } else {
      return [];
    }
  } catch (e) {
    print("Error fetching complaints: $e");
    return [];
  }
}
