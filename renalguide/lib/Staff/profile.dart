import 'package:flutter/material.dart';
import 'package:renalguide/Staff/editprofile.dart';

class StaffProfilePage extends StatelessWidget {
  const StaffProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    // 🔹 Replace these with database values later
    String name = "Ayesha Rahman";
    String age = "28";
    String email = "ayesha.staff@gmail.com";
    String sex = "Female";
    String phoneNumber = "9876543210";
    String qualification = "BSc Nursing";
    String experience = "4 Years";

    return Scaffold(
      backgroundColor: const Color(0xFFD6FFC1),

      appBar: AppBar(
        title: const Text("Staff Profile"),
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),

            child: Column(
              children: [

                const CircleAvatar(
                  radius: 55,
                  backgroundColor: Color(0xFF2E7D32),
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 20),

                Text(
                  name,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                profileTile("Age", age),
                profileTile("Email", email),
                profileTile("Gender", sex),
                profileTile("Phone Number", phoneNumber),
                profileTile("Qualification", qualification),
                profileTile("Experience", experience),

                const SizedBox(height: 28),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(),));
                  },
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 UI Component for each field
  Widget profileTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F7F9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            Text(value, style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
