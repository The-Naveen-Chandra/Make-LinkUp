import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 12,
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? Colors.blue
            : Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        message,
        style: GoogleFonts.poppins(
          color: isCurrentUser
              ? Colors.white
              : Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
