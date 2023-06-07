import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkup_app/components/text_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // current user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // edit field
  Future<void> editField(String field) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          // profile pic
          const Icon(
            CupertinoIcons.person,
            size: 72,
          ),

          const SizedBox(height: 10),

          // user email
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.grey[700],
            ),
          ),

          const SizedBox(height: 50),

          // user details
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "My details",
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
              ),
            ),
          ),

          // username
          TextBox(
            sectionName: 'Username',
            text: "naveen",
            onPressed: () => editField('username'),
          ),

          // bio
          TextBox(
            sectionName: 'User Bio',
            text: "Hi There",
            onPressed: () => editField('username'),
          ),

          const SizedBox(height: 50),

          // user posts
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "My details",
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
