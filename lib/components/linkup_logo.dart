import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class LinkUpLogo extends StatelessWidget {
  final bool chatUp;
  const LinkUpLogo({
    super.key,
    this.chatUp = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          chatUp ? CupertinoIcons.chat_bubble_2 : CupertinoIcons.link,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          chatUp ? "Messages" : "LinkUp",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
