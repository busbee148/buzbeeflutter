// import 'package:buzbee/API/loginAPI.dart';
// import 'package:buzbee/register.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatelessWidget {
//    LoginScreen({super.key});

//    TextEditingController usernameController = TextEditingController();
//    TextEditingController passwordController = TextEditingController();
 

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(backgroundColor: Colors.amber,title:Text("Loginpage"),centerTitle: true,),
//       body: Center(
//         child: Column(mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               controller: usernameController,
//               decoration: InputDecoration(hintText: "Username",border:OutlineInputBorder(borderRadius: BorderRadius.circular(15)) ),
//             ),
//           ),
          
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextFormField(
//                 controller: passwordController,
//                 decoration: InputDecoration(hintText: "Password",border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
//               ),
//             ),
//             ElevatedButton(onPressed: (){
//               login(usernameController.text,passwordController.text, context);
//             }, child: Text("Login")),
//             SizedBox(height: 15,),
//             TextButton(onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
//             }, child: Text("Dont have account Register now"))
//         ],),
//       ),
//     );
//   }
// }

import 'package:buzbee/API/loginAPI.dart';
import 'package:buzbee/register.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static const primaryColor = Color(0xFFF07B11);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔶 Gradient Header
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, Colors.orangeAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Center(
                child: Text(
                  "Welcome Back!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50),

            // 🧾 Login Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildTextField(
                    "Username",
                    usernameController,
                    Icons.person_outline,
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    "Password",
                    passwordController,
                    Icons.lock_outline,
                    isPassword: true,
                  ),

                  const SizedBox(height: 30),

                  // 🔘 Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        login(
                          usernameController.text,
                          passwordController.text,
                          context,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 4,
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔹 Register Link
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text(
                      "Don’t have an account? Register now",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // 🧱 Reusable Text Field Widget
  Widget _buildTextField(String hint, TextEditingController controller, IconData icon,
      {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: primaryColor),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
