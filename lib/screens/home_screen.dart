import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:linkup_app/helper/helper_methods.dart';
import 'package:linkup_app/components/linkup_post.dart';
import 'package:linkup_app/components/my_drawer.dart';
import 'package:linkup_app/components/my_textfield.dart';
import 'package:linkup_app/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  // text controller
  final textController = TextEditingController();

  // sign out the user
  void signOutUser(BuildContext context) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Confirm Sign Out',
          style: GoogleFonts.poppins(),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: Text(
              'Yes, sign out',
              style: GoogleFonts.poppins(
                color: Colors.red[300],
              ),
            ),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirm) {
      await FirebaseAuth.instance.signOut();
    }
  }

  // post message on the LinkUp
  void postMassage() {
    // only post if there is something in the textfield
    if (textController.text.isNotEmpty) {
      // store in the firebase
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
    }

    // clear the textfield
    setState(() {
      textController.clear();
    });
  }

  // navigate to profile screen
  void goToProfileScreen() {
    // pop menu drawer
    Navigator.pop(context);

    // go to profile page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.link,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "LinkUp",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.chat_bubble_2,
              size: 30,
            ),
          ),
        ],
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfileScreen,
        onSignOut: () => signOutUser(context),
      ),
      body: Column(
        children: [
          // make - LinkUp
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .orderBy("TimeStamp", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // get the message
                      final post = snapshot.data!.docs[index];
                      return LinkUpPost(
                        message: post['Message'],
                        user: post['UserEmail'],
                        postId: post.id,
                        time: formatData(post['TimeStamp']),
                        likes: List<String>.from(post['Likes'] ?? []),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error : ${snapshot.error}",
                    ),
                  );
                }
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              },
            ),
          ),

          // post message
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 12, bottom: 12),
            child: Row(
              children: [
                //textfield
                Expanded(
                  child: MyTextfield(
                    controller: textController,
                    hintText: "Write message on LinkUp",
                    obscureText: false,
                    myPadding: 0,
                  ),
                ),

                // post button
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: IconButton(
                    onPressed: postMassage,
                    icon: const Icon(
                      CupertinoIcons.arrow_up_circle,
                      size: 32,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // logged in
          Text(
            currentUser.email!,
            style: GoogleFonts.poppins(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
