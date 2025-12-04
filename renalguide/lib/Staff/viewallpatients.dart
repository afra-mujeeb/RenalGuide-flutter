import 'package:flutter/material.dart';
import 'parameter_form.dart';
import 'Adddialysiscount.dart';

class PatientManagementPage extends StatefulWidget {
  const PatientManagementPage({super.key});

  @override
  State<PatientManagementPage> createState() => _PatientManagementPageState();
}

class _PatientManagementPageState extends State<PatientManagementPage> {
  // Unified patient list
  List<Map<String, dynamic>> patients = [
    {
      "name": "John Doe",
      "hdNo": "HD001",
      "date": "2025-12-01",
      "preBP": "120/80",
      "preTemp": "98.6",
      "preWt": "70",
      "preGain": "0.5",
      "postBP": "118/78",
      "postWt": "69.5",
      "postLoss": "0.5",
      "nextAppointment": "2025-12-03",
      "completedDialysis": 5,
    },
    {
      "name": "Jane Smith",
      "hdNo": "HD002",
      "date": "2025-12-02",
      "preBP": "110/70",
      "preTemp": "99.1",
      "preWt": "65",
      "preGain": "0.3",
      "postBP": "108/68",
      "postWt": "64.7",
      "postLoss": "0.3",
      "nextAppointment": "2025-12-04",
      "completedDialysis": 3,
    },
  ];

  void _updateDialysisCount(int index, int count) {
    setState(() {
      patients[index]["completedDialysis"] += count;
    });
  }

  void _updatePatient(int index, Map<String, dynamic> updatedPatient) {
    setState(() {
      patients[index] = updatedPatient;
    });
  }

  void _deletePatient(int index) {
    setState(() {
      patients.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6FFC1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text(
          "Patient Management",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ParameterForm(),)),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF2E7D32),
                  child: Text(
                    patient["name"][0],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  patient["name"],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF2E7D32)),
                ),
                subtitle: Text(
                    "HD No: ${patient['hdNo']} • Completed Dialysis: ${patient['completedDialysis']}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Add dialysis count
                    IconButton(
                      icon: const Icon(Icons.add, color: Color(0xFF2E7D32)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddDialysisCountPage(
                              onCountAdded: (count) =>
                                  _updateDialysisCount(index, count),
                            ),
                          ),
                        );
                      },
                    ),
                    // Edit patient
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () async {
                        final updatedPatient = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ParameterForm(existing: patient),
                          ),
                        );
                        if (updatedPatient != null) {
                          _updatePatient(index, updatedPatient);
                        }
                      },
                    ),
                    // Delete patient
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Confirm Delete"),
                            content: const Text(
                                "Are you sure you want to delete this patient?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  _deletePatient(index);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
