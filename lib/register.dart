import 'package:buzbee/API/registerAPI.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cNOController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? selectedGender;

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
              height: 180,
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
                  "Create Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // 🔸 Registration Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  _buildTextField("Full Name", nameController, Icons.person),
                  _buildTextField(
                      "Username", usernameController, Icons.account_circle),
                  _buildTextField(
                      "Password", passwordController, Icons.lock,
                      isPassword: true),
                  _buildTextField("Age", ageController, Icons.cake),
                  _buildDropdown(),
                  _buildTextField("Address", addressController, Icons.home),
                  _buildTextField(
                      "Contact Number", cNOController, Icons.phone_android),
                  _buildTextField("Email", emailController, Icons.email),

                  const SizedBox(height: 25),

                  // 🔘 Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Map<String, dynamic> data = {
                          'Name': nameController.text,
                          'Email': emailController.text,
                          'Age': ageController.text,
                          'Contact_NO': cNOController.text,
                          'Gender': selectedGender,
                          'Address': addressController.text,
                          'Username': usernameController.text,
                          'Password': passwordController.text,
                        };
                        register(data, context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        elevation: 4,
                      ),
                      child: const Text(
                        "Create Account",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, IconData icon,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
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
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.wc, color: primaryColor),
          hintText: "Select Gender",
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        value: selectedGender,
        items: ['Male', 'Female', 'Others']
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (value) => setState(() => selectedGender = value),
      ),
    );
  }
}
