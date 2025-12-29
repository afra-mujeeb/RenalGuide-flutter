// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:dio/dio.dart';
// import 'package:intl/intl.dart';
// import 'package:renalguide/Caretaker/register.dart';
// import 'package:renalguide/Staff/login.dart';

// class AddPatientRecordsPage extends StatefulWidget {
//   const AddPatientRecordsPage({super.key});

//   @override
//   State<AddPatientRecordsPage> createState() => _AddPatientRecordsPageState();
// }

// class _AddPatientRecordsPageState extends State<AddPatientRecordsPage> {
//   final ImagePicker _picker = ImagePicker();
//   final Dio _dio = Dio();

//   final TextEditingController doctorController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();

//   DateTime? selectedDate;
//   List<File> selectedImages = [];
//   List<Map<String, dynamic>> uploadedRecords = [];

//   bool isUploading = false;
//   bool isLoadingRecords = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchUploadedRecords();
//   }

//   InputDecoration _inputStyle(String label) {
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: Colors.white,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }

//   /// PICK IMAGES
//   Future<void> pickImages() async {
//     final images = await _picker.pickMultiImage();
//     if (images != null) {
//       setState(() {
//         selectedImages.addAll(images.map((e) => File(e.path)));
//       });
//     }
//   }

//   /// UPLOAD RECORDS
//   Future<void> uploadRecords() async {
//     if (doctorController.text.isEmpty ||
//         descriptionController.text.isEmpty ||
//         selectedDate == null ||
//         selectedImages.isEmpty) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("Fill all fields")));
//       return;
//     }

//     setState(() => isUploading = true);

//     try {
//       List<MultipartFile> files = [];
//       for (var img in selectedImages) {
//         files.add(await MultipartFile.fromFile(img.path));
//       }

//       FormData formData = FormData.fromMap({
//         "record": files,
//         "DoctorName": doctorController.text,
//         "Dateofconsultation":
//             DateFormat('yyyy-MM-dd').format(selectedDate!),
//         "Description": descriptionController.text,
//       });

//       await _dio.post("$baseurl/addrecord/$lid", data: formData);

//       doctorController.clear();
//       descriptionController.clear();
//       selectedImages.clear();
//       selectedDate = null;

//       fetchUploadedRecords();
//     } finally {
//       setState(() => isUploading = false);
//     }
//   }

//   /// FETCH RECORDS
//   Future<void> fetchUploadedRecords() async {
//     final response = await _dio.get("$baseurl/addrecord/$lid");
//     final List data = response.data;

//     setState(() {
//       uploadedRecords = data.map<Map<String, dynamic>>((e) {
//         return {
//           "id": e['id'],
//           "record": "$baseurl${e['record']}",
//           "doctor": e['DoctorName'] ?? "Not specified",
//           "date": e['Dateofconsultation'] ?? "Not specified",
//           "desc": e['Description'] ?? "No description",
//         };
//       }).toList();
//       isLoadingRecords = false;
//     });
//   }

//   /// DELETE RECORD
//   Future<void> deleteRecord(int id) async {
//     await _dio.delete("$baseurl/deleterecord/$id");
//     fetchUploadedRecords();
//   }

//   /// FULL IMAGE VIEW + DETAILS
//   void showRecordDetails(Map<String, dynamic> r) {
//     showDialog(
//       context: context,
//       builder: (_) => Dialog(
//         insetPadding: const EdgeInsets.all(10),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             InteractiveViewer(
//               child: Image.network(
//                 r['record'],
//                 fit: BoxFit.contain,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Doctor: ${r['doctor']}",
//                       style: const TextStyle(fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 4),
//                   Text("Date: ${r['date']}"),
//                   const SizedBox(height: 6),
//                   const Text("Description:",
//                       style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text(r['desc']),
//                   const SizedBox(height: 10),

//                   /// DELETE BUTTON
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                       ),
//                       onPressed: () {
//                         Navigator.pop(context);
//                         deleteRecord(r['id']);
//                       },
//                       icon: const Icon(Icons.delete),
//                       label: const Text("Delete Record"),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F6F8),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF2E7D32),
//         title: const Text("Patient Records"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//                 controller: doctorController,
//                 decoration: _inputStyle("Doctor Name")),
//             const SizedBox(height: 10),

//             GestureDetector(
//               onTap: () async {
//                 final d = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime.now(),
//                 );
//                 if (d != null) setState(() => selectedDate = d);
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(14),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 child: Text(selectedDate == null
//                     ? "Select Date"
//                     : DateFormat('yyyy-MM-dd').format(selectedDate!)),
//               ),
//             ),

//             const SizedBox(height: 10),

//             TextField(
//               controller: descriptionController,
//               maxLines: 3,
//               decoration: _inputStyle("Description"),
//             ),

//             const SizedBox(height: 10),

//             ElevatedButton.icon(
//               onPressed: pickImages,
//               icon: const Icon(Icons.upload),
//               label: const Text("Pick Images"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF2E7D32),
//               ),
//             ),

//             const SizedBox(height: 10),

//             Expanded(
//               child: isLoadingRecords
//                   ? const Center(child: CircularProgressIndicator())
//                   : GridView.builder(
//                       itemCount: uploadedRecords.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 8,
//                         mainAxisSpacing: 8,
//                       ),
//                       itemBuilder: (_, i) {
//                         final r = uploadedRecords[i];
//                         return GestureDetector(
//                           onTap: () => showRecordDetails(r),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: Image.network(
//                               r['record'],
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),

//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: isUploading ? null : uploadRecords,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF2E7D32),
//                 ),
//                 child: const Text("Save Records"),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:dio/dio.dart';
// import 'package:intl/intl.dart';
// import 'package:renalguide/Caretaker/register.dart';
// import 'package:renalguide/Staff/login.dart';

// class AddPatientRecordsPage extends StatefulWidget {
//   const AddPatientRecordsPage({super.key});

//   @override
//   State<AddPatientRecordsPage> createState() => _AddPatientRecordsPageState();
// }

// class _AddPatientRecordsPageState extends State<AddPatientRecordsPage> {
//   final ImagePicker _picker = ImagePicker();
//   final Dio _dio = Dio();

//   final TextEditingController doctorController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();

//   DateTime? selectedDate;
//   List<File> selectedImages = [];
//   List<Map<String, dynamic>> uploadedRecords = [];

//   bool isUploading = false;
//   bool isLoadingRecords = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchUploadedRecords();
//   }

//   InputDecoration _inputStyle(String label) {
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: Colors.white,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide(color: Colors.grey[300]!),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide(color: Colors.grey[300]!),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide(
//           color: Color(0xFFA4C8E1),
//           width: 2,
//         ),
//       ),
//       prefixIcon: Container(
//         margin: const EdgeInsets.only(right: 12),
//         child: Icon(
//           label == "Doctor Name" ? Icons.person_rounded : Icons.description_rounded,
//           color: Color(0xFFA4C8E1),
//         ),
//       ),
//     );
//   }

//   /// PICK IMAGES
//   Future<void> pickImages() async {
//     final images = await _picker.pickMultiImage();
//     if (images != null) {
//       setState(() {
//         selectedImages.addAll(images.map((e) => File(e.path)));
//       });
//     }
//   }

//   /// UPLOAD RECORDS
//   Future<void> uploadRecords() async {
//     if (doctorController.text.isEmpty ||
//         descriptionController.text.isEmpty ||
//         selectedDate == null ||
//         selectedImages.isEmpty) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(
//             content: Text("Fill all fields"),
//             backgroundColor: Color(0xFFA4C8E1),
//           ));
//       return;
//     }

//     setState(() => isUploading = true);

//     try {
//       List<MultipartFile> files = [];
//       for (var img in selectedImages) {
//         files.add(await MultipartFile.fromFile(img.path));
//       }

//       FormData formData = FormData.fromMap({
//         "record": files,
//         "DoctorName": doctorController.text,
//         "Dateofconsultation":
//             DateFormat('yyyy-MM-dd').format(selectedDate!),
//         "Description": descriptionController.text,
//       });

//       await _dio.post("$baseurl/addrecord/$lid", data: formData);

//       doctorController.clear();
//       descriptionController.clear();
//       selectedImages.clear();
//       selectedDate = null;

//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(
//             content: Text("Records uploaded successfully"),
//             backgroundColor: Color(0xFFA4C8E1),
//           ));

//       fetchUploadedRecords();
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(
//             content: Text("Upload failed: $e"),
//             backgroundColor: Colors.red,
//           ));
//     } finally {
//       setState(() => isUploading = false);
//     }
//   }

//   /// FETCH RECORDS
//   Future<void> fetchUploadedRecords() async {
//     try {
//       final response = await _dio.get("$baseurl/addrecord/$lid");
//       final List data = response.data;

//       setState(() {
//         uploadedRecords = data.map<Map<String, dynamic>>((e) {
//           return {
//             "id": e['id'],
//             "record": "$baseurl${e['record']}",
//             "doctor": e['DoctorName'] ?? "Not specified",
//             "date": e['Dateofconsultation'] ?? "Not specified",
//             "desc": e['Description'] ?? "No description",
//           };
//         }).toList();
//         isLoadingRecords = false;
//       });
//     } catch (e) {
//       print("Error fetching records: $e");
//       setState(() => isLoadingRecords = false);
//     }
//   }

//   /// DELETE RECORD
//   Future<void> deleteRecord(int id) async {
//     try {
//       await _dio.delete("$baseurl/deleterecord/$id");
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(
//             content: Text("Record deleted successfully"),
//             backgroundColor: Color(0xFFA4C8E1),
//           ));
//       fetchUploadedRecords();
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(
//             content: Text("Delete failed"),
//             backgroundColor: Colors.red,
//           ));
//     }
//   }

//   /// FULL IMAGE VIEW + DETAILS
//   void showRecordDetails(Map<String, dynamic> r) {
//     showDialog(
//       context: context,
//       builder: (_) => Dialog(
//         insetPadding: const EdgeInsets.all(10),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Color(0xFFA4C8E1),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   topRight: Radius.circular(16),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Record Details",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.close, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     InteractiveViewer(
//                       child: Image.network(
//                         r['record'],
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(Icons.person_rounded, color: Color(0xFFA4C8E1), size: 18),
//                               const SizedBox(width: 8),
//                               Text("Doctor: ${r['doctor']}",
//                                   style: const TextStyle(fontWeight: FontWeight.bold)),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: [
//                               Icon(Icons.calendar_today_rounded, color: Color(0xFFA4C8E1), size: 18),
//                               const SizedBox(width: 8),
//                               Text("Date: ${r['date']}"),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           const Text("Description:",
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                           const SizedBox(height: 4),
//                           Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: Color(0xFFA4C8E1).withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(r['desc']),
//                           ),
//                           const SizedBox(height: 16),

//                           /// DELETE BUTTON
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton.icon(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.red,
//                                 padding: const EdgeInsets.symmetric(vertical: 14),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 Navigator.pop(context);
//                                 deleteRecord(r['id']);
//                               },
//                               icon: const Icon(Icons.delete_rounded),
//                               label: const Text("Delete Record"),
//                             ),
//                           )
//                         ],
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF0F7FF), // Changed to theme background
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFA4C8E1), // Changed to theme color
//         title: const Text(
//           "Patient Records",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Form Section
//             Card(
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     const Text(
//                       "Upload New Record",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF2C3E50),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       controller: doctorController,
//                       decoration: _inputStyle("Doctor Name"),
//                     ),
//                     const SizedBox(height: 12),

//                     // Date Picker
//                     GestureDetector(
//                       onTap: () async {
//                         final d = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime.now(),
//                           builder: (context, child) => Theme(
//                             data: ThemeData(
//                               colorScheme: const ColorScheme.light(primary: Color(0xFFA4C8E1)),
//                             ),
//                             child: child!,
//                           ),
//                         );
//                         if (d != null) setState(() => selectedDate = d);
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(14),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(14),
//                           border: Border.all(
//                             color: Colors.grey[300]!,
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(Icons.calendar_today_rounded, color: Color(0xFFA4C8E1)),
//                             const SizedBox(width: 12),
//                             Text(
//                               selectedDate == null
//                                   ? "Select Consultation Date"
//                                   : DateFormat('yyyy-MM-dd').format(selectedDate!),
//                               style: TextStyle(
//                                 color: selectedDate == null ? Colors.grey : Colors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     TextField(
//                       controller: descriptionController,
//                       maxLines: 3,
//                       decoration: InputDecoration(
//                         labelText: "Description",
//                         filled: true,
//                         fillColor: Colors.white,
//                         prefixIcon: Container(
//                           margin: const EdgeInsets.only(right: 12),
//                           child: Icon(Icons.description_rounded, color: Color(0xFFA4C8E1)),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide(color: Colors.grey[300]!),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide(color: Colors.grey[300]!),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide(
//                             color: Color(0xFFA4C8E1),
//                             width: 2,
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     ElevatedButton.icon(
//                       onPressed: pickImages,
//                       icon: Icon(Icons.upload_rounded, color: Colors.white),
//                       label: const Text("Pick Images"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFA4C8E1), // Changed to theme color
//                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),

//             // Uploaded Records Section
//             Expanded(
//               child: Card(
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Uploaded Records",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF2C3E50),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "${uploadedRecords.length} record(s) found",
//                         style: const TextStyle(
//                           color: Colors.grey,
//                           fontSize: 14,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Expanded(
//                         child: isLoadingRecords
//                             ? const Center(
//                                 child: CircularProgressIndicator(
//                                   color: Color(0xFFA4C8E1),
//                                 ),
//                               )
//                             : uploadedRecords.isEmpty
//                                 ? Center(
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.photo_library_rounded,
//                                           size: 60,
//                                           color: Colors.grey[400],
//                                         ),
//                                         const SizedBox(height: 12),
//                                         const Text(
//                                           "No records uploaded yet",
//                                           style: TextStyle(
//                                             color: Colors.grey,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 : GridView.builder(
//                                     itemCount: uploadedRecords.length,
//                                     gridDelegate:
//                                         const SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 3,
//                                       crossAxisSpacing: 8,
//                                       mainAxisSpacing: 8,
//                                     ),
//                                     itemBuilder: (_, i) {
//                                       final r = uploadedRecords[i];
//                                       return GestureDetector(
//                                         onTap: () => showRecordDetails(r),
//                                         child: ClipRRect(
//                                           borderRadius: BorderRadius.circular(12),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               border: Border.all(
//                                                 color: Colors.grey[200]!,
//                                               ),
//                                               borderRadius: BorderRadius.circular(12),
//                                             ),
//                                             child: Image.network(
//                                               r['record'],
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),

//             // Save Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: isUploading ? null : uploadRecords,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFA4C8E1), // Changed to theme color
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: isUploading
//                     ? const SizedBox(
//                         height: 24,
//                         width: 24,
//                         child: CircularProgressIndicator(
//                           color: Colors.white,
//                           strokeWidth: 3,
//                         ),
//                       )
//                     : const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.save_rounded, color: Colors.white),
//                           SizedBox(width: 8),
//                           Text(
//                             "Save Records",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:renalguide/Caretaker/register.dart';
import 'package:renalguide/Staff/login.dart';

class AddPatientRecordsPage extends StatefulWidget {
  const AddPatientRecordsPage({super.key});

  @override
  State<AddPatientRecordsPage> createState() => _AddPatientRecordsPageState();
}

class _AddPatientRecordsPageState extends State<AddPatientRecordsPage> {
  final ImagePicker _picker = ImagePicker();
  final Dio _dio = Dio();

  final TextEditingController doctorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? selectedDate;
  List<File> selectedImages = [];
  List<Map<String, dynamic>> uploadedRecords = [];

  bool isUploading = false;
  bool isLoadingRecords = true;

  @override
  void initState() {
    super.initState();
    fetchUploadedRecords();
  }

  InputDecoration _inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Color(0xFFA4C8E1),
          width: 2,
        ),
      ),
      prefixIcon: Container(
        margin: const EdgeInsets.only(right: 12),
        child: Icon(
          label == "Doctor Name" ? Icons.person_rounded : Icons.description_rounded,
          color: Color(0xFFA4C8E1),
        ),
      ),
    );
  }

  /// PICK IMAGES
  Future<void> pickImages() async {
    final images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        selectedImages.addAll(images.map((e) => File(e.path)));
      });
    }
  }

  /// UPLOAD RECORDS
  Future<void> uploadRecords() async {
    if (doctorController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedDate == null ||
        selectedImages.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
            content: Text("Fill all fields"),
            backgroundColor: Color(0xFFA4C8E1),
          ));
      return;
    }

    setState(() => isUploading = true);

    try {
      List<MultipartFile> files = [];
      for (var img in selectedImages) {
        files.add(await MultipartFile.fromFile(img.path));
      }

      FormData formData = FormData.fromMap({
        "record": files,
        "DoctorName": doctorController.text,
        "Dateofconsultation":
            DateFormat('yyyy-MM-dd').format(selectedDate!),
        "Description": descriptionController.text,
      });

      await _dio.post("$baseurl/addrecord/$lid", data: formData);

      doctorController.clear();
      descriptionController.clear();
      selectedImages.clear();
      selectedDate = null;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
            content: Text("Records uploaded successfully"),
            backgroundColor: Color(0xFFA4C8E1),
          ));

      fetchUploadedRecords();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
            content: Text("Upload failed: $e"),
            backgroundColor: Colors.red,
          ));
    } finally {
      setState(() => isUploading = false);
    }
  }

  /// FETCH RECORDS
  Future<void> fetchUploadedRecords() async {
    try {
      final response = await _dio.get("$baseurl/addrecord/$lid");
      final List data = response.data;

      setState(() {
        uploadedRecords = data.map<Map<String, dynamic>>((e) {
          return {
            "id": e['id'],
            "record": "$baseurl${e['record']}",
            "doctor": e['DoctorName'] ?? "Not specified",
            "date": e['Dateofconsultation'] ?? "Not specified",
            "desc": e['Description'] ?? "No description",
          };
        }).toList();
        isLoadingRecords = false;
      });
    } catch (e) {
      print("Error fetching records: $e");
      setState(() => isLoadingRecords = false);
    }
  }

  /// DELETE RECORD
  Future<void> deleteRecord(int id) async {
    try {
      await _dio.delete("$baseurl/deleterecord/$id");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
            content: Text("Record deleted successfully"),
            backgroundColor: Color(0xFFA4C8E1),
          ));
      fetchUploadedRecords();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
            content: Text("Delete failed"),
            backgroundColor: Colors.red,
          ));
    }
  }

  /// FULL IMAGE VIEW + DETAILS
  void showRecordDetails(Map<String, dynamic> r) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFA4C8E1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Record Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InteractiveViewer(
                      child: Image.network(
                        r['record'],
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person_rounded, color: Color(0xFFA4C8E1), size: 18),
                              const SizedBox(width: 8),
                              Text("Doctor: ${r['doctor']}",
                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.calendar_today_rounded, color: Color(0xFFA4C8E1), size: 18),
                              const SizedBox(width: 8),
                              Text("Date: ${r['date']}"),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text("Description:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFFA4C8E1).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(r['desc']),
                          ),
                          const SizedBox(height: 16),

                          /// DELETE BUTTON
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                deleteRecord(r['id']);
                              },
                              icon: const Icon(Icons.delete_rounded),
                              label: const Text("Delete Record"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA4C8E1),
        title: const Text(
          "Patient Records",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView( // Wrap entire body in SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Form Section
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        "Upload New Record",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: doctorController,
                        decoration: _inputStyle("Doctor Name"),
                      ),
                      const SizedBox(height: 12),

                      // Date Picker
                      GestureDetector(
                        onTap: () async {
                          final d = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                            builder: (context, child) => Theme(
                              data: ThemeData(
                                colorScheme: const ColorScheme.light(primary: Color(0xFFA4C8E1)),
                              ),
                              child: child!,
                            ),
                          );
                          if (d != null) setState(() => selectedDate = d);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today_rounded, color: Color(0xFFA4C8E1)),
                              const SizedBox(width: 12),
                              Text(
                                selectedDate == null
                                    ? "Select Consultation Date"
                                    : DateFormat('yyyy-MM-dd').format(selectedDate!),
                                style: TextStyle(
                                  color: selectedDate == null ? Colors.grey : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: "Description",
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: Icon(Icons.description_rounded, color: Color(0xFFA4C8E1)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: Color(0xFFA4C8E1),
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      ElevatedButton.icon(
                        onPressed: pickImages,
                        icon: Icon(Icons.upload_rounded, color: Colors.white),
                        label: const Text("Pick Images"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA4C8E1),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Uploaded Records Section - Fixed height container
              Container(
                height: 300, // Fixed height for the records section
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Uploaded Records",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${uploadedRecords.length} record(s) found",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: isLoadingRecords
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFA4C8E1),
                                  ),
                                )
                              : uploadedRecords.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.photo_library_rounded,
                                            size: 60,
                                            color: Colors.grey[400],
                                          ),
                                          const SizedBox(height: 12),
                                          const Text(
                                            "No records uploaded yet",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : GridView.builder(
                                      itemCount: uploadedRecords.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                      ),
                                      itemBuilder: (_, i) {
                                        final r = uploadedRecords[i];
                                        return GestureDetector(
                                          onTap: () => showRecordDetails(r),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey[200]!,
                                                ),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Image.network(
                                                r['record'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isUploading ? null : uploadRecords,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA4C8E1),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: isUploading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save_rounded, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "Save Records",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 20), // Extra padding at bottom for scrolling
            ],
          ),
        ),
      ),
    );
  }
}