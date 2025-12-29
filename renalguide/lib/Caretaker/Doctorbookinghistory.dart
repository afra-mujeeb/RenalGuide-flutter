// import 'package:flutter/material.dart';

// class ViewDoctorBookingHistory extends StatelessWidget {
//   ViewDoctorBookingHistory({super.key});

//   // Dummy booking history list
//   List<Map<String, String>> bookings = [
//     {
//       'patient': 'Alice',
//       'appointmentDate': '2025-12-05',
//       'status': 'Accepted',
//       'photo': 'https://www.shutterstock.com/image-photo/healthcare-medical-staff-concept-portrait-600nw-2281024823.jpg'
//     },
//     {
//       'patient': 'Bob',
//       'appointmentDate': '2025-12-06',
//       'status': 'Pending',
//       'photo': 'https://www.shutterstock.com/image-photo/healthcare-medical-staff-concept-portrait-600nw-2281024823.jpg'
//     },
//     {
//       'patient': 'Charlie',
//       'appointmentDate': '2025-12-07',
//       'status': 'Rejected',
//       'photo': 'https://www.shutterstock.com/image-photo/healthcare-medical-staff-concept-portrait-600nw-2281024823.jpg'
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],

//       appBar: AppBar(
//         title: const Text(
//           "Booking History",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF2E7D32),
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),

//       body: ListView.builder(
//         padding: const EdgeInsets.all(12),
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           var booking = bookings[index];

//           Color statusColor;
//           switch (booking['status']) {
//             case 'Accepted':
//               statusColor = Colors.green;
//               break;
//             case 'Pending':
//               statusColor = Colors.orange;
//               break;
//             case 'Rejected':
//               statusColor = Colors.red;
//               break;
//             default:
//               statusColor = Colors.grey;
//           }

//           return Card(
//             elevation: 3,
//             shadowColor: Colors.grey.withOpacity(0.3),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(18),
//             ),
//             margin: const EdgeInsets.only(bottom: 16),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [

//                   /// Patient Photo
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(50),
//                     child: Image.network(
//                       booking['photo']!,
//                       height: 70,
//                       width: 70,
//                       fit: BoxFit.cover,
//                     ),
//                   ),

//                   const SizedBox(width: 16),

//                   /// Details
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [

//                         Text(
//                           booking['patient']!,
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF2E7D32),
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         Text(
//                           "Appointment Date: ${booking['appointmentDate']}",
//                           style: const TextStyle(fontSize: 15),
//                         ),

//                         const SizedBox(height: 4),

//                         Text(
//                           "Status: ${booking['status']}",
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: statusColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class ViewDoctorBookingHistory extends StatelessWidget {
  ViewDoctorBookingHistory({super.key});

  // Dummy booking history list
  List<Map<String, String>> bookings = [
    {
      'patient': 'Alice',
      'appointmentDate': '2025-12-05',
      'status': 'Accepted',
      'photo': 'https://www.shutterstock.com/image-photo/healthcare-medical-staff-concept-portrait-600nw-2281024823.jpg'
    },
    {
      'patient': 'Bob',
      'appointmentDate': '2025-12-06',
      'status': 'Pending',
      'photo': 'https://www.shutterstock.com/image-photo/healthcare-medical-staff-concept-portrait-600nw-2281024823.jpg'
    },
    {
      'patient': 'Charlie',
      'appointmentDate': '2025-12-07',
      'status': 'Rejected',
      'photo': 'https://www.shutterstock.com/image-photo/healthcare-medical-staff-concept-portrait-600nw-2281024823.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text(
          "Booking History",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFA4C8E1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          var booking = bookings[index];

          Color statusColor;
          switch (booking['status']) {
            case 'Accepted':
              statusColor = Colors.green;
              break;
            case 'Pending':
              statusColor = Colors.orange;
              break;
            case 'Rejected':
              statusColor = Colors.red;
              break;
            default:
              statusColor = Colors.grey;
          }

          return Card(
            elevation: 3,
            shadowColor: Colors.grey.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Patient Photo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      booking['photo']!,
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 16),

                  /// Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          booking['patient']!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFA4C8E1),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Appointment Date: ${booking['appointmentDate']}",
                          style: const TextStyle(fontSize: 15),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "Status: ${booking['status']}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}