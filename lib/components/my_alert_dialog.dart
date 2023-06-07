import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAlertDialog extends StatelessWidget {
  final String content;
  const MyAlertDialog({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          "Alert !",
          style: GoogleFonts.poppins(),
        ),
      ),
      content: Text(
        content,
        style: GoogleFonts.poppins(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'OK',
            style: GoogleFonts.poppins(),
          ),
        ),
      ],
    );
  }
}
