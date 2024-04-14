import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String username;
  final String email;
  final void Function()? onTap;
  const UserTile({
    super.key,
    required this.username,
    required this.email,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.person),
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
