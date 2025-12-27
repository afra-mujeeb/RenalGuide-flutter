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
        borderSide: BorderSide.none,
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
          .showSnackBar(const SnackBar(content: Text("Fill all fields")));
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

      fetchUploadedRecords();
    } finally {
      setState(() => isUploading = false);
    }
  }

  /// FETCH RECORDS
  Future<void> fetchUploadedRecords() async {
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
  }

  /// DELETE RECORD
  Future<void> deleteRecord(int id) async {
    await _dio.delete("$baseurl/deleterecord/$id");
    fetchUploadedRecords();
  }

  /// FULL IMAGE VIEW + DETAILS
  void showRecordDetails(Map<String, dynamic> r) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InteractiveViewer(
              child: Image.network(
                r['record'],
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Doctor: ${r['doctor']}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("Date: ${r['date']}"),
                  const SizedBox(height: 6),
                  const Text("Description:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(r['desc']),
                  const SizedBox(height: 10),

                  /// DELETE BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        deleteRecord(r['id']);
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text("Delete Record"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text("Patient Records"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: doctorController,
                decoration: _inputStyle("Doctor Name")),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (d != null) setState(() => selectedDate = d);
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(selectedDate == null
                    ? "Select Date"
                    : DateFormat('yyyy-MM-dd').format(selectedDate!)),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: _inputStyle("Description"),
            ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: pickImages,
              icon: const Icon(Icons.upload),
              label: const Text("Pick Images"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: isLoadingRecords
                  ? const Center(child: CircularProgressIndicator())
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
                            child: Image.network(
                              r['record'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isUploading ? null : uploadRecords,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                ),
                child: const Text("Save Records"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
