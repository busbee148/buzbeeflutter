import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent, title: Text("Feedback"),centerTitle: true,),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(decoration: InputDecoration(hintText: "Busname",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(decoration: InputDecoration(hintText: "Feedback",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          ),
        ),
        ElevatedButton(onPressed: (){}, child: Text("Submit"))
      ],),
    );
  }
}