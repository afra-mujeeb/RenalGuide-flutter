// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:renalguide/Caretaker/AddPatientrecords.dart';
// import 'package:renalguide/Caretaker/Chatwithdoctor.dart';
// import 'package:renalguide/Caretaker/Doctorbooking.dart';
// import 'package:renalguide/Caretaker/Doctorbookinghistory.dart';
// import 'package:renalguide/Caretaker/Viewpatient.dart';
// import 'package:renalguide/Caretaker/Viewprescription.dart';
// import 'package:renalguide/Caretaker/Viewslothistory.dart';
// import 'package:renalguide/Caretaker/Viewslots.dart';
// import 'package:renalguide/Caretaker/caretakerprofile.dart';
// import 'package:renalguide/Caretaker/register.dart';
// import 'package:renalguide/Staff/login.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final Dio dio = Dio();

//   int? completedDialysis;

//   Map<String, dynamic>? patient;
//   bool isloading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchDialysisCount();
//   }

//   Future<void> fetchDialysisCount() async {
//     try {
//       final response = await dio.get("$baseurl/c/$lid");
//       print(response.data);

//       if (response.statusCode == 200) {
//         setState(() {
//           completedDialysis = response.data['count'];
//           isloading = false;
//         });
//       }
//     } catch (e) {
//       print("COUNT ERROR: $e");
//       setState(() => isloading = false);
//     }
//   }

//   Future<void> _HomePage() async {
//     try {
//       final response = await dio.get("$baseurl/ViewPatientAPI/$lid");
//       isloading = true;
//       print(response.data);
//       if (response.statusCode == 200) {
//         setState(() {
//           patient = Map<String, dynamic>.from(response.data);
//           isloading = false;
//         });
//       }
//     } catch (e) {
//       print("Error loading patients: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF0F7FF),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header with gradient
//             Container(
//               height: 180, // Reduced height
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [const Color(0xFFA4C8E1), const Color(0xFFB8D6EB)],
//                 ),
//                 borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 16,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Dialysis Center',
//                               style: TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             const Text(
//                               'Caretaker Dashboard',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pushAndRemoveUntil(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => Loginscreen(),
//                               ),
//                               (route) => false,
//                             );
//                           },
//                           icon: Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.2),
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(
//                               Icons.logout_rounded,
//                               color: Colors.white,
//                               size: 22,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),

//                     // Dialysis Count Card
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(16), // Reduced padding
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.3),
//                           width: 1,
//                         ),
//                       ),
//                       child: Column(children: [
                        
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // Main content area
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(16), // Reduced padding
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Total Dialysis Sessions",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14, // Slightly smaller
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 8), // Reduced spacing
//                     Text(
//                       "$completedDialysis",
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 36, // Reduced font size
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 6), // Reduced spacing
//                     const Text(
//                       "completed sessions",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 12, // Smaller font
//                       ),
//                     ),
//                     const SizedBox(height: 16), // Reduced spacing
//                     // Buttons grid - Compact design with SingleChildScrollView
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             // First row of 2x2 grid
//                             GridView.count(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               crossAxisCount: 2,
//                               mainAxisSpacing: 12,
//                               crossAxisSpacing: 12,
//                               childAspectRatio:
//                                   1.1, // Slightly smaller aspect ratio
//                               children: [
//                                 _buildActionCard(
//                                   icon: Icons.person_add_rounded,
//                                   title: "Add & Manage Patient",
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             CaretakerPatientPage(),
//                                       ),
//                                     );
//                                   },
//                                   color: Color(0xFFA4C8E1),
//                                 ),
//                                 _buildActionCard(
//                                   icon: Icons.schedule_rounded,
//                                   title: "View Slot Availability",
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => BookingPage(),
//                                       ),
//                                     );
//                                   },
//                                   color: Color(0xFF7BB4D9),
//                                 ),
//                                 _buildActionCard(
//                                   icon: Icons.history_rounded,
//                                   title: "View Slot History",
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             ViewSlotHistoryScreen(),
//                                       ),
//                                     );
//                                   },
//                                   color: Color(0xFF8A6EB8),
//                                 ),
//                                 _buildActionCard(
//                                   icon: Icons.medical_services_rounded,
//                                   title: "Book Doctor",
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             ViewDoctorsscreen(),
//                                       ),
//                                     );
//                                   },
//                                   color: Color(0xFF64B5F6),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 12),

//                             // Second row of 2x2 grid
//                             GridView.count(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               crossAxisCount: 2,
//                               mainAxisSpacing: 12,
//                               crossAxisSpacing: 12,
//                               childAspectRatio: 1.1,
//                               children: [
//                                 _buildActionCard(
//                                   icon: Icons.history_toggle_off_rounded,
//                                   title: "Doctor Booking History",
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             ViewDoctorBookingHistory(),
//                                       ),
//                                     );
//                                   },
//                                   color: Color(0xFF7BB4D9),
//                                 ),
//                                 _buildActionCard(
//                                   icon: Icons.chat_rounded,
//                                   title: "Chat with Doctor",
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => ChatScreen(
//                                           caretakerName: '',
//                                           doctorName: '',
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   color: Color(0xFF4FC3F7),
//                                 ),
//                                 _buildActionCard(
//                                   icon: Icons.receipt_long_rounded,
//                                   title: "View Prescriptions",
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             Viewprescriptionscreen(),
//                                       ),
//                                     );
//                                   },
//                                   color: Color(0xFF81C784),
//                                 ),
//                                 _buildActionCard(
//                                   icon: Icons.person_rounded,
//                                   title: "View Profile",
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             CaretakerProfilePage(),
//                                       ),
//                                     );
//                                   },
//                                   color: Color(0xFFFFB74D),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 12),

//                             // Single centered card for the 9th item
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 6,
//                               ),
//                               child: _buildActionCard(
//                                 icon: Icons.medical_information_rounded,
//                                 title: "Add Patient Records",
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           AddPatientRecordsPage(),
//                                     ),
//                                   );
//                                 },
//                                 color: Color(0xFF4DB6AC),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildActionCard({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     required Color color,
//   }) {
//     return Material(
//       elevation: 0,
//       borderRadius: BorderRadius.circular(16),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(16),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.blueGrey.withOpacity(0.1),
//                 blurRadius: 8, // Reduced blur
//                 offset: const Offset(0, 3), // Reduced offset
//               ),
//             ],
//             border: Border.all(color: Colors.grey[200]!, width: 1),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(12), // Reduced padding
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10), // Reduced padding
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     icon,
//                     size: 24, // Reduced icon size
//                     color: color,
//                   ),
//                 ),
//                 const SizedBox(height: 8), // Reduced spacing
//                 Text(
//                   title,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 12, // Smaller font
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF2C3E50),
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:renalguide/Caretaker/AddPatientrecords.dart';
import 'package:renalguide/Caretaker/Chatwithdoctor.dart';
import 'package:renalguide/Caretaker/Doctorbooking.dart';
import 'package:renalguide/Caretaker/Doctorbookinghistory.dart';
import 'package:renalguide/Caretaker/Viewpatient.dart';
import 'package:renalguide/Caretaker/Viewprescription.dart';
import 'package:renalguide/Caretaker/Viewslothistory.dart';
import 'package:renalguide/Caretaker/Viewslots.dart';
import 'package:renalguide/Caretaker/caretakerprofile.dart';
import 'package:renalguide/Caretaker/register.dart';
import 'package:renalguide/Staff/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Dio dio = Dio();

  int? completedDialysis;

  Map<String, dynamic>? patient;
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    fetchDialysisCount();
  }

  Future<void> fetchDialysisCount() async {
    try {
      final response = await dio.get("$baseurl/c/$lid");
      print(response.data);

      if (response.statusCode == 200) {
        setState(() {
          completedDialysis = response.data['count'];
          isloading = false;
        });
      }
    } catch (e) {
      print("COUNT ERROR: $e");
      setState(() => isloading = false);
    }
  }

  Future<void> _HomePage() async {
    try {
      final response = await dio.get("$baseurl/ViewPatientAPI/$lid");
      isloading = true;
      print(response.data);
      if (response.statusCode == 200) {
        setState(() {
          patient = Map<String, dynamic>.from(response.data);
          isloading = false;
        });
      }
    } catch (e) {
      print("Error loading patients: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7FF),
      body: SafeArea(
        child: Column(
          children: [
            // Header with gradient
            Container(
              height: 140, // Further reduced
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFFA4C8E1), const Color(0xFFB8D6EB)],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Dialysis Center',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Caretaker Dashboard',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Loginscreen(),
                              ),
                              (route) => false,
                            );
                          },
                          icon: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.logout_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // Main content area
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Attractive Circular Dialysis Session Display
                      _buildWaterFlowDialysisCircle(),
                      const SizedBox(height: 20),

                      // Quick Actions Title
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Quick Actions",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Access all caretaker features",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Buttons grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.1,
                        children: [
                          _buildActionCard(
                            icon: Icons.person_add_rounded,
                            title: "Add & Manage Patient",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CaretakerPatientPage(),
                                ),
                              );
                            },
                            color: Color(0xFFA4C8E1),
                          ),
                          _buildActionCard(
                            icon: Icons.schedule_rounded,
                            title: "View Slot Availability",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingPage(),
                                ),
                              );
                            },
                            color: Color(0xFF7BB4D9),
                          ),
                          _buildActionCard(
                            icon: Icons.history_rounded,
                            title: "View Slot History",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewSlotHistoryScreen(),
                                ),
                              );
                            },
                            color: Color(0xFF8A6EB8),
                          ),
                          _buildActionCard(
                            icon: Icons.medical_services_rounded,
                            title: "Book Doctor",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewDoctorsscreen(),
                                ),
                              );
                            },
                            color: Color(0xFF64B5F6),
                          ),
                          _buildActionCard(
                            icon: Icons.history_toggle_off_rounded,
                            title: "Booking History",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ViewDoctorBookingHistory(),
                                ),
                              );
                            },
                            color: Color(0xFF7BB4D9),
                          ),
                          _buildActionCard(
                            icon: Icons.chat_rounded,
                            title: "Chat with Doctor",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                    caretakerName: '',
                                    doctorName: '',
                                  ),
                                ),
                              );
                            },
                            color: Color(0xFF4FC3F7),
                          ),
                          _buildActionCard(
                            icon: Icons.receipt_long_rounded,
                            title: "View Prescriptions",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Viewprescriptionscreen(),
                                ),
                              );
                            },
                            color: Color(0xFF81C784),
                          ),
                          _buildActionCard(
                            icon: Icons.person_rounded,
                            title: "View Profile",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CaretakerProfilePage(),
                                ),
                              );
                            },
                            color: Color(0xFFFFB74D),
                          ),
                            _buildActionCard(
                        icon: Icons.medical_information_rounded,
                        title: "Add Patient Records",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPatientRecordsPage(),
                            ),
                          );
                        },
                        color: Color(0xFF4DB6AC),
                      ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // 9th item - Full width
                    
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterFlowDialysisCircle() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            const Color(0xFFA4C8E1).withOpacity(0.8),
            const Color(0xFF7BB4D9).withOpacity(0.6),
            const Color(0xFF4DB6AC).withOpacity(0.4),
          ],
          stops: [0.1, 0.6, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA4C8E1).withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated water waves
          _buildWaterWaves(),
          
          // Outer ring
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 2,
              ),
            ),
          ),
          
          // Middle ring
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
          ),
          
          // Center content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                completedDialysis?.toString() ?? '0',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black26,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Sessions",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                "Completed",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          
          // Drops around the circle
          Positioned(
            top: 20,
            left: 90,
            child: _buildWaterDrop(),
          ),
          Positioned(
            top: 50,
            right: 30,
            child: _buildWaterDrop(),
          ),
          Positioned(
            bottom: 50,
            left: 30,
            child: _buildWaterDrop(),
          ),
          Positioned(
            bottom: 20,
            right: 90,
            child: _buildWaterDrop(),
          ),
        ],
      ),
    );
  }

  Widget _buildWaterWaves() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.transparent,
          ],
          stops: [0.3, 1.0],
        ),
      ),
    );
  }

  Widget _buildWaterDrop() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.8),
            const Color(0xFFA4C8E1).withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA4C8E1).withOpacity(0.5),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(color: Colors.grey[200]!, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 24,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}