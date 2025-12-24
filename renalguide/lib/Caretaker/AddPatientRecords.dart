// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:dio/dio.dart';
// import 'package:int1/int1.dart';
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

//   List<File> selectedImages = [];
//   List<Map<String, dynamic>> uloadedRecords = [];

//   bool isUploading = false;
//   bool isLoadingRecords = true;

//   @override
//   void initState(){
//     super.initState();
//     fetchUploadedRecords();
//   }


//   // Form controllers
//   final TextEditingController _doctorNameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   DateTime? _selectedDate;

//   Future<void> pickImages() async {
//     final List<XFile>? images = await _picker.pickMultiImage();
//     if (images != null && images.isNotEmpty) {
//       setState(() {
//         selectedImages.addAll(images.map((e) => File(e.path)));
//       });
//     }
//   }
  
//   Future<void> uploadRecords() async {
//     setState(() => isUploading = true);
    
//     try {
//       List<MultipartFile> imageFiles = [];

//       for (var image in selectedImages) {
//         imageFiles.add(
//           await MultipartFile.fromFile(
//            image.path,
//            filename: image.path.split('/').last, 
//           ),
//         );
//       }

//       FormData formdata = FormData.fromMap({
//        "record": imageFiles,
//       });

//       final response = await _dio.post(
//         "$baseurl/addrecord/$lid",
//         data: FormData,
//         options: Options(headers: { 
//           "content-type": "multipart/form-data",
//         }),
//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("upload failed")),
//         );
//         print("UPLOAD ERROR: $e");  
//       } finally {
//         setState(() => isUploading = false);     
//         }
//       }
//   }
//       Future<void> fetchUploadedRecords() async{
//         try {
//           final response = await _dio.get("$baseurl/addrecords/$lid");
//           print(response.data);

//           final List data = response.data;

//           setState(() {
//             uploadedRecords = data.map<Map<String, dynamic>>((item){
//               return{
//                 "id":item['id'],
//                 "record":'$baseurl${item['record']}',
//                 "uploaded_date":item['uploaded_date']'
                
//               };
//             }).toList();
//             isLoadingRecords = false;
//           });
//         } catch (e) {
//         print("FETCH ERROR: $e");
//         isLoadingRecords = false;
//         }
//       }

//       void showDeleteDialog(int recordId){
//       showdialog(
//       context: context,
//       builder: (context) => AlertDialog(
//       title: const Text("Delete Record"),
//       content: const Text("Are you sure you want to delete this record?"),
//       actions:{
//       TextButton(
//        onPressed: () => Navigator.pop(context),
//        child: const Text("cancel"),
//       ),
//       ElevatedButton(
//       style: ElevatedButton.styleFrom(backgroundcolor: colors.red),
//       onPressed: ()
//       Navigator.pop(context);
//       deleteRecord(recordId);
//       },
//       child: const Text("Delete"),
//       ),
//       ],
//       ),
//       );
//       }

    

//   Future<void> pickDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _doctorNameController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F7F9),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF2E7D32),
//         title: const Text(
//           "Add Patient Records",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Doctor Name
//             TextField(
//               controller: _doctorNameController,
//               decoration: InputDecoration(
//                 labelText: "Doctor Name",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 prefixIcon: const Icon(Icons.person, color: Color(0xFF2E7D32)),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Date of Previous Consultation
//             GestureDetector(
//               onTap: pickDate,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: const Color(0xFF2E7D32), width: 2),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       _selectedDate == null
//                           ? "Select Date of Consultation"
//                           : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
//                       style: TextStyle(
//                         color: _selectedDate == null ? Colors.grey : Colors.black,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const Icon(Icons.calendar_today, color: Color(0xFF2E7D32)),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Description
//             TextField(
//               controller: _descriptionController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 labelText: "Description / Notes",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 prefixIcon: const Icon(Icons.description, color: Color(0xFF2E7D32)),
//               ),
//             ),
//             const SizedBox(height: 16),

//             const Text(
//               "Upload Previous Medical Records",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),

//             // UPLOAD BUTTON
//             GestureDetector(
//               onTap: pickImages,
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 18),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(14),
//                   border: Border.all(
//                     color: const Color(0xFF2E7D32),
//                     width: 2,
//                   ),
//                 ),
//                 child: Column(
//                   children: const [
//                     Icon(Icons.upload_file, size: 40, color: Color(0xFF2E7D32)),
//                     SizedBox(height: 6),
//                     Text(
//                       "Tap to upload images",
//                       style: TextStyle(
//                         color: Color(0xFF2E7D32),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // IMAGE PREVIEW GRID inside fixed-height container
//             Container(
//               height: 250, // adjust height to avoid overflow
//               child: selectedImages.isEmpty
//                   ? const Center(
//                       child: Text(
//                         "No records added yet",
//                         style: TextStyle(fontSize: 16, color: Colors.grey),
//                       ),
//                     )
//                   : GridView.builder(
//                       itemCount: selectedImages.length,
//                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                       ),
//                       itemBuilder: (context, index) {
//                         return Stack(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 image: DecorationImage(
//                                   image: FileImage(selectedImages[index]),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               top: 6,
//                               right: 6,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedImages.removeAt(index);
//                                   });
//                                 },
//                                 child: const CircleAvatar(
//                                   radius: 12,
//                                   backgroundColor: Colors.red,
//                                   child: Icon(Icons.close, size: 14, color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//             ),

//             const SizedBox(height: 10),

//             // SAVE BUTTON
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF2E7D32),
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onPressed: (_doctorNameController.text.isEmpty ||
//                         _selectedDate == null ||
//                         selectedImages.isEmpty)
//                     ? null
//                     : () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text("Records saved successfully"),
//                           ),
//                         );
//                       },
//                 child: const Text(
//                   "Save Records",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
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

  List<File> selectedImages = [];
  List<Map<String, dynamic>> uploadedRecords = [];

  bool isUploading = false;
  bool isLoadingRecords = true;

  @override
  void initState() {
    super.initState();
    fetchUploadedRecords();
  }

  /// PICK MULTIPLE IMAGES
  Future<void> pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        selectedImages.addAll(images.map((e) => File(e.path)));
      });
    }
  }

  /// UPLOAD IMAGES
  Future<void> uploadRecords() async {
    setState(() => isUploading = true);

    try {
      List<MultipartFile> imageFiles = [];

      for (var image in selectedImages) {
        imageFiles.add(
          await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
        );
      }

      FormData formData = FormData.fromMap({
        "record": imageFiles,
      });

      final response = await _dio.post(
        "$baseurl/addrecord/$lid",
        data: formData,
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Records uploaded successfully")),
        );
        selectedImages.clear();
        fetchUploadedRecords();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Upload failed")),
      );
      print("UPLOAD ERROR: $e");
    } finally {
      setState(() => isUploading = false);
    }
  }

  /// FETCH UPLOADED RECORDS
  Future<void> fetchUploadedRecords() async {
    try {
      final response = await _dio.get("$baseurl/addrecord/$lid");
      print(response.data);

      final List data = response.data;

      setState(() {
        uploadedRecords = data.map<Map<String, dynamic>>((item) {
          return {
            "id": item['id'],
            "record": '$baseurl${item['record']}',
            "uploaded_date": item['uploaded_date'],
          // "date": item['uploaded_date'].split(' ')[0],
          // "time": item['uploaded_date'].split(' ')[1] ?? "",
          };
        }).toList();
        isLoadingRecords = false;
      });
    } catch (e) {
      print("FETCH ERROR: $e");
      isLoadingRecords = false;
    }
  }

  /// DELETE RECORD
  Future<void> deleteRecord(int recordId) async {
    try {
      final response = await _dio.delete(
        "$baseurl/deleterecord/$recordId",
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Record deleted")),
        );
        fetchUploadedRecords();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Delete failed")),
      );
      print("DELETE ERROR: $e");
    }
  }

  /// DELETE CONFIRMATION
  void showDeleteDialog(int recordId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Record"),
        content: const Text("Are you sure you want to delete this record?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              deleteRecord(recordId);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text(
          "Add Patient Records",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upload Previous Medical Records",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            /// UPLOAD BUTTON
            GestureDetector(
              onTap: pickImages,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF2E7D32), width: 2),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.upload_file,
                        size: 40, color: Color(0xFF2E7D32)),
                    SizedBox(height: 6),
                    Text(
                      "Tap to upload images",
                      style: TextStyle(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// SELECTED IMAGES PREVIEW
            if (selectedImages.isNotEmpty)
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedImages.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            selectedImages[index],
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImages.removeAt(index);
                              });
                            },
                            child: const CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.close,
                                  size: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),

            const Text(
              "Uploaded Records History",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            /// RECORDS GRID
            Expanded(
              child: isLoadingRecords
                  ? const Center(child: CircularProgressIndicator())
                  : uploadedRecords.isEmpty
                      ? const Center(
                          child: Text(
                            "No records found",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                        : GridView.builder(
                          itemCount: uploadedRecords.length,
                          gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                          final record = uploadedRecords[index];
                          return Stack(
                            children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                              record['record'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                              color: Colors.black54,
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                DateFormat('yyyy-MM-dd').format(DateTime.parse(record['uploaded_date'])),
                                style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              ),
                            ),
                            Positioned(
                              top: 6,
                              right: 6,
                              child: GestureDetector(
                              onTap: () =>
                                showDeleteDialog(record['id']),
                              child: const CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.delete,
                                  size: 16, color: Colors.white),
                              ),
                              ),
                            ),
                            ],
                          );
                          },
                        ),
            ),

            const SizedBox(height: 10),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: selectedImages.isEmpty || isUploading
                    ? null
                    : uploadRecords,
                child: isUploading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Save Records",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
