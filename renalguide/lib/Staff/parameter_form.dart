import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ParameterForm extends StatefulWidget {
  final Map<String, dynamic>? existing;

  const ParameterForm({super.key, this.existing});

  @override
  State<ParameterForm> createState() => _ParameterFormState();
}

class _ParameterFormState extends State<ParameterForm> {
  final _formKey = GlobalKey<FormState>();

  final date = TextEditingController();
  final hdNo = TextEditingController();

  final preBP = TextEditingController();
  final preTemp = TextEditingController();
  final preWt = TextEditingController();
  final preGain = TextEditingController();

  final postBP = TextEditingController();
  final postWt = TextEditingController();
  final postLoss = TextEditingController();

  final nextAppointment = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.existing != null) {
      final data = widget.existing!;
      date.text = data["date"];
      hdNo.text = data["hdNo"];
      preBP.text = data["preBP"];
      preTemp.text = data["preTemp"];
      preWt.text = data["preWt"];
      preGain.text = data["preGain"];
      postBP.text = data["postBP"];
      postWt.text = data["postWt"];
      postLoss.text = data["postLoss"];
      nextAppointment.text = data["nextAppointment"];
    }
  }

  Future<void> pickDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(primary: Color(0xFF2E7D32)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existing != null;

    return Scaffold(
      backgroundColor: const Color(0xFFD6FFC1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: Text(
          isEditing ? "Edit Entry" : "Add Entry",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: buildDateField("Date", date)),
                  const SizedBox(width: 10),
                  Expanded(child: buildField("HD Number", hdNo)),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Pre HD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Row(
                children: [
                  Expanded(child: buildField("BP", preBP)),
                  const SizedBox(width: 10),
                  Expanded(child: buildField("Temp", preTemp)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: buildField("Weight", preWt)),
                  const SizedBox(width: 10),
                  Expanded(child: buildField("Weight Gain", preGain)),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Post HD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Row(
                children: [
                  Expanded(child: buildField("BP", postBP)),
                  const SizedBox(width: 10),
                  Expanded(child: buildField("Weight", postWt)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: buildField("Weight Loss", postLoss)),
                  const SizedBox(width: 10),
                  Expanded(child: buildDateField("Next Appointment", nextAppointment)),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, {
                      "date": date.text,
                      "hdNo": hdNo.text,
                      "preBP": preBP.text,
                      "preTemp": preTemp.text,
                      "preWt": preWt.text,
                      "preGain": preGain.text,
                      "postBP": postBP.text,
                      "postWt": postWt.text,
                      "postLoss": postLoss.text,
                      "nextAppointment": nextAppointment.text,
                    });
                  }
                },
                child: Text(isEditing ? "UPDATE" : "SAVE", style: const TextStyle(fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        isDense: true,
        fillColor: const Color(0xFFF8F8FF),
        filled: true,
      ),
      validator: (v) => v!.isEmpty ? "Required" : null,
    );
  }

  Widget buildDateField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () => pickDate(controller),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        isDense: true,
        fillColor: const Color(0xFFF8F8FF),
        filled: true,
        suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF2E7D32)),
      ),
      validator: (v) => v!.isEmpty ? "Select Date" : null,
    );
  }
}
