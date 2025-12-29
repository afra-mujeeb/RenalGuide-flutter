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
// import 'package:flutter/material.dart';
// import 'package:renalguide/Caretaker/Viewpatient.dart';
// import 'package:renalguide/Caretaker/register.dart';
// import 'package:renalguide/Staff/login.dart';

// class AddPatientPage extends StatefulWidget {
//   AddPatientPage({super.key});

//   @override
//   State<AddPatientPage> createState() => _AddPatientPageState();
// }

// class _AddPatientPageState extends State<AddPatientPage> {
//   final TextEditingController nameController = TextEditingController();

//   final TextEditingController ageController = TextEditingController();

//   final TextEditingController sexController = TextEditingController();

//   final TextEditingController bloodgroupController = TextEditingController();

//   final TextEditingController diagnosisController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   String? selectedgender;

//   Future<void> _AddPatient(context) async {
//     Map<String, dynamic> data = {
//       'name': nameController.text,
//       'age': ageController.text,
//       'sex': selectedgender,
//       'bloodgroup': bloodgroupController.text,
//       'diagnosis': diagnosisController.text,
//     };
//     try {
//       final response = await dio.post('$baseurl/AddPatient/$lid', data: data);
//       // print(response.data);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Navigator.pop(context);
//         // Navigator.push(context, MaterialPageRoute(builder: (context) => CaretakerPatientPage(),));
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text("Patient added successfully")));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("FAILED")));

//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F7F9),
//       appBar: AppBar(
//         title: const Text('Add Patient', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF2E7D32),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             elevation: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TextFormField(
//                       controller: nameController,
//                       validator: (v) =>
//                           v == null || v.isEmpty ? 'Enter name' : null,
//                       decoration: inputDecoration('Patient Name'),
//                     ),
//                     const SizedBox(height: 12),
//                     TextFormField(
//                       controller: ageController,
//                       validator: (v) =>
//                           v == null || v.isEmpty ? 'Enter age' : null,
//                       keyboardType: TextInputType.number,
//                       decoration: inputDecoration('Age'),
//                     ),
//                     const SizedBox(height: 12),
//                     DropdownButtonFormField(
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "This field is required";
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Select a gender',
//                         filled: true,
//                         fillColor: const Color(0xFFF5F7F9),
//                         prefixIcon: Icon(Icons.person, color: Colors.grey),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       items: ['Male', 'Female']
//                           .map(
//                             (e) => DropdownMenuItem(child: Text(e), value: e),
//                           )
//                           .toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedgender = value;
//                         });
//                       },
//                     ),

//                     const SizedBox(height: 12),
//                     TextFormField(
//                       controller: bloodgroupController,
//                       validator: (v) =>
//                           v == null || v.isEmpty ? 'Enter Blood group' : null,
//                       decoration: inputDecoration('Blood group'),
//                     ),
//                     const SizedBox(height: 12),
//                     TextFormField(
//                       controller: diagnosisController,
//                       validator: (v) =>
//                           v == null || v.isEmpty ? 'Enter Diagnosis' : null,
//                       decoration: inputDecoration('Diagnosis'),
//                     ),
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF2E7D32),
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             // Navigator.pop(context, {
//                             //   'name': nameController.text,
//                             //   'age': ageController.text,
//                             //   'sex': sexController.text,
//                             // });

//                             _AddPatient(context);
//                           }
//                         },
//                         child: const Text(
//                           'Add Patient',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   InputDecoration inputDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: Colors.grey.shade100,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:renalguide/Caretaker/Viewpatient.dart';
import 'package:renalguide/Caretaker/register.dart';
import 'package:renalguide/Staff/login.dart';

class AddPatientPage extends StatefulWidget {
  AddPatientPage({super.key});

  @override
  State<AddPatientPage> createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController sexController = TextEditingController();

  final TextEditingController bloodgroupController = TextEditingController();

  final TextEditingController diagnosisController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? selectedgender;

  Future<void> _AddPatient(context) async {
    Map<String, dynamic> data = {
      'name': nameController.text,
      'age': ageController.text,
      'sex': selectedgender,
      'bloodgroup': bloodgroupController.text,
      'diagnosis': diagnosisController.text,
    };
    try {
      final response = await dio.post('$baseurl/AddPatient/$lid', data: data);
      // print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pop(context);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => CaretakerPatientPage(),));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(
          content: Text("Patient added successfully"),
          backgroundColor: Color(0xFFA4C8E1), // Added theme color
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("FAILED")));

      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7FF), // Changed to theme background
      appBar: AppBar(
        title: const Text('Add Patient', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFA4C8E1), // Changed to theme color
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Add New Patient",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Enter patient details below",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        controller: nameController,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Enter name' : null,
                        decoration: _inputDecoration('Patient Name', Icons.person_outline_rounded),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: ageController,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Enter age' : null,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration('Age', Icons.calendar_today_rounded),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Select a gender',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: Icon(Icons.people_rounded, color: Color(0xFFA4C8E1)), // Changed icon color
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color(0xFFA4C8E1),
                              width: 2,
                            ),
                          ),
                        ),
                        items: ['Male', 'Female']
                            .map(
                              (e) => DropdownMenuItem(child: Text(e), value: e),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedgender = value;
                          });
                        },
                      ),

                      const SizedBox(height: 12),
                      TextFormField(
                        controller: bloodgroupController,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Enter Blood group' : null,
                        decoration: _inputDecoration('Blood group', Icons.bloodtype_rounded),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: diagnosisController,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Enter Diagnosis' : null,
                        decoration: _inputDecoration('Diagnosis', Icons.medical_services_rounded),
                      ),
                      const SizedBox(height: 25),
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _AddPatient(context);
                            }
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_add_alt_1_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Add Patient',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.grey[600],
      ),
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Container(
        margin: const EdgeInsets.only(right: 12),
        child: Icon(
          icon,
          color: Color(0xFFA4C8E1), // Changed icon color
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Color(0xFFA4C8E1),
          width: 2,
        ),
      ),
    );
  }
}