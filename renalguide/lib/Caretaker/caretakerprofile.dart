// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:renalguide/Caretaker/register.dart';
// import 'package:renalguide/Staff/login.dart'; // contains baseurl & lid

// class CaretakerProfilePage extends StatefulWidget {
//   const CaretakerProfilePage({super.key});

//   @override
//   State<CaretakerProfilePage> createState() => _CaretakerProfilePageState();
// }

// class _CaretakerProfilePageState extends State<CaretakerProfilePage> {
//   final Dio dio = Dio();

//   bool isLoading = true;

//   // Controllers
//   final nameCtrl = TextEditingController();
//   final ageCtrl = TextEditingController();
//   final sexCtrl = TextEditingController();
//   final phoneCtrl = TextEditingController();
//   final emailCtrl = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchProfile();
//   }

//   /// 🔹 FETCH PROFILE
//   Future<void> fetchProfile() async {
//     try {
//       final response = await dio.get("$baseurl/CaretakerProfile/$lid");

//       setState(() {
//         nameCtrl.text = response.data['name'] ?? "";
//         ageCtrl.text = response.data['age']?.toString() ?? "";
//         sexCtrl.text = response.data['sex'] ?? "";
//         phoneCtrl.text = response.data['phonenumber']?.toString() ?? "";
//         emailCtrl.text = response.data['email'] ?? "";
//         isLoading = false;
//       });
//     } catch (e) {
//       isLoading = false;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to load profile")),
//       );
//     }
//   }

//   /// 🔹 UPDATE PROFILE
//   Future<void> updateProfile() async {
//     try {
//       await dio.post(
//         "$baseurl/CaretakerProfile/$lid",
//         data: {
//           "name": nameCtrl.text,
//           "age": ageCtrl.text,
//           "sex": sexCtrl.text,
//           "phonenumber": phoneCtrl.text,
//           "email": emailCtrl.text,
//         },
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Profile updated successfully")),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Update failed")),
//       );
//     }
//   }

//   InputDecoration _style(String label, IconData icon) {
//     return InputDecoration(
//       labelText: label,
//       prefixIcon: Icon(icon, color: const Color(0xFF2E7D32)),
//       filled: true,
//       fillColor: Colors.white,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFD6FFC1),

//       appBar: AppBar(
//         backgroundColor: const Color(0xFF2E7D32),
//         title: const Text("Caretaker Profile"),
//         centerTitle: true,
//       ),

//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SafeArea(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),

//                     const CircleAvatar(
//                       radius: 55,
//                       backgroundColor: Color(0xFF2E7D32),
//                       child: Icon(Icons.person, size: 60, color: Colors.white),
//                     ),

//                     const SizedBox(height: 25),

//                     TextField(
//                       controller: nameCtrl,
//                       decoration: _style("Name", Icons.person),
//                     ),
//                     const SizedBox(height: 12),

//                     TextField(
//                       controller: ageCtrl,
//                       keyboardType: TextInputType.number,
//                       decoration: _style("Age", Icons.cake),
//                     ),
//                     const SizedBox(height: 12),

//                     TextField(
//                       controller: sexCtrl,
//                       decoration: _style("Sex", Icons.group),
//                     ),
//                     const SizedBox(height: 12),

//                     TextField(
//                       controller: phoneCtrl,
//                       keyboardType: TextInputType.phone,
//                       decoration: _style("Phone Number", Icons.phone),
//                     ),
//                     const SizedBox(height: 12),

//                     TextField(
//                       controller: emailCtrl,
//                       decoration: _style("Email", Icons.email),
//                     ),

//                     const SizedBox(height: 25),

//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF2E7D32),
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                         ),
//                         onPressed: updateProfile,
//                         child: const Text(
//                           "Update Profile",
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:renalguide/Caretaker/register.dart';
import 'package:renalguide/Staff/login.dart'; // contains baseurl & lid

class CaretakerProfilePage extends StatefulWidget {
  const CaretakerProfilePage({super.key});

  @override
  State<CaretakerProfilePage> createState() => _CaretakerProfilePageState();
}

class _CaretakerProfilePageState extends State<CaretakerProfilePage> {
  final Dio dio = Dio();

  bool isLoading = true;

  // Controllers
  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final sexCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  /// 🔹 FETCH PROFILE
  Future<void> fetchProfile() async {
    try {
      final response = await dio.get("$baseurl/CaretakerProfile/$lid");

      setState(() {
        nameCtrl.text = response.data['name'] ?? "";
        ageCtrl.text = response.data['age']?.toString() ?? "";
        sexCtrl.text = response.data['sex'] ?? "";
        phoneCtrl.text = response.data['phonenumber']?.toString() ?? "";
        emailCtrl.text = response.data['email'] ?? "";
        isLoading = false;
      });
    } catch (e) {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to load profile"),
          backgroundColor: Color(0xFFA4C8E1),
        ),
      );
    }
  }

  /// 🔹 UPDATE PROFILE
  Future<void> updateProfile() async {
    try {
      await dio.post(
        "$baseurl/CaretakerProfile/$lid",
        data: {
          "name": nameCtrl.text,
          "age": ageCtrl.text,
          "sex": sexCtrl.text,
          "phonenumber": phoneCtrl.text,
          "email": emailCtrl.text,
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Profile updated successfully"),
          backgroundColor: Color(0xFFA4C8E1),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Update failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  InputDecoration _style(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.grey[600],
      ),
      prefixIcon: Container(
        margin: EdgeInsets.only(right: 12),
        child: Icon(icon, color: Color(0xFFA4C8E1)),
      ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7FF), // Changed to theme background

      appBar: AppBar(
        backgroundColor: const Color(0xFFA4C8E1), // Changed to theme color
        title: const Text(
          "Caretaker Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xFFA4C8E1),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Profile Avatar with gradient border
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFA4C8E1),
                            Color(0xFFB8D6EB),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: 60,
                          color: Color(0xFFA4C8E1),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Form Container
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.withOpacity(0.1),
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Text(
                                "Profile Details",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C3E50),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "Update your personal information",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 20),

                              TextField(
                                controller: nameCtrl,
                                decoration: _style("Name", Icons.person_outline_rounded),
                              ),
                              const SizedBox(height: 12),

                              TextField(
                                controller: ageCtrl,
                                keyboardType: TextInputType.number,
                                decoration: _style("Age", Icons.cake_rounded),
                              ),
                              const SizedBox(height: 12),

                              TextField(
                                controller: sexCtrl,
                                decoration: _style("Sex", Icons.people_rounded),
                              ),
                              const SizedBox(height: 12),

                              TextField(
                                controller: phoneCtrl,
                                keyboardType: TextInputType.phone,
                                decoration: _style("Phone Number", Icons.phone_rounded),
                              ),
                              const SizedBox(height: 12),

                              TextField(
                                controller: emailCtrl,
                                decoration: _style("Email", Icons.email_rounded),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Update Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA4C8E1), // Changed to theme color
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        onPressed: updateProfile,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.save_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Update Profile",
                              style: TextStyle(
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
                            color: Color(0xFFA4C8E1),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Your profile information will be updated across the system",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}