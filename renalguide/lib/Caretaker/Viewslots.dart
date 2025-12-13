// import 'package:flutter/material.dart';
// import 'package:renalguide/Caretaker/register.dart';

// class BookingPage extends StatefulWidget {
//   const BookingPage({super.key});

//   @override
//   State<BookingPage> createState() => _BookingPageState();
// }

// class _BookingPageState extends State<BookingPage> {
//   // Dummy backend data

 

//   String? selectedDate;
//   String? bookedSlot;
//   List<Map<String, dynamic>> slots = [];
//   bool isloading = true;
//   Future<void> _ViewSlotAvailability() async {
//     try {
//       final response = await dio.get("$baseurl/ViewSlotAvailabilityAPI");
//       print(response.data);
//       if (response.statusCode == 200 && response.data is List) {
//         setState(() {
//           slots = List<Map<String, dynamic>>.from(response.data);
//           isloading = false;
//         });
//       }
//     } catch (e) {
//       setState(() => isloading = false);
//     }
//   }

//   Future<void> _showConfirmationDialog(String slot) async {
//     final bool? confirm = await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: const Text("Confirm Booking"),
//           content: Text("Do you want to book the slot at $slot?"),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context, false),
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () => Navigator.pop(context, true),
//               child: const Text("Confirm"),
//             ),
//           ],
//         );
//       },
//     );

//     if (confirm == true) {
//       setState(() {
//         bookedSlot = slot;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Slot booked: $slot"),
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     }
//   }

//   @override
//   void initState() {
//     _ViewSlotAvailability();
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: const Text("Book a Slot"),
//         centerTitle: true,
//         backgroundColor: Color(0xFF2E7D32),
//       ),

//       body:Padding(padding: const EdgeInsets.all(16),child: isloading
//             ? const Center(child: CircularProgressIndicator()):slots.isEmpty?Center(child: Text("No slots available")):
      
//       ListView.builder(itemCount: slots.length,
//       itemBuilder: (context, index) {
//                   final p = slots[index];
//                   final date=p["date"];
//         return  Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(16),
//             child: Text(
//               "Select Date",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),

//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               children: [ Card(
//                   elevation: 3,
//                   margin: const EdgeInsets.symmetric(vertical: 6),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: ListTile(
//                     leading: const Icon(
//                       Icons.calendar_today,
//                       color: Color(0xFF2E7D32),
//                     ),
//                     title: Text(
//                       p["date"],
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     trailing: selectedDate == date
//                         ? const Icon(
//                             Icons.check_circle,
//                             color: Color(0xFF2E7D32),
//                           )
//                         : null,
//                     onTap: () {
//                       setState(() {
//                         selectedDate = date;
//                         bookedSlot = null;
//                       });
//                     },
//                   ),
//                 )]
//             ),
//           ),

//           if (selectedDate != null)
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(20),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 6,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Available Slots on $selectedDate",
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: [
//                     retur  bool isBooked = bookedSlot == slot;

//                       return ChoiceChip(
//                         label: Text(
//                           isBooked ? "Booked" : slot,
//                           style: TextStyle(
//                             color: isBooked ? Colors.white : Colors.black,
//                           ),
//                         ),
//                         selected: isBooked,
//                         selectedColor: Colors.teal,
//                         backgroundColor: Colors.grey.shade200,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         onSelected: (_) {
//                           if (!isBooked) {
//                             _showConfirmationDialog(slot);
//                           }
//                         },
//                       );
//                     ]
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       );
//       },)
//       ,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:renalguide/Caretaker/register.dart';
import 'package:renalguide/Staff/login.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String? selectedDate;
  String? selectedTime;

  List<Map<String, dynamic>> slots = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _viewSlotAvailability();
  }

  // 🔹 GET SLOT AVAILABILITY
  Future<void> _viewSlotAvailability() async {
    try {
      final response = await dio.get("$baseurl/ViewSlotAvailabilityAPI");
      print("SLOTS => ${response.data}");

      if (response.statusCode == 200 && response.data is List) {
        setState(() {
          slots = List<Map<String, dynamic>>.from(response.data);
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
      print("Error loading slots: $e");
    }
  }

  // 🔹 POST BOOK SLOT
  Future<void> _bookSlot(int id) async {
    try {
      final response = await dio.post(
        "$baseurl/ViewSlotBookingAPI/$lid",
        data: {
          "date": selectedDate,
          "time": selectedTime,
          "SLOT":id
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Slot booked successfully")),
        );

        // Refresh slots
        _viewSlotAvailability();
      }
    } catch (e) {
      print("Booking failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Slot booking failed")),
      );
    }
  }

  // 🔹 CONFIRM DIALOG
  void _confirmBooking(String time,int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Booking"),
        content: Text("Book slot at $time ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
            ),
            onPressed: () {
              Navigator.pop(context);
              setState(() => selectedTime = time);
              _bookSlot(id);
            },
            child: const Text(
              "Confirm",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Book Dialysis Slot"),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : slots.isEmpty
                ? const Center(child: Text("No slots available"))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Date",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      // 🔹 DATE LIST
                      SizedBox(
                        height: 65,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: slots
                              .map((slot) => slot["date"])
                              .toSet()
                              .map(
                                (date) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedDate = date;
                                      selectedTime = null;
                                    });
                                  },
                                  child: Card(
                                    color: selectedDate == date
                                        ? const Color(0xFF2E7D32)
                                        : Colors.white,
                                    margin:
                                        const EdgeInsets.symmetric(horizontal: 6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Text(
                                        date,
                                        style: TextStyle(
                                          color: selectedDate == date
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),

                      const SizedBox(height: 20),

                      if (selectedDate != null) ...[
                        const Text(
                          "Available Slots",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),

                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: slots
                              .where((s) => s["date"] == selectedDate)
                              .map((slot) {
                            final time = slot["time"];
                            final id = slot["id"];
                            final availability = slot["availability"];
                            final isBooked = availability == "Booked";

                            return ChoiceChip(
                              label: Text(
                                isBooked ? "Booked" : time,
                                style: TextStyle(
                                  color:
                                      isBooked ? Colors.white : Colors.black,
                                ),
                              ),
                              selected: selectedTime == time,
                              selectedColor: const Color(0xFF2E7D32),
                              backgroundColor:
                                  isBooked ? Colors.red : Colors.grey.shade200,
                              onSelected:
                                  isBooked ? null : (_) => _confirmBooking(time,id),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
      ),
    );
  }
}
