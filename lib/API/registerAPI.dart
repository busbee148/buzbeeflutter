import 'package:buzbee/home.dart';
import 'package:buzbee/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Dio dio=Dio();
int? LID;
String baseurl='http://192.168.1.136:5000';

Future<void> register(data, context) async{
  Response res = await dio.post('$baseurl/PassangerView',data: data);
  print(data);
  if (res.statusCode==200 || res.statusCode==201) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('registration successful')));

    
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('registration failed')));
  }
}