// import 'package:flutter/material.dart';
// import 'package:renalguide/Caretaker/register.dart';
// import 'package:renalguide/Staff/login.dart';

// class ViewSlotHistoryScreen extends StatefulWidget {
//   ViewSlotHistoryScreen({super.key});

//   @override
//   State<ViewSlotHistoryScreen> createState() => _ViewSlotHistoryScreenState();
// }

// class _ViewSlotHistoryScreenState extends State<ViewSlotHistoryScreen> {
//   final Color primaryColor = const Color(0xFF2E7D32);

//   // Dummy slot history data
//   List<Map<String, dynamic>> slotHistory = [];
//   bool isloading=true;

//   Color getStatusColor(String status) {
//     switch (status) {
//       case 'Accepted':
//         return Colors.green;
//       case 'Rejected':
//         return Colors.red;
//       default:
//         return Colors.orange;
//     }
//   }

//   @override
//    void initState() {
//     // TODO: implement initState
//     super.initState();
//     _Viewslothistory();
//   }

//   Future<void> _Viewslothistory() async {
//     try {
//       final response = await dio.get("$baseurl/Slothistory/$lid");
//       print("+++++++++++++, ${response.data}");

//       if (response.statusCode == 200 && response.data is List) {
//         setState(() {
//           slotHistory = List<Map<String, dynamic>>.from(response.data);
//           isloading = false;
//         });
//       }
//     } catch (e) {
//       setState(() => isloading = false);
//       print("Error loading patients: $e");
//     }
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Slot History'),
//         backgroundColor: primaryColor,
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: slotHistory.length,
//         itemBuilder: (context, index) {
//           final slot = slotHistory[index];

//           return Card(
//             elevation: 4,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             margin: const EdgeInsets.only(bottom: 12),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Date: ${slot['date']}',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         'Time: ${slot['time']}',
//                         style: const TextStyle(fontSize: 14),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: getStatusColor(slot['status']!).withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       slot['status']!,
//                       style: TextStyle(
//                         color: getStatusColor(slot['status']!),
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
import 'package:renalguide/Caretaker/register.dart';
import 'package:renalguide/Staff/login.dart';

class ViewSlotHistoryScreen extends StatefulWidget {
  ViewSlotHistoryScreen({super.key});

  @override
  State<ViewSlotHistoryScreen> createState() => _ViewSlotHistoryScreenState();
}

class _ViewSlotHistoryScreenState extends State<ViewSlotHistoryScreen> {
  final Color primaryColor = const Color(0xFFA4C8E1);

  // Dummy slot history data
  List<Map<String, dynamic>> slotHistory = [];
  bool isloading=true;

  Color getStatusColor(String status) {
    switch (status) {
      case 'Accepted':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
   void initState() {
    // TODO: implement initState
    super.initState();
    _Viewslothistory();
  }

  Future<void> _Viewslothistory() async {
    try {
      final response = await dio.get("$baseurl/Slothistory/$lid");
      print("+++++++++++++, ${response.data}");

      if (response.statusCode == 200 && response.data is List) {
        setState(() {
          slotHistory = List<Map<String, dynamic>>.from(response.data);
          isloading = false;
        });
      }
    } catch (e) {
      setState(() => isloading = false);
      print("Error loading patients: $e");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slot History'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: slotHistory.length,
        itemBuilder: (context, index) {
          final slot = slotHistory[index];

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ${slot['date']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Time: ${slot['time']}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: getStatusColor(slot['status']!).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      slot['status']!,
                      style: TextStyle(
                        color: getStatusColor(slot['status']!),
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