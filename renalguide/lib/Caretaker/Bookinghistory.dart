// import 'package:flutter/material.dart';

// class Bookinghistoryscreen extends StatelessWidget {
//   Bookinghistoryscreen({super.key});

//   List<Map<String, dynamic>> history = [
//     {'Date': '10.12.2025', 'Time': '10:00am', 'Status': 'pending'},
//     {'Date': '11.12.2025', 'Time': '11:00am', 'Status': 'accepted'},
//     {'Date': '12.12.2025', 'Time': '12:00pm', 'Status': 'pending'},
//   ];

//   Color getStatusColor(String status) {
//     if (status == 'pending') return Colors.orange;
//     if (status == 'accepted') return Colors.green;
//     return Colors.grey;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],

//       appBar: AppBar(
//         title: const Text(
//           "Booking Slot History",
//           style: TextStyle(
//             color: Colors.white,              // UPDATED TITLE COLOR  
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF2E7D32), // UPDATED COLOR
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white), // BACK ICON WHITE
//       ),

//       body: ListView.builder(
//         padding: const EdgeInsets.all(12),
//         itemCount: history.length,
//         itemBuilder: (context, index) {
//           var item = history[index];

//           return Card(
//             elevation: 3,
//             shadowColor: Colors.grey.withOpacity(0.3),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(18),
//             ),
//             margin: const EdgeInsets.only(bottom: 16),

//             child: Padding(
//               padding: const EdgeInsets.all(16),

//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [

//                   /// LEFT: DATE & TIME
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Date: ${item['Date']}",
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 6),

//                       Text(
//                         "Time: ${item['Time']}",
//                         style: const TextStyle(
//                           fontSize: 15,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ],
//                   ),

//                   /// RIGHT: STATUS BADGE
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: getStatusColor(item['Status']).withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: getStatusColor(item['Status']),
//                         width: 1.5,
//                       ),
//                     ),
//                     child: Text(
//                       item['Status'],
//                       style: TextStyle(
//                         color: getStatusColor(item['Status']),
//                         fontWeight: FontWeight.bold,
//                       ),
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

class Bookinghistoryscreen extends StatelessWidget {
  Bookinghistoryscreen({super.key});

  List<Map<String, dynamic>> history = [
    {'Date': '10.12.2025', 'Time': '10:00am', 'Status': 'pending'},
    {'Date': '11.12.2025', 'Time': '11:00am', 'Status': 'accepted'},
    {'Date': '12.12.2025', 'Time': '12:00pm', 'Status': 'pending'},
  ];

  Color getStatusColor(String status) {
    if (status == 'pending') return Color(0xFFFFB74D); // Orange using theme complementary
    if (status == 'accepted') return Color(0xFF81C784); // Green using theme complementary
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F7FF), // Changed to theme background

      appBar: AppBar(
        title: const Text(
          "Booking Slot History",
          style: TextStyle(
            color: Colors.white,              
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFA4C8E1), // Changed to theme color
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Column(
        children: [
          // Header Card
          Container(
            margin: const EdgeInsets.all(16),
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
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFA4C8E1).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.history_rounded,
                    color: Color(0xFFA4C8E1),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Booking History",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${history.length} booking(s) found",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Status Legend
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildStatusLegend("Pending", Color(0xFFFFB74D)),
                const SizedBox(width: 12),
                _buildStatusLegend("Accepted", Color(0xFF81C784)),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // History List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: history.length,
              itemBuilder: (context, index) {
                var item = history[index];

                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),

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
                      border: Border.all(
                        color: Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          /// LEFT: DATE & TIME
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      size: 16,
                                      color: Color(0xFFA4C8E1),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "Date: ${item['Date']}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF2C3E50),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_rounded,
                                      size: 16,
                                      color: Color(0xFFA4C8E1),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "Time: ${item['Time']}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          /// RIGHT: STATUS BADGE
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: getStatusColor(item['Status']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: getStatusColor(item['Status']),
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              item['Status'].toUpperCase(),
                              style: TextStyle(
                                color: getStatusColor(item['Status']),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusLegend(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
