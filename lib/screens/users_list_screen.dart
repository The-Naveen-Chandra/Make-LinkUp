import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:linkup_app/screens/chat_screen.dart';
import 'package:linkup_app/components/user_title.dart';
import 'package:linkup_app/components/linkup_logo.dart';
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
  TextEditingController searchController = TextEditingController();

  void _triggerSearch() {
    setState(() {});
  }

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

        List<dynamic> users = snapshot.data as List<dynamic>;

        if (searchController.text.isNotEmpty) {
          String query = searchController.text.toLowerCase();
          users = users.where((userData) {
            String username = userData["username"]?.toLowerCase() ?? "";
            String email = userData["email"]?.toLowerCase() ?? "";
            return username.contains(query) || email.contains(query);
          }).toList();
        }

        if (users.isEmpty) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 10.0,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 0.0,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 14.0),
                      child: Icon(
                        CupertinoIcons.search,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        autofocus: false,
                        cursorColor: Theme.of(context).colorScheme.tertiary,
                        style: GoogleFonts.poppins(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search for users",
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: GestureDetector(
                        onTap: () {
                          _triggerSearch();
                        },
                        child: Icon(
                          CupertinoIcons.arrow_right,
                          color: Colors.blueAccent[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "No user found .",
                style: GoogleFonts.poppins(),
              ),
            ],
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
                vertical: 0.0,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: Icon(
                      CupertinoIcons.search,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      autofocus: false,
                      cursorColor: Theme.of(context).colorScheme.tertiary,
                      style: GoogleFonts.poppins(),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search for users",
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: GestureDetector(
                      onTap: () {
                        _triggerSearch();
                      },
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        color: Colors.blueAccent[400],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> userData = users[index];
                  return _buildUsersListItem(userData, context);
                },
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
