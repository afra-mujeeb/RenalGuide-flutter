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
import 'package:renalguide/Caretaker/register.dart';
import 'package:renalguide/Staff/login.dart';

class CaretakerPatientPage extends StatefulWidget {
  const CaretakerPatientPage({super.key});

  @override
  State<CaretakerPatientPage> createState() => _CaretakerPatientPageState();
}

class _CaretakerPatientPageState extends State<CaretakerPatientPage> {
  List<Map<String, dynamic>> patient = [];
  bool isloading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Viewpatient();
  }

  Future<void> _Viewpatient() async {
    try {
      final response = await dio.get("$baseurl/ViewPatientAPI/$lid");
      print("+++++++++++++, ${response.data}");

      if (response.statusCode == 200 && response.data is List) {
        setState(() {
          patient = List<Map<String, dynamic>>.from(response.data);
          isloading = false;
        });
      }
    } catch (e) {
      setState(() => isloading = false);
      print("Error loading patients: $e");
    }
  }

  Future<void> deletepatient(int id) async {
    try {
      final response = await dio.get("$baseurl/Deletepatient/$id");
      print(response.data);
      if (response.statusCode==200) {
        ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Patient deleted successfully")));
      }
    _Viewpatient();
      
    } catch (e) {
      setState(() => isloading = false);
      print("Error loading patients: $e");
    }
  }

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
        child: isloading
            ? const Center(child: CircularProgressIndicator())
            : patient.isEmpty
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
                          horizontal: 30,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        final newPatient =
                            await Navigator.push<List<Map<String, dynamic>>>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddPatientPage(),
                              ),
                            );
                        _Viewpatient();
                        if (newPatient != null) {
                          setState(() {
                            patient = newPatient;
                          });
                        }
                      },
                      child: const Text(
                        'Add Patient',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: patient.length,
                itemBuilder: (context, index) {
                  final p = patient[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p['name'] ?? '',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Age: ${p['age'] ?? 'N/A'}'),
                          Text('Sex: ${p['sex'] ?? 'N/A'}'),
                          Text('Blood group: ${p['bloodgroup'] ?? 'N/A'}'),
                          Text('Diagnosis: ${p['diagnosis'] ?? 'N/A'}'),

                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  _showEditDialog(index);
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  deletepatient(p["id"]);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  void _showEditDialog(int index) {
    final p = patient[index];

    final nameController = TextEditingController(text: p['name']);
    final ageController = TextEditingController(text: p['age'].toString());
    final sexController = TextEditingController(text: p['sex']);
    final bloodgroupController = TextEditingController(text: p['bloodgroup']);
    final diagnosisController = TextEditingController(text: p['diagnosis']);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Patient'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              TextField(
                controller: sexController,
                decoration: const InputDecoration(labelText: 'Sex'),
              ),
              TextField(
                controller: bloodgroupController,
                decoration: const InputDecoration(labelText: 'Blood Group'),
              ),
              TextField(
                controller: diagnosisController,
                decoration: const InputDecoration(labelText: 'Diagnosis'),
              ),
            ],
          ),
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
                patient[index] = {
                  'name': nameController.text,
                  'age': ageController.text,
                  'sex': sexController.text,
                  'bloodgroup': bloodgroupController.text,
                  'diagnosis': diagnosisController.text,
                };
              });
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
