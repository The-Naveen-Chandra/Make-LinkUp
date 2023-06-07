import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkup_app/components/my_alert_dialog.dart';
import 'package:linkup_app/components/text_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // current user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // all the users
  final userCollection = FirebaseFirestore.instance.collection("Users");

  // edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        surfaceTintColor: Colors.transparent,
        title: Center(
          child: Text(
            "Edit $field",
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
        ),
        content: TextField(
          autofocus: true,
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter new $field",
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey,
            ),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),
            ),
          ),

          // const SizedBox(width: 30),

          // save button
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: Text(
              "Save",
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

    // update in firestore
    if (newValue.trim().isNotEmpty) {
      // only update if there is something in the textfield
      await userCollection.doc(currentUser.email).update({
        field: newValue,
      });
    }
  }

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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          // get the user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
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
                  sectionName: "Username",
                  text: userData['Username'],
                  onPressed: () => editField("Username"),
                ),

                // bio
                TextBox(
                  sectionName: "Bio",
                  text: userData['Bio'],
                  onPressed: () => editField("Bio"),
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
            );
          } else if (snapshot.hasError) {
            return MyAlertDialog(content: snapshot.error.toString());
          }

          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}
