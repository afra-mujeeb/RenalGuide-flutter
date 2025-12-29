// import 'package:flutter/material.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key, required this.caretakerName, required this.doctorName});

//   final String caretakerName;
//   final String doctorName;

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final List<Map<String, dynamic>> messages = [];
//   final TextEditingController messageController = TextEditingController();
//   final ScrollController scrollController = ScrollController();

//   void sendMessage(String text, bool isCaretaker) {
//     if (text.trim().isEmpty) return;
//     setState(() {
//       messages.add({
//         'sender': isCaretaker ? widget.caretakerName : widget.doctorName,
//         'message': text,
//         'isCaretaker': isCaretaker,
//         'time': DateTime.now(),
//       });
//     });
//     messageController.clear();
//     scrollController.animateTo(
//       scrollController.position.maxScrollExtent + 80,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Chat with ${widget.doctorName}"),
//         backgroundColor: const Color(0xFF2E7D32),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               controller: scrollController,
//               padding: const EdgeInsets.all(16),
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final msg = messages[index];
//                 return Align(
//                   alignment:
//                       msg['isCaretaker'] ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                     margin: const EdgeInsets.symmetric(vertical: 4),
//                     decoration: BoxDecoration(
//                       color: msg['isCaretaker'] ? const Color(0xFFDCF8C6) : Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 5,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           msg['message'],
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           "${msg['sender']} • ${TimeOfDay.fromDateTime(msg['time']).format(context)}",
//                           style: const TextStyle(fontSize: 10, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           const Divider(height: 1),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//             color: Colors.white,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: const InputDecoration(
//                       hintText: "Type a message",
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send, color: Color(0xFF2E7D32)),
//                   onPressed: () => sendMessage(messageController.text, true),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.caretakerName, required this.doctorName});

  final String caretakerName;
  final String doctorName;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void sendMessage(String text, bool isCaretaker) {
    if (text.trim().isEmpty) return;
    setState(() {
      messages.add({
        'sender': isCaretaker ? widget.caretakerName : widget.doctorName,
        'message': text,
        'isCaretaker': isCaretaker,
        'time': DateTime.now(),
      });
    });
    messageController.clear();
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 80,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7FF), // Added theme background
      appBar: AppBar(
        title: Text(
          "Chat with ${widget.doctorName}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFA4C8E1), // Changed to theme color
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Chat Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.1),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA4C8E1).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.medical_services_rounded,
                    color: Color(0xFFA4C8E1),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. ${widget.doctorName}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      Text(
                        "Medical Consultant",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Chat Messages
          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA4C8E1).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chat_rounded,
                            size: 40,
                            color: Color(0xFFA4C8E1),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Start a conversation",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Send a message to Dr. ${widget.doctorName}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      return Align(
                        alignment:
                            msg['isCaretaker'] ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: msg['isCaretaker']
                                ? const Color(0xFFA4C8E1) // Changed caretaker message color to theme
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            border: msg['isCaretaker']
                                ? null
                                : Border.all(
                                    color: Colors.grey[200]!,
                                    width: 1,
                                  ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                msg['message'],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: msg['isCaretaker'] ? Colors.white : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person_rounded,
                                    size: 10,
                                    color: msg['isCaretaker']
                                        ? Colors.white.withOpacity(0.8)
                                        : Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    msg['sender'],
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: msg['isCaretaker']
                                          ? Colors.white.withOpacity(0.8)
                                          : Colors.grey[600],
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    TimeOfDay.fromDateTime(msg['time']).format(context),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: msg['isCaretaker']
                                          ? Colors.white.withOpacity(0.8)
                                          : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7F9),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: "Type your message...",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFA4C8E1), // Changed to theme color
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                    onPressed: () => sendMessage(messageController.text, true),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}