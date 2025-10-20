import 'package:buzbee/API/registerAPI.dart';
import 'package:buzbee/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<void> login(String Username,String Password, context) async{
  Response res = await dio.post('$baseurl/LoginPageAPI',data: {
    'Username': Username,
    'Password':Password
  });
  
  if (res.statusCode==200 || res.statusCode==201) {
    LID = res.data['Login_id'];
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PassengerHomePage(),));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successful')));

    
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
  }
}