import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkup_app/components/users_list_item.dart';

import 'package:linkup_app/services/chat/chat_services.dart';

class UsersList extends StatelessWidget {
  const UsersList({
    super.key,
    required ChatService chatService,
  }) : _chatService = chatService;

  final ChatService _chatService;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // error checking
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
            child: CircularProgressIndicator(),
          );
        }

        // return list view
        return ListView(
          children: snapshot.data!
              .map((userData) =>
                  UsersListItem(userData: userData, context: context))
              .toList(),
        );
      },
    );
  }
}
