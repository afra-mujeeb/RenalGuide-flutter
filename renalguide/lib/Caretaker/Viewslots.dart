import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // Dummy backend data
  final Map<String, List<String>> dummyData = {
    "2025-01-14": ["10:00 AM", "11:00 AM", "01:00 PM"],
    "2025-01-15": ["09:00 AM", "12:30 PM", "03:00 PM"],
    "2025-01-16": ["08:30 AM", "10:15 AM"],
  };

  String? selectedDate;
  String? bookedSlot;

  Future<void> _showConfirmationDialog(String slot) async {
    final bool? confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Confirm Booking"),
          content: Text("Do you want to book the slot at $slot?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      setState(() {
        bookedSlot = slot;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Slot booked: $slot"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Book a Slot"),
        centerTitle: true,
        backgroundColor: Colors.teal.shade600,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Select Date",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: dummyData.keys.map((date) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.calendar_today, color: Colors.teal),
                    title: Text(
                      date,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    trailing: selectedDate == date
                        ? const Icon(Icons.check_circle, color: Colors.teal)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                        bookedSlot = null;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          if (selectedDate != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available Slots on $selectedDate",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: dummyData[selectedDate]!.map((slot) {
                      bool isBooked = bookedSlot == slot;

                      return ChoiceChip(
                        label: Text(
                          isBooked ? "Booked" : slot,
                          style: TextStyle(
                            color: isBooked ? Colors.white : Colors.black,
                          ),
                        ),
                        selected: isBooked,
                        selectedColor: Colors.teal,
                        backgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onSelected: (_) {
                          if (!isBooked) {
                            _showConfirmationDialog(slot);
                          }
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
