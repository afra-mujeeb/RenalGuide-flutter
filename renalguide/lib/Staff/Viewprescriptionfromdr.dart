// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:renalguide/Caretaker/register.dart';

// class ViewPrescriptionFromDrScreen extends StatefulWidget {
//   final int patientId;
//   const ViewPrescriptionFromDrScreen({super.key, required this.patientId});

//   @override
//   State<ViewPrescriptionFromDrScreen> createState() =>
//       _ViewPrescriptionFromDrScreenState();
// }

// class _ViewPrescriptionFromDrScreenState
//     extends State<ViewPrescriptionFromDrScreen> {
//   final Dio dio = Dio();
//   List prescriptions = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchPrescriptions();
//   }

//   // ================= API =================
//   Future<void> fetchPrescriptions() async {
//     try {
//       final response = await dio.get(
//         "$baseurl/prescription/${widget.patientId}",
//       );
//       print(response.data);

//       setState(() {
//         prescriptions = response.data;
//         loading = false;
//       });
//     } catch (e) {
//       loading = false;
//       debugPrint("Error: $e");
//     }
//   }

//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFD6FFC1),
//       appBar: AppBar(
//         title: const Text(
//           'View Prescriptions',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color(0xFF2E7D32),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : prescriptions.isEmpty
//               ? const Center(child: Text("No prescriptions found"))
//               : SingleChildScrollView(
//                   padding: const EdgeInsets.all(16),
//                   child: Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30),
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 20,
//                           offset: const Offset(0, 10),
//                           color: Colors.black.withOpacity(0.1),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Prescriptions",
//                           style: TextStyle(
//                             fontSize: 26,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         ...prescriptions.map((p) {
//                           return Card(
//                             margin: const EdgeInsets.only(bottom: 12),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             elevation: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.all(16),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Doctor: ${p['name']}",
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     "Prescription Date: ${p['presdate'].toString().split(' ')[0]}",
//                                     style: const TextStyle(fontSize: 14),
//                                   ),
//                                   const SizedBox(height: 2),
//                                   Text(
//                                     "Appointment Date: ${p['date']}",
//                                     style: const TextStyle(fontSize: 14),
//                                   ),
//                                   const Divider(height: 20),
//                                   Text(
//                                     "Prescription:",
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     p['prescription'],
//                                     style: const TextStyle(fontSize: 14),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ],
//                     ),
//                   ),
//                 ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:renalguide/Caretaker/register.dart';

class ViewPrescriptionFromDrScreen extends StatefulWidget {
  final int patientId;
  const ViewPrescriptionFromDrScreen({super.key, required this.patientId});

  @override
  State<ViewPrescriptionFromDrScreen> createState() =>
      _ViewPrescriptionFromDrScreenState();
}

class _ViewPrescriptionFromDrScreenState
    extends State<ViewPrescriptionFromDrScreen> {
  final Dio dio = Dio();
  List prescriptions = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchPrescriptions();
  }

  // ================= API =================
  Future<void> fetchPrescriptions() async {
    try {
      final response = await dio.get(
        "$baseurl/prescription/${widget.patientId}",
      );
      print(response.data);

      setState(() {
        prescriptions = response.data;
        loading = false;
      });
    } catch (e) {
      loading = false;
      debugPrint("Error: $e");
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7FF), // Changed from #D6FFC1 to #F0F7FF
      appBar: AppBar(
        title: const Text(
          'View Prescriptions',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFA4C8E1), // Changed from #2E7D32 to #A4C8E1
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xFFA4C8E1), // Changed to theme color
              ),
            )
          : prescriptions.isEmpty
              ? const Center(child: Text("No prescriptions found"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.medication_rounded,
                                  color: Color(0xFFA4C8E1),
                                  size: 28,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  "Patient Prescriptions",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2C3E50),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${prescriptions.length} prescription(s) found",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...prescriptions.map((p) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                          child: Container(
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
                              border: Border.all(
                                color: Colors.grey[200]!,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header with doctor info
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFA4C8E1).withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.medical_services_rounded,
                                          color: Color(0xFFA4C8E1),
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Dr. ${p['name']}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color(0xFF2C3E50),
                                              ),
                                            ),
                                            Text(
                                              "Medical Consultant",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 16),
                                  
                                  // Dates section
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildDateItem(
                                          icon: Icons.calendar_today_rounded,
                                          label: "Prescription Date",
                                          date: p['presdate'].toString().split(' ')[0],
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 40,
                                        color: Colors.grey[300],
                                        margin: const EdgeInsets.symmetric(horizontal: 12),
                                      ),
                                      Expanded(
                                        child: _buildDateItem(
                                          icon: Icons.date_range_rounded,
                                          label: "Appointment Date",
                                          date: p['date'],
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  const Divider(height: 24),
                                  
                                  // Prescription content
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFA4C8E1).withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(0xFFA4C8E1).withOpacity(0.2),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.description_rounded,
                                              color: Color(0xFFA4C8E1),
                                              size: 18,
                                            ),
                                            const SizedBox(width: 8),
                                            const Text(
                                              "Prescription Details",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF2C3E50),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          p['prescription'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildDateItem({required IconData icon, required String label, required String date}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: Color(0xFFA4C8E1),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
      ],
    );
  }
}
