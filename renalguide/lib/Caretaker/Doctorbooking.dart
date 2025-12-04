import 'package:flutter/material.dart';

class ViewDoctorsscreen extends StatelessWidget {
  ViewDoctorsscreen({super.key});

  List<Map<String, dynamic>> history = [
    {
      'Name': 'abc',
      'Sex': 'male',
      'Qualification': 'MBBS',
      'Experience': '4 years',
      'photo': 'https://www.shutterstock.com/image-photo/healthcare-medical-staff-concept-portrait-600nw-2281024823.jpg'
    },
    {
      'Name': 'afra',
      'Sex': 'female',
      'Qualification': 'MBBS',
      'Experience': '5 years',
      'photo': 'https://www.shutterstock.com/image-photo/healthcare-medical-staff-concept-portrait-600nw-2281024823.jpg'
    },
    {
      'Name': 'nia',
      'Sex': 'male',
      'Qualification': 'MBBS',
      'Experience': '6 years',
      'photo': 'https://www.shutterstock.com/image-photo/healthcare-medical-staff-concept-portrait-600nw-2281024823.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text(
          "Doctors",
          style: TextStyle(color: Colors.white), // WHITE TEXT
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32), // UPDATED APPBAR COLOR
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), // Back button white
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: history.length,
        itemBuilder: (context, index) {
          var doc = history[index];

          return Card(
            elevation: 3,
            shadowColor: Colors.grey.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            margin: const EdgeInsets.only(bottom: 16),

            child: Padding(
              padding: const EdgeInsets.all(16.0),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// LEFT - Doctor Photo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      doc['photo'],
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 16),

                  /// RIGHT - Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// Name
                        Text(
                          doc['Name'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text("Sex: ${doc['Sex']}",
                            style: const TextStyle(fontSize: 15)),
                        Text("Qualification: ${doc['Qualification']}",
                            style: const TextStyle(fontSize: 15)),
                        Text("Experience: ${doc['Experience']}",
                            style: const TextStyle(fontSize: 15)),

                        const SizedBox(height: 12),

                        /// Book Button
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E7D32), // NEW COLOR
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Book",
                              style: TextStyle(
                                color: Colors.white, // WHITE TEXT
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
