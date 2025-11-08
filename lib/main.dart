import 'package:buzbee/complaint.dart';
import 'package:buzbee/feedback.dart';
import 'package:buzbee/login.dart';
import 'package:buzbee/register.dart';
import 'package:buzbee/searchbus.dart';
import 'package:buzbee/bookticket.dart';
import 'package:buzbee/home.dart';
import 'package:buzbee/viewbusstop.dart';
import 'package:buzbee/fastestroute.dart';
import 'package:buzbee/departurealert.dart';
import 'package:buzbee/localtime.dart';
import 'package:buzbee/profile.dart';
import 'package:buzbee/editprofile.dart';
import 'package:flutter/material.dart';

void main() { 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static var primaryColor=Colors.orangeAccent;  

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen(),
    );
  }
}
