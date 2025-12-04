// import 'package:flutter/material.dart';

// class Viewpatientscreen extends StatefulWidget {
//   const Viewpatientscreen({super.key});

//   @override
//   State<Viewpatientscreen> createState() => _ViewpatientscreenState();
// }

// class _ViewpatientscreenState extends State<Viewpatientscreen> {
//   // Dummy patient list
//   List<Map<String, String>> patients = [
//     {'name': 'John Doe', 'age': '30', 'sex': 'Male'},
//     {'name': 'Jane Smith', 'age': '25', 'sex': 'Female'},
//     {'name': 'Robert Brown', 'age': '40', 'sex': 'Male'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'View Patients',
//           style: TextStyle(color: Colors.white), // AppBar text color white
//         ),
//         actions: [
//           ElevatedButton(onPressed: () {
            
//           }, child: Text('Add new patient'))
//         ],
//         backgroundColor: const Color(0xFF2E7D32),
//         iconTheme: const IconThemeData(color: Colors.white), // Back button color white
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView.builder(
//           itemCount: patients.length,
//           itemBuilder: (context, index) {
//             final patient = patients[index];
//             return Card(
//               margin: const EdgeInsets.only(bottom: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 3,
//               child: ListTile(
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 title: Text(
//                   patient['name']!,
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 subtitle: Text('Age: ${patient['age']}  |  Sex: ${patient['sex']}'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.edit, color: Colors.blue),
//                       onPressed: () {
//                         showEditDialog(index);
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       onPressed: () {
//                         setState(() {
//                           patients.removeAt(index);
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   void showEditDialog(int index) {
//     final TextEditingController nameController = TextEditingController(text: patients[index]['name']);
//     final TextEditingController ageController = TextEditingController(text: patients[index]['age']);
//     final TextEditingController sexController = TextEditingController(text: patients[index]['sex']);

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Edit Patient'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
//               TextField(controller: ageController, decoration: const InputDecoration(labelText: 'Age'), keyboardType: TextInputType.number),
//               TextField(controller: sexController, decoration: const InputDecoration(labelText: 'Sex')),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF2E7D32),
//               ),
//               onPressed: () {
//                 setState(() {
//                   patients[index]['name'] = nameController.text;
//                   patients[index]['age'] = ageController.text;
//                   patients[index]['sex'] = sexController.text;
//                 });
//                 Navigator.pop(context);
//               },
//               child: const Text(
//                 'Save',
//                 style: TextStyle(color: Colors.white), // Save button text white
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:renalguide/Caretaker/AddPatient.dart';

class CaretakerPatientPage extends StatefulWidget {
  const CaretakerPatientPage({super.key});

  @override
  State<CaretakerPatientPage> createState() => _CaretakerPatientPageState();
}

class _CaretakerPatientPageState extends State<CaretakerPatientPage> {
  Map<String, String>? patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text(
          'Patient Info',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: patient == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'No patient assigned yet',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        final newPatient = await Navigator.push<Map<String, String>>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddPatientPage(),
                          ),
                        );
                        if (newPatient != null) {
                          setState(() {
                            patient = newPatient;
                          });
                        }
                      },
                      child: const Text(
                        'Add Patient',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            : Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        patient!['name']!,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text('Age: ${patient!['age']}'),
                      const SizedBox(height: 5),
                      Text('Sex: ${patient!['sex']}'),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              _showEditDialog();
                            },
                            icon: const Icon(Icons.edit, size: 18),
                            label: const Text('Edit'),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              setState(() {
                                patient = null;
                              });
                            },
                            icon: const Icon(Icons.delete, size: 18),
                            label: const Text('Delete'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void _showEditDialog() {
    final nameController =
        TextEditingController(text: patient!['name'] ?? '');
    final ageController = TextEditingController(text: patient!['age'] ?? '');
    final sexController = TextEditingController(text: patient!['sex'] ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Patient'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: ageController, decoration: const InputDecoration(labelText: 'Age'), keyboardType: TextInputType.number),
            TextField(controller: sexController, decoration: const InputDecoration(labelText: 'Sex')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
            ),
            onPressed: () {
              setState(() {
                patient = {
                  'name': nameController.text,
                  'age': ageController.text,
                  'sex': sexController.text,
                };
              });
              Navigator.pop(context);
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

