import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:renalguide/Caretaker/register.dart';
import 'parameter_form.dart';

class ViewParametersScreen extends StatefulWidget {
  final int patientId;
  const ViewParametersScreen({super.key, required this.patientId});

  @override
  State<ViewParametersScreen> createState() => _ViewParametersScreenState();
}

class _ViewParametersScreenState extends State<ViewParametersScreen> {
  List<Map<String, dynamic>> entries = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchParameters();
  }

  // ================= FETCH + MERGE API =================
  Future<void> fetchParameters() async {
    final res =
        await http.get(Uri.parse("$baseurl/viewhd/${widget.patientId}"));
        print(res.body);
    if (res.statusCode == 200) {
      final decoded = jsonDecode(res.body);

      final List pre = decoded['pre_hd'] ?? [];
      final List post = decoded['post_hd'] ?? [];

      List<Map<String, dynamic>> combined = [];

      for (int i = 0; i < pre.length; i++) {
        final preMap = Map<String, dynamic>.from(pre[i]);
        final postMap = i < post.length
            ? Map<String, dynamic>.from(post[i])
            : <String, dynamic>{};

        combined.add({
          ...preMap,
          ...postMap,
        });
      }

      setState(() {
        entries = combined;
        loading = false;
      });
    } else {
      setState(() => loading = false);
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6FFC1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text(
          "Patient Parameters",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2E7D32),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final ok = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ParameterForm(patientId: widget.patientId),
            ),
          );
          if (ok == true) fetchParameters();
        },
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : entries.isEmpty
              ? const Center(child: Text("No records found"))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: entries.length,
                  itemBuilder: (_, i) {
                    final e = entries[i];
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ================= HEADER =================
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Date: ${e['date']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () async {
                                    final ok = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ParameterForm(
                                          patientId: widget.patientId,
                                          existing: e,
                                        ),
                                      ),
                                    );
                                    if (ok == true) fetchParameters();
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),
                            Text("HD No: ${e['numberofHD']}"),

                            const Divider(),

                            // ================= PRE HD =================
                            const Text("Pre HD",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text("BP: ${e['bloodpressure']}"),
                            Text("Temperature: ${e['temperature']}"),
                            Text("Weight: ${e['weight']}"),
                            Text("Weight Gain: ${e['weightgain']}"),

                            const Divider(),

                            // ================= POST HD =================
                            const Text("Post HD",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text("BP: ${e['bloodpressure']}"),
                            Text("Weight: ${e['weight']}"),
                            Text("Weight Loss: ${e['weightloss']}"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
