import 'package:flutter/material.dart';
import 'package:renalguide/Caretaker/login.dart';

class Registerscreen extends StatelessWidget {
  const Registerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController username = TextEditingController();
    final TextEditingController password = TextEditingController();
    final TextEditingController age = TextEditingController();
    final TextEditingController phoneNumber = TextEditingController();
    final TextEditingController sex = TextEditingController();
    final TextEditingController email = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xFFD6FFC1), // Updated soft green background

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
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),

            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Caretaker Registration",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),

                  const Text(
                    "Please enter your details",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 25),

                  buildField(
                    controller: username,
                    label: "Username",
                    hint: "Enter your username",
                    icon: Icons.person,
                    isLabelBold: true,
                  ),

                  buildField(
                    controller: email,
                    label: "Email",
                    hint: "Enter your email",
                    icon: Icons.email,
                    isLabelBold: true,
                  ),

                  buildField(
                    controller: password,
                    label: "Password",
                    hint: "Enter your password",
                    icon: Icons.lock,
                    isPassword: true,
                    isLabelBold: true,
                  ),

                  buildField(
                    controller: age,
                    label: "Age",
                    hint: "Enter your age",
                    icon: Icons.cake,
                    inputType: TextInputType.number,
                    isLabelBold: true,
                  ),

                  buildField(
                    controller: phoneNumber,
                    label: "Phone Number",
                    hint: "Enter phone number",
                    icon: Icons.phone,
                    inputType: TextInputType.phone,
                    isLabelBold: true,
                  ),

                  buildField(
                    controller: sex,
                    label: "Sex",
                    hint: "Enter your gender",
                    icon: Icons.group,
                    isLabelBold: true,
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF2E7D32),
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Loginscreen()),
                          );
                        }
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const Loginscreen()),
                        );
                      },
                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(
                          color: Color(0xFF2E7D32),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Reusable field widget
  Widget buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    TextInputType inputType = TextInputType.text,
    bool isLabelBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isLabelBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: inputType,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is required";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: const Color(0xFFF5F7F9),
              prefixIcon: Icon(icon, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
