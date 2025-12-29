// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:renalguide/Caretaker/register.dart';
// import 'package:renalguide/Staff/Viewprescriptionfromdr.dart';
// import 'package:renalguide/Staff/viewparameters.dart';
// import 'parameter_form.dart';
// import 'Adddialysiscount.dart';


// class PatientManagementPage extends StatefulWidget {
//   const PatientManagementPage({super.key});

//   @override
//   State<PatientManagementPage> createState() => _PatientManagementPageState();
// }

// class _PatientManagementPageState extends State<PatientManagementPage> {
//   final Dio dio = Dio();

//   bool isLoading = true;
//   int totalPatients = 0;
//   int totalDialysis = 0;

//   List<Map<String, dynamic>> patients = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchPatients();
//   }

//   Future<void> fetchPatients() async {
//     try {
//       final response = await dio.get("$baseurl/ViewAllPatient");
//       print(response.data);

//       setState(() {
//         totalPatients = response.data['patient_count'];
//         totalDialysis = response.data['total_dialysis_count'];

//         patients = List<Map<String, dynamic>>.from(
//           response.data['patients'].map((p) => {
//                 "id": p['id'],
//                 "name": p['name'] ?? "No name",
//                 "age": p['age']?.toString() ?? "-",
//                 "sex": p['sex'] ?? "-",
//                 "diagnosis": p['diagnosis'] ?? "-",
//                 "bloodgroup": p['bloodgroup'] ?? "-",
//                 "completedDialysis": p['dialysis_count'] ?? 0,
//               }),
//         );

//         isLoading = false;
//       });
//     } catch (e) {
//       isLoading = false;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to load patients")),
//       );
//     }
//   }

//   void _updateDialysisCount(int index, int count) {
//     setState(() {
//       patients[index]["completedDialysis"] += count;
//     });
//   }

//   void _deletePatient(int index) {
//     setState(() {
//       patients.removeAt(index);
//       totalPatients--;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F9F4),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF2E7D32),
//         title: const Text(
//           "Patient Management",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 2,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
//               ),
//             )
//           : Column(
//               children: [
//                 // Stats Cards
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: _statCard(
//                           title: "Total Patients",
//                           value: totalPatients.toString(),
//                           icon: Icons.group,
//                           color: Color(0xFF4CAF50),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: _statCard(
//                           title: "Total Dialysis",
//                           value: totalDialysis.toString(),
//                           icon: Icons.medical_services,
//                           color: Color(0xFF2196F3),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Patient List Header
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Patients (${patients.length})",
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF2E7D32),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.refresh,
//                             color: Color(0xFF2E7D32)),
//                         onPressed: fetchPatients,
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Patient List
//                 Expanded(
//                   child: patients.isEmpty
//                       ? Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.people_outline,
//                                 size: 80,
//                                 color: Colors.grey[400],
//                               ),
//                               const SizedBox(height: 16),
//                               Text(
//                                 "No patients found",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       : ListView.builder(
//                           padding: const EdgeInsets.all(16),
//                           itemCount: patients.length,
//                           itemBuilder: (context, index) {
//                             final patient = patients[index];
//                             return _patientCard(patient, index);
//                           },
//                         ),
//                 ),
//               ],
//             ),
//     );
//   }

//   Widget _statCard({
//     required String title,
//     required String value,
//     required IconData icon,
//     required Color color,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   icon,
//                   color: color,
//                   size: 24,
//                 ),
//               ),
//               const Spacer(),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: color,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.grey,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _patientCard(Map<String, dynamic> patient, int index) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // Patient Info
//           ListTile(
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             leading: Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF2E7D32).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: Text(
//                   patient["name"][0].toUpperCase(),
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF2E7D32),
//                   ),
//                 ),
//               ),
//             ),
//             title: Text(
//               patient["name"],
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     _infoChip(
//                       icon: Icons.calendar_today,
//                       text: "${patient["age"]} yrs",
//                     ),
//                     const SizedBox(width: 8),
//                     _infoChip(
//                       icon: Icons.people,
//                       text: patient["sex"],
//                     ),
//                     const SizedBox(width: 8),
//                     _infoChip(
//                       icon: Icons.bloodtype,
//                       text: patient["bloodgroup"],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Diagnosis: ${patient['diagnosis']}",
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.medical_services,
//                       size: 16,
//                       color: Color(0xFF2196F3),
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       "Dialysis Count: ${patient['completedDialysis']}",
//                       style: const TextStyle(
//                         color: Color(0xFF2196F3),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // Action Buttons
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: BoxDecoration(
//               color: Colors.grey[50],
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//                 bottomRight: Radius.circular(20),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 // View Parameters
//                 _actionButton(
//                   icon: Icons.monitor_heart,
//                   label: "Parameters",
//                   color: Color(0xFF4CAF50),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ViewParametersScreen(patientId: patient['id'],),
//                       ),
//                     );
//                   },
//                 ),

//                 // Add Dialysis
//                 _actionButton(
//                   icon: Icons.add_circle,
//                   label: "Add Count",
//                   color: Color(0xFF2196F3),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => AddDialysisCountPage(
//                           onCountAdded: (count) =>
//                               _updateDialysisCount(index, count),
//                           patientId: patient['id'],
//                         ),
//                       ),
//                     );
//                   },
//                 ),

//                 // View Prescription
//                 _actionButton(
//                   icon: Icons.medication,
//                   label: "Prescription",
//                   color: Color(0xFF9C27B0),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ViewPrescriptionFromDrScreen(patientId: patient['id'],
                         
//                         ),
//                       ),
//                     );
//                   },
//                 ),

//                 // Delete
//                 // _actionButton(
//                 //   icon: Icons.delete,
//                 //   label: "Delete",
//                 //   color: Colors.red,
//                 //   onPressed: () {
//                 //     _showDeleteDialog(index, patient["name"]);
//                 //   },
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _infoChip({required IconData icon, required String text}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             size: 12,
//             color: Colors.grey[600],
//           ),
//           const SizedBox(width: 4),
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey[700],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _actionButton({
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onPressed,
//   }) {
//     return Column(
//       children: [
//         IconButton(
//           icon: Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               icon,
//               color: color,
//               size: 22,
//             ),
//           ),
//           onPressed: onPressed,
//         ),
//         const SizedBox(height: 2),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 10,
//             color: color,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }

//   void _showDeleteDialog(int index, String patientName) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Delete Patient",
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Are you sure you want to delete $patientName?"),
//             const SizedBox(height: 8),
//             const Text(
//               "This action cannot be undone.",
//               style: TextStyle(color: Colors.red, fontSize: 12),
//             ),
//           ],
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text(
//               "Cancel",
//               style: TextStyle(color: Colors.grey),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               _deletePatient(index);
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text("$patientName deleted successfully"),
//                   backgroundColor: Colors.red,
//                   behavior: SnackBarBehavior.floating,
//                 ),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Text(
//               "Delete",
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:renalguide/Caretaker/register.dart';
import 'package:renalguide/Staff/Viewprescriptionfromdr.dart';
import 'package:renalguide/Staff/viewparameters.dart';
import 'parameter_form.dart';
import 'Adddialysiscount.dart';


class PatientManagementPage extends StatefulWidget {
  const PatientManagementPage({super.key});

  @override
  State<PatientManagementPage> createState() => _PatientManagementPageState();
}

class _PatientManagementPageState extends State<PatientManagementPage> {
  final Dio dio = Dio();

  bool isLoading = true;
  int totalPatients = 0;
  int totalDialysis = 0;

  List<Map<String, dynamic>> patients = [];

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    try {
      final response = await dio.get("$baseurl/ViewAllPatient");
      print(response.data);

      setState(() {
        totalPatients = response.data['patient_count'];
        totalDialysis = response.data['total_dialysis_count'];

        patients = List<Map<String, dynamic>>.from(
          response.data['patients'].map((p) => {
                "id": p['id'],
                "name": p['name'] ?? "No name",
                "age": p['age']?.toString() ?? "-",
                "sex": p['sex'] ?? "-",
                "diagnosis": p['diagnosis'] ?? "-",
                "bloodgroup": p['bloodgroup'] ?? "-",
                "completedDialysis": p['dialysis_count'] ?? 0,
              }),
        );

        isLoading = false;
      });
    } catch (e) {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load patients")),
      );
    }
  }

  void _updateDialysisCount(int index, int count) {
    setState(() {
      patients[index]["completedDialysis"] += count;
    });
  }

  void _deletePatient(int index) {
    setState(() {
      patients.removeAt(index);
      totalPatients--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7FF), // Changed from #F5F9F4 to #F0F7FF
      appBar: AppBar(
        backgroundColor: const Color(0xFFA4C8E1), // Changed from #2E7D32 to #A4C8E1
        title: const Text(
          "Patient Management",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFA4C8E1)), // Changed to #A4C8E1
              ),
            )
          : Column(
              children: [
                // Stats Cards
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _statCard(
                          title: "Total Patients",
                          value: totalPatients.toString(),
                          icon: Icons.group,
                          color: Color(0xFFA4C8E1), // Changed to theme color
                        ),
                      ),
                     
                    ],
                  ),
                ),

                // Patient List Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Patients (${patients.length})",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C3E50), // Darker text for contrast
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh,
                            color: Color(0xFFA4C8E1)), // Changed to theme color
                        onPressed: fetchPatients,
                      ),
                    ],
                  ),
                ),

                // Patient List
                Expanded(
                  child: patients.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people_outline,
                                size: 80,
                                color: Color(0xFFA4C8E1).withOpacity(0.5),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "No patients found",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: patients.length,
                          itemBuilder: (context, index) {
                            final patient = patients[index];
                            return _patientCard(patient, index);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _patientCard(Map<String, dynamic> patient, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Patient Info
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFA4C8E1).withOpacity(0.1), // Changed to theme color
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  patient["name"][0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFA4C8E1), // Changed to theme color
                  ),
                ),
              ),
            ),
            title: Text(
              patient["name"],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    _infoChip(
                      icon: Icons.calendar_today,
                      text: "${patient["age"]} yrs",
                    ),
                    const SizedBox(width: 8),
                    _infoChip(
                      icon: Icons.people,
                      text: patient["sex"],
                    ),
                    const SizedBox(width: 8),
                    _infoChip(
                      icon: Icons.bloodtype,
                      text: patient["bloodgroup"],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Diagnosis: ${patient['diagnosis']}",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.medical_services,
                      size: 16,
                      color: Color(0xFF7BB4D9), // Changed to complementary blue
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Dialysis Count: ${patient['completedDialysis']}",
                      style: TextStyle(
                        color: Color(0xFF7BB4D9), // Changed to complementary blue
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // View Parameters
                _actionButton(
                  icon: Icons.monitor_heart,
                  label: "Parameters",
                  color: Color(0xFFA4C8E1), // Changed to theme color
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewParametersScreen(patientId: patient['id'],),
                      ),
                    );
                  },
                ),

                // Add Dialysis
                _actionButton(
                  icon: Icons.add_circle,
                  label: "Add Count",
                  color: Color(0xFF7BB4D9), // Complementary blue shade
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddDialysisCountPage(
                          onCountAdded: (count) =>
                              _updateDialysisCount(index, count),
                          patientId: patient['id'],
                        ),
                      ),
                    );
                  },
                ),

                // View Prescription
                _actionButton(
                  icon: Icons.medication,
                  label: "Prescription",
                  color: Color(0xFF8A6EB8), // Purple shade that complements blue
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewPrescriptionFromDrScreen(patientId: patient['id'],
                         
                        ),
                      ),
                    );
                  },
                ),

                // Delete
                // _actionButton(
                //   icon: Icons.delete,
                //   label: "Delete",
                //   color: Colors.red,
                //   onPressed: () {
                //     _showDeleteDialog(index, patient["name"]);
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),
          onPressed: onPressed,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(int index, String patientName) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Patient",
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Are you sure you want to delete $patientName?"),
            const SizedBox(height: 8),
            const Text(
              "This action cannot be undone.",
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _deletePatient(index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("$patientName deleted successfully"),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}