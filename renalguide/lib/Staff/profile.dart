// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:renalguide/Caretaker/register.dart';
// import 'package:renalguide/Staff/login.dart';

// class StaffProfilePage extends StatefulWidget {
//   const StaffProfilePage({super.key});

//   @override
//   State<StaffProfilePage> createState() => _StaffProfilePageState();
// }

// class _StaffProfilePageState extends State<StaffProfilePage> {
//   final Dio dio = Dio();


//   bool isLoading = true;
//   bool isEdit = false;

//   // Controllers
//   final nameController = TextEditingController();
//   final ageController = TextEditingController();
//   final emailController = TextEditingController();
//   final sexController = TextEditingController();
//   final phoneController = TextEditingController();
//   final qualificationController = TextEditingController();
//   final experienceController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchProfile();
//   }

//   // 🔹 GET PROFILE
//   Future<void> fetchProfile() async {
//     try {
//       final response = await dio.get(
//         "$baseurl/profile/$lid",
//       );
// print(response.data);
//       final data = response.data;

//       nameController.text = data['name'] ?? '';
//       ageController.text = data['age']?.toString() ?? '';
//       emailController.text = data['email'] ?? '';
//       sexController.text = data['sex'] ?? '';
//       phoneController.text = data['phonenumber']?.toString() ?? '';
//       qualificationController.text = data['qualification'] ?? '';
//       experienceController.text = data['experience']?.toString() ?? '';

//     } catch (e) {
//       debugPrint("Error: $e");
//     }

//     setState(() => isLoading = false);
//   }

//   // 🔹 UPDATE PROFILE
//   Future<void> updateProfile() async {
//     try {
//       await dio.post(
//         "$baseurl/profile/$lid",
//         data: {
//           "name": nameController.text,
//           "age": ageController.text,
//           "email": emailController.text,
//           "sex": sexController.text,
//           "phonenumber": phoneController.text,
//           "qualification": qualificationController.text,
//           "experience": experienceController.text,
//         },
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Profile Updated Successfully")),
//       );

//       setState(() => isEdit = false);
//     } catch (e) {
//       debugPrint("Update Error: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFD6FFC1),
//       appBar: AppBar(
//         title: const Text("Staff Profile"),
//         backgroundColor: const Color(0xFF2E7D32),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Container(
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Column(
//                   children: [
//                     const CircleAvatar(
//                       radius: 55,
//                       backgroundColor: Color(0xFF2E7D32),
//                       child: Icon(Icons.person, size: 60, color: Colors.white),
//                     ),
//                     const SizedBox(height: 20),

//                     buildField("Name", nameController),
//                     buildField("Age", ageController),
//                     buildField("Email", emailController, readOnly: true),
//                     buildField("Gender", sexController, readOnly: true),
//                     buildField("Phone", phoneController),
//                     buildField("Qualification", qualificationController),
//                     buildField("Experience", experienceController),

//                     const SizedBox(height: 25),

//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF2E7D32),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 40, vertical: 14),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                       ),
//                       onPressed: () {
//                         if (isEdit) {
//                           updateProfile();
//                         } else {
//                           setState(() => isEdit = true);
//                         }
//                       },
//                       child: Text(
//                         isEdit ? "Save Changes" : "Edit Profile",
//                         style: const TextStyle(
//                             fontSize: 16, color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   // 🔹 Field Widget
//   Widget buildField(
//   String label,
//   TextEditingController controller, {
//   bool readOnly = false,
// }) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 12),
//     child: TextField(
//       controller: controller,
//       enabled: !readOnly && isEdit, 
//       decoration: InputDecoration(
//         labelText: label,
//         filled: true,
//         fillColor:
//             (!readOnly && isEdit) ? Colors.white : const Color(0xFFF5F7F9),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     ),
//   );
// }

// }


import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:renalguide/Caretaker/register.dart';
import 'package:renalguide/Staff/login.dart';

class StaffProfilePage extends StatefulWidget {
  const StaffProfilePage({super.key});

  @override
  State<StaffProfilePage> createState() => _StaffProfilePageState();
}

class _StaffProfilePageState extends State<StaffProfilePage> {
  final Dio dio = Dio();

  bool isLoading = true;
  bool isEdit = false;

  // Controllers
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final sexController = TextEditingController();
  final phoneController = TextEditingController();
  final qualificationController = TextEditingController();
  final experienceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  // 🔹 GET PROFILE
  Future<void> fetchProfile() async {
    try {
      final response = await dio.get(
        "$baseurl/profile/$lid",
      );
      print(response.data);
      final data = response.data;

      nameController.text = data['name'] ?? '';
      ageController.text = data['age']?.toString() ?? '';
      emailController.text = data['email'] ?? '';
      sexController.text = data['sex'] ?? '';
      phoneController.text = data['phonenumber']?.toString() ?? '';
      qualificationController.text = data['qualification'] ?? '';
      experienceController.text = data['experience']?.toString() ?? '';

    } catch (e) {
      debugPrint("Error: $e");
    }

    setState(() => isLoading = false);
  }

  // 🔹 UPDATE PROFILE
  Future<void> updateProfile() async {
    try {
      await dio.post(
        "$baseurl/profile/$lid",
        data: {
          "name": nameController.text,
          "age": ageController.text,
          "email": emailController.text,
          "sex": sexController.text,
          "phonenumber": phoneController.text,
          "qualification": qualificationController.text,
          "experience": experienceController.text,
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Profile Updated Successfully"),
          backgroundColor: const Color(0xFFA4C8E1),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      setState(() => isEdit = false);
    } catch (e) {
      debugPrint("Update Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7FF), // Changed from #D6FFC1 to #F0F7FF
      appBar: AppBar(
        title: const Text(
          "Staff Profile",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFA4C8E1), // Changed from #2E7D32 to #A4C8E1
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xFFA4C8E1), // Changed to match theme
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Profile Avatar with gradient border
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFA4C8E1),
                            const Color(0xFFB8D6EB),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: 65,
                          color: Color(0xFFA4C8E1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Form Fields
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            _buildField("Name", nameController, Icons.person_outline_rounded),
                            const SizedBox(height: 16),
                            _buildField("Age", ageController, Icons.calendar_today_rounded),
                            const SizedBox(height: 16),
                            _buildField("Email", emailController, Icons.email_rounded, readOnly: true),
                            const SizedBox(height: 16),
                            _buildField("Gender", sexController, Icons.people_rounded, readOnly: true),
                            const SizedBox(height: 16),
                            _buildField("Phone", phoneController, Icons.phone_rounded),
                            const SizedBox(height: 16),
                            _buildField("Qualification", qualificationController, Icons.school_rounded),
                            const SizedBox(height: 16),
                            _buildField("Experience", experienceController, Icons.work_history_rounded),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Edit/Save Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA4C8E1), // Changed from #2E7D32 to #A4C8E1
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          if (isEdit) {
                            updateProfile();
                          } else {
                            setState(() => isEdit = true);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isEdit ? Icons.save_rounded : Icons.edit_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isEdit ? "Save Changes" : "Edit Profile",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Information Box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFA4C8E1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xFFA4C8E1).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: const Color(0xFFA4C8E1),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              isEdit 
                                ? "Make your changes and tap Save to update your profile"
                                : "Tap Edit Profile to update your information",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13,
                              ),
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
  }

  // 🔹 Field Widget with icons
  Widget _buildField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      enabled: !readOnly && isEdit,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey[600],
        ),
        prefixIcon: Container(
          margin: const EdgeInsets.only(right: 12),
          child: Icon(
            icon,
            color: const Color(0xFFA4C8E1),
            size: 22,
          ),
        ),
        filled: true,
        fillColor: (!readOnly && isEdit) ? Colors.white : const Color(0xFFF5F7F9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFA4C8E1),
            width: 2,
          ),
        ),
      ),
    );
  }
}