import 'package:flutter/material.dart';

class CaretakerProfilePage extends StatelessWidget {
  const CaretakerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    // 🔹 (You can fetch these later from database)
    String name = "John Mathew";
    String age = "32";
    String sex = "Male";
    String phone = "9876543210";
    String email = "john.caretaker@gmail.com";

    return Scaffold(
      backgroundColor: const Color(0xFFD6FFC1),

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text("Caretaker Profile"),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xFF2E7D32),
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),

              const SizedBox(height: 25),

              _buildCard("Name:", name, Icons.person),
              _buildCard("Age:", age, Icons.cake),
              _buildCard("Sex:", sex, Icons.group),
              _buildCard("Phone Number:", phone, Icons.phone),
              _buildCard("Email:", email, Icons.email),

              const SizedBox(height: 30),

              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: const Color(0xFF2E7D32),
              //     padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 40),
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              //   ),
              //   onPressed: () => Navigator.pop(context),
              //   child: const Text(
              //     "Back",
              //     style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 UI Card Builder Function
  Widget _buildCard(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0,3)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF2E7D32), size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "$label $value",
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
