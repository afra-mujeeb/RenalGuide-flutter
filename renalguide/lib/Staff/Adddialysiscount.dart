import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:renalguide/Caretaker/register.dart';
import 'package:renalguide/Staff/login.dart';

class AddDialysisCountPage extends StatefulWidget {
  final int patientId;
  final Function(int) onCountAdded;

  const AddDialysisCountPage({
    super.key,
    required this.patientId,
    required this.onCountAdded,
  });

  @override
  State<AddDialysisCountPage> createState() => _AddDialysisCountPageState();
}

class _AddDialysisCountPageState extends State<AddDialysisCountPage> {
  final Dio dio = Dio();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _countController = TextEditingController();

  int currentCount = 0;
  bool isLoading = true;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    fetchCurrentCount();
  }

  /// 🔹 GET CURRENT COUNT
  Future<void> fetchCurrentCount() async {
    try {
      final response =
          await dio.get("$baseurl/addcount/${widget.patientId}");

      setState(() {
        currentCount = response.data['count'] ?? 0;
        isLoading = false;
      });
    } catch (e) {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load count")),
      );
    }
  }

  /// 🔹 POST ADD COUNT
  Future<void> submitCount() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);

    try {
      final response = await dio.post(
        "$baseurl/addcount/${widget.patientId}",
        data: {"count": int.parse(_countController.text)},
      );

      int added = int.parse(_countController.text);
      widget.onCountAdded(added);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Dialysis count updated")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Update failed")),
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text("Dialysis Count"),
        centerTitle: true,
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Center(
                child: Card(
                  elevation: 6,
                  margin: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.monitor_heart,
                              size: 60, color: Color(0xFF2E7D32)),
            
                          const SizedBox(height: 15),
            
                          Text(
                            "Completed Dialysis",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade700,
                            ),
                          ),
            
                          const SizedBox(height: 6),
            
                          Text(
                            "$currentCount",
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
            
                          const Divider(height: 40),
            
                          TextFormField(
                            controller: _countController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Add Count",
                              prefixIcon:
                                  const Icon(Icons.add_circle_outline),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Enter count";
                              }
                              if (int.tryParse(v) == null) {
                                return "Enter valid number";
                              }
                              return null;
                            },
                          ),
            
                          const SizedBox(height: 30),
            
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF2E7D32),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed:
                                  isSubmitting ? null : submitCount,
                              child: isSubmitting
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text(
                                      "UPDATE COUNT",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ),
    );
  }
}
