// import 'package:flutter/material.dart';

// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({super.key});

//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
  
//   // Pre-filled default values (later fetch from DB)
//   TextEditingController nameController = TextEditingController(text: "Ayesha Rahman");
//   TextEditingController ageController = TextEditingController(text: "28");
//   TextEditingController emailController = TextEditingController(text: "ayesha.staff@gmail.com");
//   TextEditingController sexController = TextEditingController(text: "Female");
//   TextEditingController phoneController = TextEditingController(text: "9876543210");
//   TextEditingController qualificationController = TextEditingController(text: "BSc Nursing");
//   TextEditingController experienceController = TextEditingController(text: "4 Years");

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       backgroundColor: const Color(0xFFD6FFC1),

//       appBar: AppBar(
//         title: const Text("Edit Profile"),
//         backgroundColor: const Color(0xFF2E7D32),
//         elevation: 0,
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [

//             const CircleAvatar(
//               radius: 55,
//               backgroundColor: Color(0xFF2E7D32),
//               child: Icon(Icons.person, size: 60, color: Colors.white),
//             ),

//             const SizedBox(height: 25),

//             buildTextField("Name", nameController),
//             buildTextField("Age", ageController),
//             buildTextField("Email", emailController),
//             buildTextField("Gender", sexController),
//             buildTextField("Phone Number", phoneController),
//             buildTextField("Qualification", qualificationController),
//             buildTextField("Experience", experienceController),

//             const SizedBox(height: 30),

//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF2E7D32),
//                 padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               onPressed: () {
//                 // Later save to backend or DB
//                 debugPrint("Updated Name: ${nameController.text}");
//                 debugPrint("Updated Age: ${ageController.text}");
//                 debugPrint("Updated Email: ${emailController.text}");
//                 debugPrint("Updated Gender: ${sexController.text}");
//                 debugPrint("Updated Phone: ${phoneController.text}");
//                 debugPrint("Updated Qualification: ${qualificationController.text}");
//                 debugPrint("Updated Experience: ${experienceController.text}");

//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("Profile Updated Successfully")),
//                 );
//               },
//               child: const Text("Save Changes", style: TextStyle(fontSize: 17, color: Colors.white)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // 🔹 Custom TextField UI
//   Widget buildTextField(String label, TextEditingController controller) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 15),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  
  // Pre-filled default values (later fetch from DB)
  TextEditingController nameController = TextEditingController(text: "Ayesha Rahman");
  TextEditingController ageController = TextEditingController(text: "28");
  TextEditingController emailController = TextEditingController(text: "ayesha.staff@gmail.com");
  TextEditingController sexController = TextEditingController(text: "Female");
  TextEditingController phoneController = TextEditingController(text: "9876543210");
  TextEditingController qualificationController = TextEditingController(text: "BSc Nursing");
  TextEditingController experienceController = TextEditingController(text: "4 Years");

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF0F7FF),

      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFA4C8E1),
        elevation: 0,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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

            const SizedBox(height: 25),

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
                    _buildTextField("Name", nameController, Icons.person_outline_rounded),
                    const SizedBox(height: 16),
                    _buildTextField("Age", ageController, Icons.calendar_today_rounded),
                    const SizedBox(height: 16),
                    _buildTextField("Email", emailController, Icons.email_rounded),
                    const SizedBox(height: 16),
                    _buildTextField("Gender", sexController, Icons.people_rounded),
                    const SizedBox(height: 16),
                    _buildTextField("Phone Number", phoneController, Icons.phone_rounded),
                    const SizedBox(height: 16),
                    _buildTextField("Qualification", qualificationController, Icons.school_rounded),
                    const SizedBox(height: 16),
                    _buildTextField("Experience", experienceController, Icons.work_history_rounded),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA4C8E1),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  // Later save to backend or DB
                  debugPrint("Updated Name: ${nameController.text}");
                  debugPrint("Updated Age: ${ageController.text}");
                  debugPrint("Updated Email: ${emailController.text}");
                  debugPrint("Updated Gender: ${sexController.text}");
                  debugPrint("Updated Phone: ${phoneController.text}");
                  debugPrint("Updated Qualification: ${qualificationController.text}");
                  debugPrint("Updated Experience: ${experienceController.text}");

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
                },
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
                      "Save Changes",
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
                    color: const Color(0xFFA4C8E1),
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
          ],
        ),
      ),
    );
  }

  // 🔹 Custom TextField UI with icons
  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
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
        fillColor: Colors.white,
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