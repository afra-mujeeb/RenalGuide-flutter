// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ParameterForm extends StatefulWidget {
//   final Map<String, dynamic>? existing;

//   const ParameterForm({super.key, this.existing});

//   @override
//   State<ParameterForm> createState() => _ParameterFormState();
// }

// class _ParameterFormState extends State<ParameterForm> {
//   final _formKey = GlobalKey<FormState>();

//   final date = TextEditingController();
//   final hdNo = TextEditingController();

//   final preBP = TextEditingController();
//   final preTemp = TextEditingController();
//   final preWt = TextEditingController();
//   final preGain = TextEditingController();

//   final postBP = TextEditingController();
//   final postWt = TextEditingController();
//   final postLoss = TextEditingController();

//   // final nextAppointment = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     if (widget.existing != null) {
//       final data = widget.existing!;
//       date.text = data["date"];
//       hdNo.text = data["hdNo"];
//       preBP.text = data["preBP"];
//       preTemp.text = data["preTemp"];
//       preWt.text = data["preWt"];
//       preGain.text = data["preGain"];
//       postBP.text = data["postBP"];
//       postWt.text = data["postWt"];
//       postLoss.text = data["postLoss"];
//       // nextAppointment.text = data["nextAppointment"];
//     }
//   }

//   Future<void> pickDate(TextEditingController controller) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//       initialDate: DateTime.now(),
//       builder: (context, child) => Theme(
//         data: ThemeData(
//           colorScheme: const ColorScheme.light(primary: Color(0xFF2E7D32)),
//         ),
//         child: child!,
//       ),
//     );
//     if (picked != null) {
//       controller.text = DateFormat('yyyy-MM-dd').format(picked);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isEditing = widget.existing != null;

//     return Scaffold(
//       backgroundColor: const Color(0xFFD6FFC1),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF2E7D32),
//         title: Text(
//           isEditing ? "Edit Entry" : "Add Entry",
//           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(child: buildDateField("Date", date)),
//                   const SizedBox(width: 10),
//                   Expanded(child: buildField("HD Number", hdNo)),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const Text("Pre HD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               Row(
//                 children: [
//                   Expanded(child: buildField("BP", preBP)),
//                   const SizedBox(width: 10),
//                   Expanded(child: buildField("Temp", preTemp)),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(child: buildField("Weight", preWt)),
//                   const SizedBox(width: 10),
//                   Expanded(child: buildField("Weight Gain", preGain)),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const Text("Post HD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               Row(
//                 children: [
//                   Expanded(child: buildField("BP", postBP)),
//                   const SizedBox(width: 10),
//                   Expanded(child: buildField("Weight", postWt)),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(child: buildField("Weight Loss", postLoss)),
//                   const SizedBox(width: 10),
//                   // Expanded(child: buildDateField("Next Appointment", nextAppointment)),
//                 ],
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF2E7D32),
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                 ),
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     Navigator.pop(context, {
//                       "date": date.text,
//                       "hdNo": hdNo.text,
//                       "preBP": preBP.text,
//                       "preTemp": preTemp.text,
//                       "preWt": preWt.text,
//                       "preGain": preGain.text,
//                       "postBP": postBP.text,
//                       "postWt": postWt.text,
//                       "postLoss": postLoss.text,
//                       // "nextAppointment": nextAppointment.text,
//                     });
//                   }
//                 },
//                 child: Text(isEditing ? "UPDATE" : "SAVE", style: const TextStyle(fontSize: 16)),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildField(String label, TextEditingController controller) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         isDense: true,
//         fillColor: const Color(0xFFF8F8FF),
//         filled: true,
//       ),
//       validator: (v) => v!.isEmpty ? "Required" : null,
//     );
//   }

//   Widget buildDateField(String label, TextEditingController controller) {
//     return TextFormField(
//       controller: controller,
//       readOnly: true,
//       onTap: () => pickDate(controller),
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         isDense: true,
//         fillColor: const Color(0xFFF8F8FF),
//         filled: true,
//         suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF2E7D32)),
//       ),
//       validator: (v) => v!.isEmpty ? "Select Date" : null,
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:renalguide/Caretaker/register.dart';

class ParameterForm extends StatefulWidget {
  final int patientId;
  final Map<String, dynamic>? existing;

  const ParameterForm({
    super.key,
    required this.patientId,
    this.existing,
  });

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

  @override
  void initState() {
    super.initState();

    if (widget.existing != null) {
      final e = widget.existing!;

      date.text = e['date']?.toString() ?? '';
      hdNo.text = e['numberofHD']?.toString() ?? '';
      preBP.text = e['bloodpressure']?.toString() ?? '';
      preTemp.text = e['temperature']?.toString() ?? '';
      preWt.text = e['weight']?.toString() ?? '';
      preGain.text = e['weightgain']?.toString() ?? '';
      postBP.text = e['bloodpressure']?.toString() ?? '';
      postWt.text = e['weight']?.toString() ?? '';
      postLoss.text = e['weightloss']?.toString() ?? '';
    }
  }

  Future<void> pickDate() async {
    DateTime? d = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (d != null) {
      date.text = DateFormat('yyyy-MM-dd').format(d);
    }
  }

  Future<void> save() async {
    final body = {
      "date": date.text,
      "numberofHD": hdNo.text,
      "pre_bp": preBP.text,
      "post_bp":postBP.text,
      "pre_temp": preTemp.text,
      "pre_weight": preWt.text,
      "pre_weightgain": preGain.text,
      "post_weightloss": postLoss.text,
      "post_weight":postWt.text
    };

    http.Response res;

    if (widget.existing == null) {
      res = await http.post(
        Uri.parse("$baseurl/hd/${widget.patientId}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
    } else {
      res = await http.put(
        Uri.parse("$baseurl/parameters/update/${widget.existing!['id']}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
    }

    if (res.statusCode == 200 || res.statusCode == 201) {
      Navigator.pop(context, true);
    }
  }

  Widget field(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6FFC1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: Text(
          widget.existing == null ? "Add Parameters" : "Edit Parameters",
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: date,
                readOnly: true,
                onTap: pickDate,
                decoration: const InputDecoration(labelText: "Date"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 15),

              field("HD Number", hdNo),
              field("Pre BP", preBP),
              field("Temperature", preTemp),
              field("Pre Weight", preWt),
              field("Weight Gain", preGain),
              field("Post BP", postBP),
              field("Post Weight", postWt),
              field("Weight Loss", postLoss),

              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    save();
                  }
                },
                child: const Text(
                  "SAVE",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
