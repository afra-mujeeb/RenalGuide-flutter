// import 'package:flutter/material.dart';
// import 'package:renalguide/Caretaker/Caretakerhome.dart';
// import 'package:renalguide/Caretaker/register.dart';
// import 'package:renalguide/Staff/Staffhome.dart';

// int? lid;
// String? usertype;

// class Loginscreen extends StatefulWidget {
//   const Loginscreen({super.key});

//   @override
//   State<Loginscreen> createState() => _LoginscreenState();
// }

// class _LoginscreenState extends State<Loginscreen> {
//   final TextEditingController username = TextEditingController();
//   final TextEditingController password = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   bool hidePassword = true;

//   Future<void> _login(context) async {
//     Map<String, dynamic> data = {
//       'username': username.text,
//       'password': password.text,
//     };
//     try {
//       final response = await dio.post('$baseurl/LoginPage_api', data: data);
//       print('========================>>>>>>>>>>${response.data}');
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         lid = response.data['login_id'];
//         usertype = response.data['UserType'];
//         print('========================>>>>>>>>>>$usertype');

//         if (usertype == 'Caretaker') {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => HomePage()),
//             (route) => false,
//           );
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text('Login successful')));
//         } else if (usertype == 'Nurse') {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => StaffHomePage()),
//             (route) => false,
//           );
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text('Login successful')));
//         } else {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text('Login failed')));
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9FFF9),

//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(30),
//               boxShadow: [
//                 BoxShadow(
//                   blurRadius: 20,
//                   offset: const Offset(0, 10),
//                   color: Colors.black.withOpacity(0.1),
//                 ),
//               ],
//             ),

//             child: Form(
//               key: formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Welcome Back",
//                     style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//                   ),

//                   const SizedBox(height: 5),

//                   const Text(
//                     "Please log in to continue",
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                   ),

//                   const SizedBox(height: 25),

//                   const Text(
//                     "Username",
//                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//                   ),
//                   const SizedBox(height: 6),

//                   TextFormField(
//                     controller: username,
//                     validator: (value) =>
//                         value!.isEmpty ? "Enter username" : null,
//                     decoration: InputDecoration(
//                       hintText: 'Enter username',
//                       filled: true,
//                       fillColor: const Color(0xFFF5F7F9),
//                       prefixIcon: const Icon(Icons.person, color: Colors.grey),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 18),

//                   const Text(
//                     "Password",
//                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//                   ),
//                   const SizedBox(height: 6),

//                   TextFormField(
//                     controller: password,
//                     obscureText: hidePassword,
//                     validator: (value) =>
//                         value!.isEmpty ? "Enter password" : null,
//                     decoration: InputDecoration(
//                       hintText: 'Enter password',
//                       filled: true,
//                       fillColor: const Color(0xFFF5F7F9),
//                       prefixIcon: const Icon(Icons.lock, color: Colors.grey),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           hidePassword
//                               ? Icons.visibility_off
//                               : Icons.visibility,
//                           color: Colors.grey,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             hidePassword = !hidePassword;
//                           });
//                         },
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 25),

//                   // Login Button (green gradient)
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
//                       ),
//                     ),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         shadowColor: Colors.transparent,
//                         elevation: 0,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                       onPressed: () {
//                         if (formKey.currentState!.validate()) {
//                           _login(context);
//                         }
//                       },
//                       child: const Text(
//                         "Login",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 17,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   Center(
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Registerscreen(),
//                           ),
//                         );
//                       },
//                       child: const Text(
//                         "Don't have an account? Register",
//                         style: TextStyle(
//                           color: Color(0xFF2E7D32),
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:renalguide/Caretaker/Caretakerhome.dart';
import 'package:renalguide/Caretaker/register.dart';
import 'package:renalguide/Staff/Staffhome.dart';


int? lid;
String? usertype;

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool hidePassword = true;

  Future<void> _login(context) async {
    Map<String, dynamic> data = {
      'username': username.text,
      'password': password.text,
    };
    try {
      final response = await dio.post('$baseurl/LoginPage_api', data: data);
      print('========================>>>>>>>>>>${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        lid = response.data['login_id'];
        usertype = response.data['UserType'];
        print('========================>>>>>>>>>>$usertype');

        if (usertype == 'Caretaker') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false,
          );
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(
            content: Text('Login successful'),
            backgroundColor: Color(0xFFA4C8E1),
          ));
        } else if (usertype == 'Nurse') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => StaffHomePage()),
            (route) => false,
          );
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(
            content: Text('Login successful'),
            backgroundColor: Color(0xFFA4C8E1),
          ));
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Login failed')));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7FF), // Changed to light blue background

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),

            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA4C8E1).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.medical_services_rounded,
                          color: Color(0xFFA4C8E1),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Welcome Back",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Please log in to continue",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Username",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF2C3E50)),
                  ),
                  const SizedBox(height: 6),

                  TextFormField(
                    controller: username,
                    validator: (value) =>
                        value!.isEmpty ? "Enter username" : null,
                    decoration: InputDecoration(
                      hintText: 'Enter username',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: Icon(Icons.person_outline_rounded, color: Color(0xFFA4C8E1)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFFA4C8E1),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF2C3E50)),
                  ),
                  const SizedBox(height: 6),

                  TextFormField(
                    controller: password,
                    obscureText: hidePassword,
                    validator: (value) =>
                        value!.isEmpty ? "Enter password" : null,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: Icon(Icons.lock_outline_rounded, color: Color(0xFFA4C8E1)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          color: Color(0xFFA4C8E1),
                        ),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFFA4C8E1),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Login Button (blue gradient)
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFA4C8E1), Color(0xFF7BB4D9)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFA4C8E1).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _login(context);
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.login_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  
                  
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
                          color: Color(0xFFA4C8E1),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Login with your credentials",
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
        ),
      ),
    );
  }
}