import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final bool isLandingScreen;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLandingScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.background,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              // if the button is on the landing screen, show the arrow icon
              if (isLandingScreen)
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Icon(
                    CupertinoIcons.arrow_right,
                    color: Colors.blueAccent[400],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
