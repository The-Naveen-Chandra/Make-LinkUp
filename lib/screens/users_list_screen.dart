import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkup_app/components/linkup_logo.dart';

import 'package:linkup_app/screens/chat_screen.dart';
import 'package:linkup_app/components/user_title.dart';
import 'package:linkup_app/services/chat/chat_services.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  // service instances
  final ChatService _chatService = ChatService();
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: const LinkUpLogo(chatUp: true),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: Icon(
              Icons.add,
              color: Colors.transparent,
            ),
          )
        ],
      ),
      body: _buildUsersList(),
    );
  }

  Widget _buildUsersList() {
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
            child: CupertinoActivityIndicator(),
          );
        }

        // return list view
        return Column(
          children: [
            // search bar
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 10.0,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.search,
                    color: Theme.of(context).colorScheme.tertiary,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: snapshot.data!
                    .map((userData) => _buildUsersListItem(userData, context))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUsersListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users except the current user
    if (userData["email"] != currentUser.email) {
      return UserTile(
        username: userData["username"] ?? "No username",
        email: userData["email"] ?? "No email",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                username: userData["username"] ?? "No username",
              ),
            ),
          );
        },
      );
    } else {
      return const SizedBox();
    }
  }
}
