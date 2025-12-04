import 'package:flutter/material.dart';
import 'parameter_form.dart';

class ViewParametersScreen extends StatefulWidget {
  const ViewParametersScreen({super.key});

  @override
  State<ViewParametersScreen> createState() => _ViewParametersScreenState();
}

class _ViewParametersScreenState extends State<ViewParametersScreen> {
  List<Map<String, dynamic>> entries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6FFC1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text(
          "View Patient Parameters",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2E7D32),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final newEntry = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ParameterForm()),
          );
          if (newEntry != null) {
            setState(() {
              entries.add(newEntry);
            });
          }
        },
      ),
      body: entries.isEmpty
          ? const Center(
              child: Text(
                "No entries yet",
                style: TextStyle(fontSize: 16),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: entries.map((entry) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date: ${entry['date']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () async {
                                      final updated = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ParameterForm(existing: entry),
                                        ),
                                      );
                                      if (updated != null) {
                                        setState(() {
                                          final index = entries.indexOf(entry);
                                          entries[index] = updated;
                                        });
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text("Confirm Delete"),
                                          content: const Text(
                                              "Are you sure you want to delete this entry?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  entries.remove(entry);
                                                });
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
                            ],
                          ),
                          const SizedBox(height: 8),
                          buildRow("HD No.", entry["hdNo"]),
                          const SizedBox(height: 4),
                          buildRow("Pre BP", entry["preBP"]),
                          buildRow("Temp", entry["preTemp"]),
                          buildRow("Weight", entry["preWt"]),
                          buildRow("Weight Gain", entry["preGain"]),
                          const SizedBox(height: 8),
                          buildRow("Post BP", entry["postBP"]),
                          buildRow("Weight", entry["postWt"]),
                          buildRow("Weight Loss", entry["postLoss"]),
                          const SizedBox(height: 8),
                          buildRow("Next Appointment", entry["nextAppointment"]),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
