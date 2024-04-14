import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:linkup_app/components/my_button.dart';
import 'package:linkup_app/screens/auth_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 100),

                // Icon
                const Icon(
                  CupertinoIcons.link_circle_fill,
                  size: 100,
                ),

                const SizedBox(height: 50),

                Text(
                  "Welcome to LinkUp .",
                  style: GoogleFonts.poppins(
                    color: Colors.grey[400],
                    fontSize: 24,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  "            LinkUp is a social medias\nplatform that connects people together.",
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 280),

                MyButton(
                  text: "Get Started",
                  isLandingScreen: true,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
