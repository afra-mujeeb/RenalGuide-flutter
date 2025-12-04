// import 'package:flutter/material.dart';

// class Addpatient extends StatelessWidget {
//   const Addpatient({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController Name = TextEditingController();
//     final TextEditingController Age = TextEditingController();
//     final TextEditingController Sex = TextEditingController();
//     final formkey = GlobalKey<FormState>();

//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F7F9),

//       appBar: AppBar(
//         title: const Text(
//           'Add Patient',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,        // ⭐ UPDATED TO WHITE
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: const Color(0xFF2E7D32),
//         iconTheme: const IconThemeData(color: Colors.white), // back icon white
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: formkey,
//           child: Card(
//             elevation: 4,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [

//                   const Text(
//                     "Add New Patient",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   TextFormField(
//                     controller: Name,
//                     validator: (value) =>
//                         value == null || value.isEmpty ? "Enter patient name" : null,
//                     decoration: inputStyle("Patient Name"),
//                   ),

//                   const SizedBox(height: 12),

//                   TextFormField(
//                     controller: Age,
//                     validator: (value) =>
//                         value == null || value.isEmpty ? "Enter patient age" : null,
//                     decoration: inputStyle("Age"),
//                     keyboardType: TextInputType.number,
//                   ),

//                   const SizedBox(height: 12),

//                   TextFormField(
//                     controller: Sex,
//                     validator: (value) =>
//                         value == null || value.isEmpty ? "Enter patient sex" : null,
//                     decoration: inputStyle("Sex"),
//                   ),

//                   const SizedBox(height: 20),

//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF2E7D32),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       onPressed: () {
//                         if (formkey.currentState!.validate()) {}
//                       },
//                       child: const Text(
//                         "Add Patient",
//                         style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),

//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   InputDecoration inputStyle(String hint) {
//     return InputDecoration(
//       labelText: hint,
//       filled: true,
//       fillColor: Colors.grey.shade100,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
// }



// AddPatientPage
import 'package:flutter/material.dart';

class AddPatientPage extends StatelessWidget {
  AddPatientPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController bloodgroupController = TextEditingController();
  final TextEditingController diagnosisController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      appBar: AppBar(
        title: const Text('Add Patient', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2E7D32),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    validator: (v) => v == null || v.isEmpty ? 'Enter name' : null,
                    decoration: inputDecoration('Patient Name'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: ageController,
                    validator: (v) => v == null || v.isEmpty ? 'Enter age' : null,
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration('Age'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: sexController,
                    validator: (v) => v == null || v.isEmpty ? 'Enter sex' : null,
                    decoration: inputDecoration('Sex'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: sexController,
                    validator: (v) => v == null || v.isEmpty ? 'Enter Blood group' : null,
                    decoration: inputDecoration('Blood group'),
                  ),
                   const SizedBox(height: 12),
                  TextFormField(
                    controller: sexController,
                    validator: (v) => v == null || v.isEmpty ? 'Enter Diagnosis' : null,
                    decoration: inputDecoration('Diagnosis'),
                  ),
                  const SizedBox(height: 20),
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context, {
                            'name': nameController.text,
                            'age': ageController.text,
                            'sex': sexController.text,
                          });
                        }
                      },
                      child: const Text(
                        'Add Patient',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    );
  }
}