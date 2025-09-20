import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber,title:Text("Loginpage"),centerTitle: true,),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(hintText: "Username",border:OutlineInputBorder(borderRadius: BorderRadius.circular(15)) ),
            ),
          ),
          
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(decoration: InputDecoration(hintText: "Password",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
              ),
            ),
            ElevatedButton(onPressed: (){}, child: Text("Login")),
            SizedBox(height: 15,),
            TextButton(onPressed: (){}, child: Text("Dont have account Register now"))
        ],),
      ),
    );
  }
}
