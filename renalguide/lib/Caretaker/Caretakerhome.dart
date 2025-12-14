import 'package:flutter/material.dart';
import 'package:renalguide/Caretaker/AddPatientrecords.dart';
import 'package:renalguide/Caretaker/Chatwithdoctor.dart';
import 'package:renalguide/Caretaker/Doctorbooking.dart';
import 'package:renalguide/Caretaker/Doctorbookinghistory.dart';
import 'package:renalguide/Caretaker/Viewpatient.dart';
import 'package:renalguide/Caretaker/Viewprescription.dart';
import 'package:renalguide/Caretaker/Viewslothistory.dart';
import 'package:renalguide/Caretaker/Viewslots.dart';
import 'package:renalguide/Caretaker/caretakerprofile.dart';
import 'package:renalguide/Caretaker/register.dart';
import 'package:renalguide/Staff/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? patient;
  bool isloading=true;

 Future<void>_HomePage() async {
  try{

    final response = await dio.get("$baseurl/ViewPatientAPI/$lid");
    isloading=true;
    print(response.data);
    if(response.statusCode==200) {
      setState(() {
        patient = Map<String,dynamic>.from(response.data);
        isloading=false;
      });
    }
  } catch (e) {
    print("Error loading patients: $e");
  }
} 
  @override
  Widget build(BuildContext context) {
    // Example dialysis data
    int completedDialysis = 12;

    return Scaffold(
      backgroundColor: const Color(0xFFD6FFC1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text(
          "Dialysis Dashboard",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dialysis count circle
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$completedDialysis",
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Dialysis Completed",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Buttons grid
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                children: [
                  buildGradientButton(
                    context,
                    icon: Icons.person_add_alt_1,
                    label: "Add & Manage Patient",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CaretakerPatientPage(),));
                    },
                    colors: [Color(0xFF81C784), Color(0xFF2E7D32)],
                  ),
                  buildGradientButton(
                    context,
                    icon: Icons.schedule,
                    label: "View Slot Availability",
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => BookingPage(),));},
                    colors: [Color(0xFF4DB6AC), Color(0xFF2E7D32)],
                  ),
                   buildGradientButton(
                    context,
                    icon: Icons.schedule,
                    label: "View Slot History",
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSlotHistoryScreen(),));},
                    colors: [Color(0xFF4DB6AC), Color(0xFF2E7D32)],
                  ),
                  buildGradientButton(
                    context,
                    icon: Icons.schedule,
                    label: "Book Doctor",
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDoctorsscreen(),));},
                    colors: [Color(0xFF4DB6AC), Color(0xFF2E7D32)],
                  ),
                  buildGradientButton(
                    context,
                    icon: Icons.schedule,
                    label: "View doctor booking history",
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDoctorBookingHistory(),));},
                    colors: [Color(0xFF4DB6AC), Color(0xFF2E7D32)],
                  ),
                  buildGradientButton(
                    context,
                    icon: Icons.chat,
                    label: "Chat with Doctor",
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(caretakerName: '', doctorName: '',),));},
                    colors: [Color(0xFF64B5F6), Color(0xFF2E7D32)],
                  ),
                  buildGradientButton(
                    context,
                    icon: Icons.receipt_long,
                    label: "View Prescriptions",
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Viewprescriptionscreen(),));},
                    colors: [Color(0xFFFFB74D), Color(0xFF2E7D32)],
                  ),
                  buildGradientButton(
                    context,
                    icon: Icons.receipt_long,
                    label: "View Profile",
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CaretakerProfilePage(),));},
                    colors: [Color(0xFFFFB74D), Color(0xFF2E7D32)],
                  ),
                   buildGradientButton(
                    context,
                    icon: Icons.schedule,
                    label: "Add Patient Records",
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AddPatientRecordsPage(),));},
                    colors: [Color(0xFF4DB6AC), Color(0xFF2E7D32)],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGradientButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap,
      required List<Color> colors}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colors.last.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
