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
      backgroundColor: const Color(0xFFD6FFC1),

      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xFF2E7D32),
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),

            const SizedBox(height: 25),

            buildTextField("Name", nameController),
            buildTextField("Age", ageController),
            buildTextField("Email", emailController),
            buildTextField("Gender", sexController),
            buildTextField("Phone Number", phoneController),
            buildTextField("Qualification", qualificationController),
            buildTextField("Experience", experienceController),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  const SnackBar(content: Text("Profile Updated Successfully")),
                );
              },
              child: const Text("Save Changes", style: TextStyle(fontSize: 17, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Custom TextField UI
  Widget buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
