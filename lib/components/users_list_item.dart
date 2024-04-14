import 'package:flutter/material.dart';
import 'package:linkup_app/components/user_title.dart';
import 'package:linkup_app/screens/chat_screen.dart';

class UsersListItem extends StatelessWidget {
  const UsersListItem({
    super.key,
    required this.userData,
    required this.context,
  });

  final Map<String, dynamic> userData;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    // display all users except the current user
    return UserTile(
      username: userData["username"] ?? "No username",
      email: userData["email"] ?? "No email",
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ChatScreen()));
      },
    );
  }
}
