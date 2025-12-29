// import 'package:flutter/material.dart';

// class Viewprescriptionscreen extends StatelessWidget {
//   const Viewprescriptionscreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Dummy list of prescriptions with appointment date
//     final List<Map<String, String>> prescriptions = [
//       {
//         'doctor': 'Dr. John Doe',
//         'patient': 'Alice',
//         'date': '2025-12-01',
//         'appointment': '2025-12-05',
//         'details': 'Take 1 tablet of Paracetamol after meals daily.'
//       },
//       {
//         'doctor': 'Dr. Jane Smith',
//         'patient': 'Bob',
//         'date': '2025-12-02',
//         'appointment': '2025-12-06',
//         'details': 'Apply ointment twice a day for 7 days.'
//       },
//       {
//         'doctor': 'Dr. Robert Brown',
//         'patient': 'Charlie',
//         'date': '2025-12-03',
//         'appointment': '2025-12-07',
//         'details': 'Take 2 capsules of Vitamin C daily.'
//       },
//     ];

//     return Scaffold(
//       backgroundColor: const Color(0xFFD6FFC1), // Soft green background
//       appBar: AppBar(
//         title: const Text(
//           'View Prescriptions',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color(0xFF2E7D32),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(30),
//               boxShadow: [
//                 BoxShadow(
//                   blurRadius: 20,
//                   offset: const Offset(0, 10),
//                   color: Colors.black.withOpacity(0.1),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Prescriptions",
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ...prescriptions.map((prescription) {
//                   return Card(
//                     margin: const EdgeInsets.only(bottom: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     elevation: 3,
//                     color: Colors.white, // Changed to white
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Doctor: ${prescription['doctor']}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             'Patient: ${prescription['patient']}',
//                             style: const TextStyle(fontSize: 14),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             'Prescription Date: ${prescription['date']}',
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             'Appointment Date: ${prescription['appointment']}',
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Prescription: ${prescription['details']}',
//                             style: const TextStyle(fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class Viewprescriptionscreen extends StatelessWidget {
  const Viewprescriptionscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy list of prescriptions with appointment date
    final List<Map<String, String>> prescriptions = [
      {
        'doctor': 'Dr. John Doe',
        'patient': 'Alice',
        'date': '2025-12-01',
        'appointment': '2025-12-05',
        'details': 'Take 1 tablet of Paracetamol after meals daily.'
      },
      {
        'doctor': 'Dr. Jane Smith',
        'patient': 'Bob',
        'date': '2025-12-02',
        'appointment': '2025-12-06',
        'details': 'Apply ointment twice a day for 7 days.'
      },
      {
        'doctor': 'Dr. Robert Brown',
        'patient': 'Charlie',
        'date': '2025-12-03',
        'appointment': '2025-12-07',
        'details': 'Take 2 capsules of Vitamin C daily.'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFD6FFC1), // Soft green background
      appBar: AppBar(
        title: const Text(
          'View Prescriptions',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFA4C8E1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Prescriptions",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ...prescriptions.map((prescription) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    color: Colors.white, // Changed to white
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Doctor: ${prescription['doctor']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Patient: ${prescription['patient']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Prescription Date: ${prescription['date']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Appointment Date: ${prescription['appointment']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Prescription: ${prescription['details']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}