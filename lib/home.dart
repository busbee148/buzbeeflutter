// import 'package:buzbee/complaint.dart';
// import 'package:buzbee/feedback.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   static const primaryColor = Color(0xFFF07B11);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'BuzBee',
//       theme: ThemeData(
//         primaryColor: primaryColor,
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
//         ),
//       ),
//       home: const PassengerHomePage(),
//     );
//   }
// }

// class PassengerHomePage extends StatelessWidget {
//   const PassengerHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: const BoxDecoration(color: MyApp.primaryColor),
//               child: const Text(
//                 "More Features",
//                 style: TextStyle(color: Colors.white, fontSize: 24),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.report_problem, color: Colors.redAccent),
//               title: const Text("Register Complaint"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) =>
//                         ComplaintScreen() ),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.rate_review, color: Colors.orangeAccent),
//               title: const Text("Feedback & Ratings"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) =>
//                           FeedbackScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.language, color: Colors.green),
//               title: const Text("Multilingual Support"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) =>
//                           const EmptyPage(title: "Multilingual Support")),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           // 🔶 Custom Top Header (Inverted Container)
//           Container(
//             height: 250,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [MyApp.primaryColor, Colors.orangeAccent],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//             ),
//             child: Padding(
//               padding:
//                   const EdgeInsets.only(left: 16.0, right: 16.0, top: 40),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Drawer Icon
//                   Builder(
//                     builder: (context) => IconButton(
//                       icon: const Icon(Icons.menu,
//                           color: Colors.white, size: 30),
//                       onPressed: () => Scaffold.of(context).openDrawer(),
//                     ),
//                   ),
//                   // Title + Icon
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: const [SizedBox(height: 15,),
//                       Text(
//                         "BuzBee",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 8),
//                       Icon(Icons.directions_bus,
//                           color: Colors.white, size: 50),
//                       SizedBox(height: 10),
//                       Text(
//                         "Track • Book • Travel Smart",
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(width: 30), // Optional space / empty
//                 ],
//               ),
//             ),
//           ),

//           // 📝 Rest of the page scrollable
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 20),

//                   // Search Field
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: "Search bus, route or stop",
//                         prefixIcon: const Icon(Icons.search),
//                         filled: true,
//                         fillColor: Colors.white,
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 0),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 25),

//                   // Quick Actions
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Text(
//                       "Quick Actions",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   GridView.count(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     crossAxisCount: 3,
//                     childAspectRatio: 1,
//                     crossAxisSpacing: 12,
//                     mainAxisSpacing: 12,
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     children: [
//                       _buildActionCard(
//                         context,
//                         Icons.directions_bus,
//                         "Track Bus",
//                       ),
//                       _buildActionCard(
//                         context,
//                         Icons.confirmation_number,
//                         "Book Ticket",
//                       ),
//                       _buildActionCard(context, Icons.schedule, "Live Timing"),
//                       _buildActionCard(context, Icons.alt_route, "Routes"),
//                       _buildActionCard(
//                         context,
//                         Icons.people,
//                         "Crowd Prediction",
//                       ),
//                       _buildActionCard(context, Icons.notifications, "Alerts"),
//                     ],
//                   ),

//                   const SizedBox(height: 25),

//                   // Wallet Section
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: const [
//                           BoxShadow(
//                               color: Colors.black12,
//                               blurRadius: 5,
//                               offset: Offset(0, 3))
//                         ],
//                       ),
//                       padding: const EdgeInsets.all(16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: const [
//                               Icon(Icons.account_balance_wallet,
//                                   color: MyApp.primaryColor, size: 30),
//                               SizedBox(width: 10),
//                               Text(
//                                 "Wallet Balance",
//                                 style: TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           ),
//                           ElevatedButton(
//                             onPressed: () {},
//                             child: const Text("Recharge"),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 25),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: MyApp.primaryColor,
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.directions_bus), label: "Buses"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.receipt_long), label: "Tickets"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.account_circle), label: "Profile"),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionCard(BuildContext context, IconData icon, String title) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => EmptyPage(title: title)),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: const [
//             BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 32, color: MyApp.primaryColor),
//             const SizedBox(height: 10),
//             Text(title,
//                 textAlign: TextAlign.center,
//                 style:
//                     const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ✨ Empty page template
// class EmptyPage extends StatelessWidget {
//   final String title;
//   const EmptyPage({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: Center(
//         child: Text(
//           "$title Page",
//           style: const TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }


import 'package:buzbee/bookticket.dart';
import 'package:buzbee/complaint.dart';
import 'package:buzbee/fastestroute.dart';
import 'package:buzbee/feedback.dart';
import 'package:buzbee/localtime.dart';
import 'package:buzbee/upi.dart';
import 'package:buzbee/viewbusstop.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const primaryColor = Color(0xFFF07B11);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuzBee',
      theme: ThemeData(
        primaryColor: primaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
        ),
      ),
      home: const PassengerHomePage(),
    );
  }
}

class PassengerHomePage extends StatelessWidget {
  const PassengerHomePage({super.key});

  // ---------------------------------------------------------
  // 🚀 Universal Navigation Handler (Cleaner Routing)
  // ---------------------------------------------------------
  void _navigateAction(BuildContext context, String title) {
    switch (title) {
      case "Track Bus":
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => BusStopsScreen()));
        break;

      case "Book Ticket":
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => BookTicketScreen()));
        break;

      case "Live Timing":
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => BusNotificationsScreen()));
        break;

      case "Routes":
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => FastestRouteScreen()));
        break;

      case "Crowd Prediction":
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => BusStopsScreen()));
        break;

      case "Alerts":
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => BusNotificationsScreen()));
        break;

      default:
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => EmptyPage(title: title)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: MyApp.primaryColor),
              child: const Text(
                "More Features",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            // Complaint Screen
            ListTile(
              leading: const Icon(Icons.report_problem, color: Colors.redAccent),
              title: const Text("Register Complaint"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ComplaintScreen(),
                  ),
                );
              },
            ),

            // Feedback Screen
            ListTile(
              leading: const Icon(Icons.rate_review, color: Colors.orangeAccent),
              title: const Text("Feedback & Ratings"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FeedbackScreen(),
                  ),
                );
              },
            ),

            // Multilingual placeholder
            ListTile(
              leading: const Icon(Icons.language, color: Colors.green),
              title: const Text("Multilingual Support"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const EmptyPage(title: "Multilingual Support"),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // ----------------------------------------------------
      // 🟧 Body UI (unchanged)
      // ----------------------------------------------------
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [MyApp.primaryColor, Colors.orangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu,
                          color: Colors.white, size: 30),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(height: 15),
                      Text(
                        "BuzBee",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Icon(Icons.directions_bus,
                          color: Colors.white, size: 50),
                      SizedBox(height: 10),
                      Text(
                        "Track • Book • Travel Smart",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search bus, route or stop",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Quick Actions title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // --------------------------------------------------
                  // 🔥 Quick Action Grid (with working navigation)
                  // --------------------------------------------------
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildActionCard(context, Icons.directions_bus, "Track Bus"),
                      _buildActionCard(context, Icons.confirmation_number, "Book Ticket"),
                      _buildActionCard(context, Icons.schedule, "Live Timing"),
                      _buildActionCard(context, Icons.alt_route, "Routes"),
                      _buildActionCard(context, Icons.people, "Crowd Prediction"),
                      _buildActionCard(context, Icons.notifications, "Alerts"),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Wallet section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
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
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.account_balance_wallet,
                                  color: MyApp.primaryColor, size: 30),
                              SizedBox(width: 10),
                              Text(
                                "Wallet Balance",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Recharge"),
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ],
      ),

      // ------------------------------------------------------
      // Bottom Nav (unchanged)
      // ------------------------------------------------------
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: MyApp.primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_bus), label: "Buses"),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: "Tickets"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Profile"),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // 🔶 Quick Action UI Builder (kept same)
  // ----------------------------------------------------
  Widget _buildActionCard(BuildContext context, IconData icon, String title) {
    return GestureDetector(
      onTap: () => _navigateAction(context, title),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: MyApp.primaryColor),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------
// Empty Page Template
// -------------------------------------------------------
class EmptyPage extends StatelessWidget {
  final String title;
  const EmptyPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          "$title Page",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
