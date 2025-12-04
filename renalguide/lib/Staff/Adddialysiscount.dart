import 'package:flutter/material.dart';

class AddDialysisCountPage extends StatefulWidget {
  final Function(int) onCountAdded; // Callback to update count

  const AddDialysisCountPage({super.key, required this.onCountAdded});

  @override
  State<AddDialysisCountPage> createState() => _AddDialysisCountPageState();
}

class _AddDialysisCountPageState extends State<AddDialysisCountPage> {
  final _formKey = GlobalKey<FormState>();
  final _countController = TextEditingController();

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6FFC1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text(
          "Add Dialysis Count",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextFormField(
              controller: _countController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Dialysis Count",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                fillColor: Colors.white,
                filled: true,
                isDense: true,
                prefixIcon: const Icon(Icons.add, color: Color(0xFF2E7D32)),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return "Enter count";
                if (int.tryParse(v) == null) return "Enter a valid number";
                return null;
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                shadowColor: Colors.black.withOpacity(0.2),
                elevation: 5,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  int count = int.parse(_countController.text);
                  widget.onCountAdded(count); // Send count back
                  Navigator.pop(context);
                }
              },
              child: const Text(
                "ADD COUNT",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
