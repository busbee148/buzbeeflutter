// import 'package:buzbee/API/registerAPI.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// Future<void>PostFeedback(String Feedback,context)async{
//   Response res=await dio.post('$baseurl/FeedbackAPI/$LID',
//   data: {
//     'feedback':Feedback
//   });
//   if(res.statusCode==200||res.statusCode==201){
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Feedback sent succefully")));
//   }
//   else{
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Feedback not sent")));
//   }
// }


import 'package:buzbee/API/registerAPI.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<bool> PostFeedback({
  required String feedback,
  required BuildContext context,
}) async {
  try {
    final response = await dio.post(
      '$baseurl/FeedbackAPI/$LID',
      data: {
        "Feedback": feedback,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }

  } catch (e) {
    print("Error posting feedback: $e");
    return false;
  }
}
