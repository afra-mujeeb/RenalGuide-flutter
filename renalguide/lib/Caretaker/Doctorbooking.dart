// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:renalguide/Caretaker/register.dart';
// import 'package:renalguide/Staff/login.dart';

// class ViewDoctorsscreen extends StatefulWidget {
//   const ViewDoctorsscreen({super.key});

//   @override
//   State<ViewDoctorsscreen> createState() => _ViewDoctorsscreenState();
// }

// class _ViewDoctorsscreenState extends State<ViewDoctorsscreen> {
//   final Dio dio = Dio();

//   List<Map<String, dynamic>> doctors = [];
//   bool isloading = true;

//   DateTime? selectedDate;
//   TimeOfDay? selectedTime;
//   String? formattedTime;

//   @override
//   void initState() {
//     super.initState();
//     _ViewDoctor();
//   }

//   /// ---------------- VIEW DOCTORS ----------------
//   Future<void> _ViewDoctor() async {
//     try {
//       final response = await dio.get("$baseurl/ViewDoctor");

//       if (response.statusCode == 200 && response.data is List) {
//         setState(() {
//           doctors = List<Map<String, dynamic>>.from(response.data);
//           isloading = false;
//         });
//       }
//     } catch (e) {
//       isloading = false;
//       debugPrint("Error loading doctors: $e");
//     }
//   }

//   /// ---------------- PICK DATE ----------------
//   Future<void> _pickDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2030),
//     );

//     if (picked != null) {
//       setState(() => selectedDate = picked);
//     }
//   }

//   /// ---------------- PICK TIME ----------------
//   Future<void> _pickTime(BuildContext context) async {
//     TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );

//     if (picked != null) {
//       setState(() { selectedTime = picked;
//        formattedTime =
//     "${selectedTime!.hour.toString().padLeft(2, '0')}:"
//     "${selectedTime!.minute.toString().padLeft(2, '0')}";


//       });
//     }
//   }

//   /// ---------------- BOOK DOCTOR ----------------
//   Future<void> _bookDoctor(int doctorId) async {
//     try {
//       await dio.post(
//         "$baseurl/BookDoctor/$lid",
//         data: {
//           "DOCTORID": doctorId,
//           "date":
//               "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
//           "time": formattedTime,
//         },
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Doctor booked successfully")),
//       );
//     } catch (e) {
//       debugPrint("Booking failed: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Doctor booking failed")),
//       );
//     }
//   }

//   /// ---------------- BOOKING DIALOG ----------------
//   void _showBookingDialog(int doctorId) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Select Date & Time"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.calendar_today),
//               title: Text(
//                 selectedDate == null
//                     ? "Select Date"
//                     : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
//               ),
//               onTap: () => _pickDate(context),
//             ),
//             ListTile(
//               leading: const Icon(Icons.access_time),
//               title: Text(
//                 selectedTime == null
//                     ? "Select Time"
//                     : selectedTime!.format(context),
//               ),
//               onTap: () => _pickTime(context),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF2E7D32),
//             ),
//             onPressed: () {
//               if (selectedDate == null || selectedTime == null) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("Select date and time")),
//                 );
//                 return;
//               }
//               Navigator.pop(context);
//               _bookDoctor(doctorId);
//             },
//             child: const Text("Confirm"),
//           ),
//         ],
//       ),
//     );
//   }

//   /// ---------------- UI ----------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text("Doctors"),
//         backgroundColor: const Color(0xFF2E7D32),
//         centerTitle: true,
//       ),
//       body: isloading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: doctors.length,
//               itemBuilder: (context, index) {
//                 final doc = doctors[index];

//                 return Card(
//                   elevation: 3,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                   margin: const EdgeInsets.only(bottom: 16),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Row(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(50),
//                           child: Image.network(
//                             "$baseurl${doc['image']}",
//                             height: 70,
//                             width: 70,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 doc['name'],
//                                 style: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF2E7D32),
//                                 ),
//                               ),
//                               const SizedBox(height: 6),
//                               Text("Sex: ${doc['sex']}"),
//                               Text("Qualification: ${doc['qualification']}"),
//                               Text("Experience: ${doc['experience']}"),
//                               const SizedBox(height: 12),
//                               Align(
//                                 alignment: Alignment.bottomRight,
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor:
//                                         const Color(0xFF2E7D32),
//                                   ),
//                                   onPressed: () {
//                                     selectedDate = null;
//                                     selectedTime = null;
//                                     _showBookingDialog(doc['id']);
//                                   },
//                                   child: const Text("Book"),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:renalguide/Caretaker/register.dart';
import 'package:renalguide/Staff/login.dart';

class ViewDoctorsscreen extends StatefulWidget {
  const ViewDoctorsscreen({super.key});

  @override
  State<ViewDoctorsscreen> createState() => _ViewDoctorsscreenState();
}

class _ViewDoctorsscreenState extends State<ViewDoctorsscreen> {
  final Dio dio = Dio();

  List<Map<String, dynamic>> doctors = [];
  bool isloading = true;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? formattedTime;

  @override
  void initState() {
    super.initState();
    _ViewDoctor();
  }

  /// ---------------- VIEW DOCTORS ----------------
  Future<void> _ViewDoctor() async {
    try {
      final response = await dio.get("$baseurl/ViewDoctor");

      if (response.statusCode == 200 && response.data is List) {
        setState(() {
          doctors = List<Map<String, dynamic>>.from(response.data);
          isloading = false;
        });
      }
    } catch (e) {
      isloading = false;
      debugPrint("Error loading doctors: $e");
    }
  }

  /// ---------------- PICK DATE ----------------
  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  /// ---------------- PICK TIME ----------------
  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() { selectedTime = picked;
       formattedTime =
    "${selectedTime!.hour.toString().padLeft(2, '0')}:"
    "${selectedTime!.minute.toString().padLeft(2, '0')}";


      });
    }
  }

  /// ---------------- BOOK DOCTOR ----------------
  Future<void> _bookDoctor(int doctorId) async {
    try {
      await dio.post(
        "$baseurl/BookDoctor/$lid",
        data: {
          "DOCTORID": doctorId,
          "date":
              "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
          "time": formattedTime,
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Doctor booked successfully")),
      );
    } catch (e) {
      debugPrint("Booking failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Doctor booking failed")),
      );
    }
  }

  /// ---------------- BOOKING DIALOG ----------------
  void _showBookingDialog(int doctorId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Select Date & Time"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                selectedDate == null
                    ? "Select Date"
                    : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
              ),
              onTap: () => _pickDate(context),
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(
                selectedTime == null
                    ? "Select Time"
                    : selectedTime!.format(context),
              ),
              onTap: () => _pickTime(context),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA4C8E1),
            ),
            onPressed: () {
              if (selectedDate == null || selectedTime == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Select date and time")),
                );
                return;
              }
              Navigator.pop(context);
              _bookDoctor(doctorId);
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  /// ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Doctors"),
        backgroundColor: const Color(0xFFA4C8E1),
        centerTitle: true,
      ),
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doc = doctors[index];

                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            "$baseurl${doc['image']}",
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doc['name'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFA4C8E1),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text("Sex: ${doc['sex']}"),
                              Text("Qualification: ${doc['qualification']}"),
                              Text("Experience: ${doc['experience']}"),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFFA4C8E1),
                                  ),
                                  onPressed: () {
                                    selectedDate = null;
                                    selectedTime = null;
                                    _showBookingDialog(doc['id']);
                                  },
                                  child: const Text("Book"),
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