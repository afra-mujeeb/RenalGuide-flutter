import 'package:flutter/material.dart';

class Bookinghistoryscreen extends StatelessWidget {
  Bookinghistoryscreen({super.key});

  List<Map<String, dynamic>> history = [
    {'Date': '10.12.2025', 'Time': '10:00am', 'Status': 'pending'},
    {'Date': '11.12.2025', 'Time': '11:00am', 'Status': 'accepted'},
    {'Date': '12.12.2025', 'Time': '12:00pm', 'Status': 'pending'},
  ];

  Color getStatusColor(String status) {
    if (status == 'pending') return Colors.orange;
    if (status == 'accepted') return Colors.green;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text(
          "Booking Slot History",
          style: TextStyle(
            color: Colors.white,              // UPDATED TITLE COLOR  
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32), // UPDATED COLOR
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), // BACK ICON WHITE
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: history.length,
        itemBuilder: (context, index) {
          var item = history[index];

          return Card(
            elevation: 3,
            shadowColor: Colors.grey.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            margin: const EdgeInsets.only(bottom: 16),

            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /// LEFT: DATE & TIME
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date: ${item['Date']}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "Time: ${item['Time']}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  /// RIGHT: STATUS BADGE
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: getStatusColor(item['Status']).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: getStatusColor(item['Status']),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      item['Status'],
                      style: TextStyle(
                        color: getStatusColor(item['Status']),
                        fontWeight: FontWeight.bold,
                      ),
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
