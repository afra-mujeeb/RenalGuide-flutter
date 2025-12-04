import 'package:flutter/material.dart';
import 'package:renalguide/Caretaker/caretakerprofile.dart';
import 'package:renalguide/Staff/Adddialysiscount.dart';
import 'package:renalguide/Staff/Profile.dart';
import 'package:renalguide/Staff/parameter_form.dart';
import 'package:renalguide/Staff/viewallpatients.dart';


class StaffHomePage extends StatelessWidget {
  const StaffHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6FFC1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text(
          'Staff Home',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // StaffButton(
            //   icon: Icons.add,
            //   label: 'Add Dialysis Count',
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (_) => AddDialysisCountPage(
            //           onCountAdded: (count) {
            //             // Handle count addition
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               SnackBar(
            //                 content:
            //                     Text('Dialysis count added: $count'),
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //     );
            //   },
            // ),
            // const SizedBox(height: 20),
            // StaffButton(
            //   icon: Icons.list_alt,
            //   label: 'Add dialysis count',
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (_) =>  AddDialysisCountPage(onCountAdded: (int p1) {  },),
            //       ),
            //     );
            //   },
            // ),
            const SizedBox(height: 20),
            StaffButton(
              icon: Icons.list_alt,
              label: 'View All Patients',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PatientManagementPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            StaffButton(
              icon: Icons.add_chart,
              label: 'View profile',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StaffProfilePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable button widget
class StaffButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const StaffButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 24, color: Colors.white),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2E7D32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
