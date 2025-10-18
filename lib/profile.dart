// import 'package:flutter/material.dart';

// class ProfileScreenn extends StatefulWidget {
//   const ProfileScreenn({super.key});

//   @override
//   State<ProfileScreenn> createState() => _ProfileScreennState();
// }

// class _ProfileScreennState extends State<ProfileScreenn> {
//   bool isEditing = false;

//   final TextEditingController nameController =
//       TextEditingController(text: "John Doe");
//   final TextEditingController usernameController =
//       TextEditingController(text: "buzbee_user");
//   final TextEditingController ageController =
//       TextEditingController(text: "25");
//   final TextEditingController contactController =
//       TextEditingController(text: "9876543210");
//   final TextEditingController emailController =
//       TextEditingController(text: "john@example.com");

//   static const Color primaryColor = Color(0xFFF07B11);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: primaryColor,
//         centerTitle: true,
//         title: const Text(
//           "My Profile",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               isEditing ? Icons.check : Icons.edit,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               setState(() {
//                 if (isEditing) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Profile Updated")),
//                   );
//                 }
//                 isEditing = !isEditing;
//               });
//             },
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // 🔶 Top Profile Banner
//             Container(
//               height: 200,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [primaryColor, Colors.orangeAccent],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.white,
//                     child: Icon(Icons.person,
//                         color: primaryColor, size: 60),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "BuzBee Passenger",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     "Track • Book • Travel Smart",
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // 🧾 Profile Details Card
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 5,
//                         offset: Offset(0, 3))
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     _buildProfileField("Name", nameController, Icons.person),
//                     _buildProfileField(
//                         "Username", usernameController, Icons.alternate_email),
//                     _buildProfileField("Age", ageController, Icons.cake),
//                     _buildProfileField("Contact", contactController, Icons.phone),
//                     _buildProfileField("Email", emailController, Icons.email),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),

//             // ✅ Save button (only when editing)
//             if (isEditing)
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 48,
//                   child: ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: primaryColor,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12)),
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         isEditing = false;
//                       });
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Profile Updated")),
//                       );
//                     },
//                     icon: const Icon(Icons.save),
//                     label: const Text(
//                       "Save Changes",
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//               ),

//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileField(
//       String label, TextEditingController controller, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         enabled: isEditing,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon, color: primaryColor),
//           filled: true,
//           fillColor: Colors.grey[50],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: primaryColor),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: primaryColor),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(width: 2, color: primaryColor),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:buzbee/editprofile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const Color primaryColor = Color(0xFFF07B11);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // User info (this could later be loaded from backend or shared prefs)
  String name = "John Doe";
  String username = "buzbee_user";
  String age = "25";
  String contact = "9876543210";
  String email = "john@example.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ProfileScreen.primaryColor,
        centerTitle: true,
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () async {
              // Navigate to edit page and wait for result
              final updatedData = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfileScreen(
                    // name: name,
                    // username: username,
                    // age: age,
                    // contact: contact,
                    // email: email,
                  ),
                ),
              );

              // If data returned from edit screen, update profile and show snackbar
              if (updatedData != null) {
                setState(() {
                  name = updatedData['name'];
                  username = updatedData['username'];
                  age = updatedData['age'];
                  contact = updatedData['contact'];
                  email = updatedData['email'];
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile Updated")),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 🔶 Gradient Header
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ProfileScreen.primaryColor, Colors.orangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person,
                      color: ProfileScreen.primaryColor, size: 60),
                ),
                SizedBox(height: 10),
                Text(
                  "BuzBee Passenger",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Track • Book • Travel Smart",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // 🧾 User Info Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 3))
                ],
              ),
              child: Column(
                children: [
                  _buildProfileRow("Name", name),
                  _buildProfileRow("Username", username),
                  _buildProfileRow("Age", age),
                  _buildProfileRow("Contact", contact),
                  _buildProfileRow("Email", email),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(value,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87)),
        ],
      ),
    );
  }
}
