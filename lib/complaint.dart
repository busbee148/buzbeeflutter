import 'package:flutter/material.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent, title: Text("Complaints"),centerTitle: true,),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(decoration: InputDecoration(hintText: "Subject",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),),
          
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(decoration: InputDecoration(hintText: "Complain Details",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          ),
        ),
        ElevatedButton(onPressed: (){}, child: Text("Submit"))
      ],),
    );
  }
}