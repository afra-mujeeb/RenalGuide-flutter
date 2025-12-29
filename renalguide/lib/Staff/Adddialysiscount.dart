// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:renalguide/Caretaker/register.dart';
// import 'package:renalguide/Staff/login.dart';

// class AddDialysisCountPage extends StatefulWidget {
//   final int patientId;
//   final Function(int) onCountAdded;

//   const AddDialysisCountPage({
//     super.key,
//     required this.patientId,
//     required this.onCountAdded,
//   });

//   @override
//   State<AddDialysisCountPage> createState() => _AddDialysisCountPageState();
// }

// class _AddDialysisCountPageState extends State<AddDialysisCountPage> {
//   final Dio dio = Dio();
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _countController = TextEditingController();

//   int currentCount = 0;
//   bool isLoading = true;
//   bool isSubmitting = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchCurrentCount();
//   }

//   /// 🔹 GET CURRENT COUNT
//   Future<void> fetchCurrentCount() async {
//     try {
//       final response =
//           await dio.get("$baseurl/addcount/${widget.patientId}");

//       setState(() {
//         currentCount = response.data['count'] ?? 0;
//         isLoading = false;
//       });
//     } catch (e) {
//       isLoading = false;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to load count")),
//       );
//     }
//   }

//   /// 🔹 POST ADD COUNT
//   Future<void> submitCount() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => isSubmitting = true);

//     try {
//       final response = await dio.post(
//         "$baseurl/addcount/${widget.patientId}",
//         data: {"count": int.parse(_countController.text)},
//       );

//       int added = int.parse(_countController.text);
//       widget.onCountAdded(added);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Dialysis count updated")),
//       );

//       Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Update failed")),
//       );
//     } finally {
//       setState(() => isSubmitting = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE8F5E9),

//       appBar: AppBar(
//         backgroundColor: const Color(0xFF2E7D32),
//         title: const Text("Dialysis Count"),
//         centerTitle: true,
//       ),

//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//             child: Center(
//                 child: Card(
//                   elevation: 6,
//                   margin: const EdgeInsets.all(16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(22),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Icon(Icons.monitor_heart,
//                               size: 60, color: Color(0xFF2E7D32)),
            
//                           const SizedBox(height: 15),
            
//                           Text(
//                             "Completed Dialysis",
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.grey.shade700,
//                             ),
//                           ),
            
//                           const SizedBox(height: 6),
            
//                           Text(
//                             "$currentCount",
//                             style: const TextStyle(
//                               fontSize: 36,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF2E7D32),
//                             ),
//                           ),
            
//                           const Divider(height: 40),
            
//                           TextFormField(
//                             controller: _countController,
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(
//                               labelText: "Add Count",
//                               prefixIcon:
//                                   const Icon(Icons.add_circle_outline),
//                               filled: true,
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(14),
//                               ),
//                             ),
//                             validator: (v) {
//                               if (v == null || v.isEmpty) {
//                                 return "Enter count";
//                               }
//                               if (int.tryParse(v) == null) {
//                                 return "Enter valid number";
//                               }
//                               return null;
//                             },
//                           ),
            
//                           const SizedBox(height: 30),
            
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor:
//                                     const Color(0xFF2E7D32),
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 14),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                               ),
//                               onPressed:
//                                   isSubmitting ? null : submitCount,
//                               child: isSubmitting
//                                   ? const CircularProgressIndicator(
//                                       color: Colors.white)
//                                   : const Text(
//                                       "UPDATE COUNT",
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//           ),
//     );
//   }
// }


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
  int newCountToAdd = 1; // Default to 1 session
  bool isLoading = true;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    fetchCurrentCount();
    _countController.text = '1'; // Set default value
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
        data: {"count": newCountToAdd},
      );

      widget.onCountAdded(newCountToAdd);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Dialysis count updated successfully")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Update failed. Please try again.")),
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  void incrementCount() {
    setState(() {
      newCountToAdd++;
      _countController.text = newCountToAdd.toString();
    });
  }

  void decrementCount() {
    if (newCountToAdd > 1) {
      setState(() {
        newCountToAdd--;
        _countController.text = newCountToAdd.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFFA4C8E1),
        title: const Text(
          "Update Dialysis Count",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFA4C8E1),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Header Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFA4C8E1),
                            const Color(0xFFB8D6EB),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFA4C8E1).withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.monitor_heart_rounded,
                            size: 60,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Current Dialysis Sessions",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "$currentCount",
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "completed sessions",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Input Card
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Add New Sessions",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C3E50),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Select the number of dialysis sessions to add",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 24),
                              
                              // Increment/Decrement Widget
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  children: [
                                    Text(
                                      "Sessions to Add",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Decrement Button
                                          IconButton(
                                            onPressed: decrementCount,
                                            icon: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFA4C8E1).withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.remove_rounded,
                                                color: newCountToAdd > 1 
                                                  ? const Color(0xFFA4C8E1) 
                                                  : Colors.grey[400],
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                          
                                          // Count Display
                                          Text(
                                            newCountToAdd.toString(),
                                            style: const TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF2C3E50),
                                            ),
                                          ),
                                          
                                          // Increment Button
                                          IconButton(
                                            onPressed: incrementCount,
                                            icon: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFA4C8E1).withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.add_rounded,
                                                color: Color(0xFFA4C8E1),
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Tap + or - to adjust",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 30),
                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFA4C8E1),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: isSubmitting ? null : submitCount,
                                  child: isSubmitting
                                      ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.check_circle_outline_rounded,
                                              size: 20,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "ADD  SESSION}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Information Box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFA4C8E1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xFFA4C8E1).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: const Color(0xFFA4C8E1),
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "This will add to the patient's total dialysis session count.",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}