import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:linkup_app/components/chat_bubble.dart';
import 'package:linkup_app/components/my_textfield.dart';
import 'package:linkup_app/helper/helper_methods.dart';
import 'package:linkup_app/services/chat/chat_services.dart';

class ChatScreen extends StatelessWidget {
  final String username;
  final String receiverID;
  final String receiverEmail;

  ChatScreen({
    super.key,
    required this.username,
    required this.receiverID,
    required this.receiverEmail,
  });

  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat and auth services
  final ChatService _chatService = ChatService();
  final currentUser = FirebaseAuth.instance.currentUser!;

  // send message
  void sendMessage() async {
    // if there is something inside the textField
    if (_messageController.text.isNotEmpty) {
      // send message
      await _chatService.sendMessage(_messageController.text, receiverID);

      // clear the text field
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: Text(
          username,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          // display all the messages
          Expanded(child: _buildMessageList()),

          // text field for typing messages
          _buildUserInput(),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    String senderID = currentUser.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        // errors
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error: ${snapshot.error}",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        // loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }

        Map<String, List<DocumentSnapshot>> groupedMessages = {};
        for (var doc in snapshot.data!.docs) {
          DateTime timestamp = (doc['timestamp'] as Timestamp).toDate();
          String formattedDate = formatDate(timestamp, snapshot.data!.docs);
          if (!groupedMessages.containsKey(formattedDate)) {
            groupedMessages[formattedDate] = [];
          }
          groupedMessages[formattedDate]!.add(doc);
        }
        // return list view
        // Build message list with grouped messages
        return ListView(
          children: groupedMessages.entries.map((entry) {
            String date = entry.key;
            List<DocumentSnapshot> messages = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display date as a header
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    date,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                // Display messages for the date
                Column(
                  children: messages.map((doc) {
                    return _buildMessageItem(doc);
                  }).toList(),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data["senderID"] == currentUser.uid;

    // align message according to right if the sender is current user, otherwise left

    return Container(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ChatBubble(
        isCurrentUser: isCurrentUser,
        message: data["message"],
      ),
    );
  }

  // build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 12, bottom: 12),
      child: Row(
        children: [
          //textfield
          Expanded(
            child: MyTextfield(
              controller: _messageController,
              hintText: "Message",
              obscureText: false,
              myPadding: 0,
            ),
          ),

          // post button
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                CupertinoIcons.arrow_up_circle,
                size: 32,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
