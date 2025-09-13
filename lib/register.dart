import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent,title:Text("Register"),centerTitle: true,),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(hintText: "Name",border:OutlineInputBorder(borderRadius: BorderRadius.circular(15)) ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(hintText: "Username",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(decoration: InputDecoration(hintText: "Password",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(decoration: InputDecoration(hintText: "Age",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(decoration: InputDecoration(hintText: "Contact Number",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(decoration: InputDecoration(hintText: "Email",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          ),
        ),
          
          ElevatedButton(onPressed: (){}, child: Text("Create")),
          SizedBox(height: 15,),
      ],),
    );
  }
}
