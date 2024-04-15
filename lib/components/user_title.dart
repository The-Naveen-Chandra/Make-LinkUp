import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String username;
  final String email;
  final void Function()? onTap;
  const UserTile({
    super.key,
    required this.email,
    required this.onTap,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(12.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            Column(
              children: [
                Text(username),
                Text(email),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
