import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextfield extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final double myPadding;

  const MyTextfield({
    super.key,
    this.controller,
    required this.hintText,
    required this.obscureText,
    this.myPadding = 25.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myPadding),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: Theme.of(context).colorScheme.tertiary,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: Theme.of(context).colorScheme.primary,
          filled: true,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}
