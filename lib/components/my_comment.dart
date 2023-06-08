import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyComment extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const MyComment({
    super.key,
    required this.text,
    required this.user,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // comment
          Text(
            text,
            style: GoogleFonts.poppins(),
          ),

          const SizedBox(height: 5),

          // user, time
          Row(
            children: [
              Text(
                user,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                " · ",
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                ),
              ),
              Text(
                time,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
