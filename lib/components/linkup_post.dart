import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkup_app/components/comment_button.dart';
import 'package:linkup_app/components/delete_button.dart';
import 'package:linkup_app/components/like_button.dart';
import 'package:linkup_app/components/my_comment.dart';
import 'package:linkup_app/helper/helper_methods.dart';

class LinkUpPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final String time;
  final List<String> likes;

  const LinkUpPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    required this.time,
  });

  @override
  State<LinkUpPost> createState() => _LinkUpPostState();
}

class _LinkUpPostState extends State<LinkUpPost> {
  // user form firebase
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  // comment text field controller
  final _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  // toggle like
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    // Access the document in Firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      // if the post is liked, add the user's email to the 'Likes' field
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email]),
      });
    } else {
      // if the post is unlike, remove the user's email from the 'Likes' field
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email]),
      });
    }
  }

  // add a comment
  void addComment(String commentText) {
    // write the comment for firestore under the comments collection for this post
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime":
          Timestamp.now(), // remember to formate this when displaying
    });
  }

  // show a dialog box for adding the comment
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Add Comment",
          style: GoogleFonts.poppins(),
        ),
        content: TextField(
          cursorColor: Theme.of(context).colorScheme.tertiary,
          controller: _commentTextController,
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Write a comment...",
            hintStyle: GoogleFonts.poppins(),
          ),
        ),
        actions: [
          // cancel button
          TextButton(
            onPressed: () {
              // pop box
              Navigator.pop(context);

              // clear the controller
              _commentTextController.clear();
            },
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(),
            ),
          ),

          // save
          TextButton(
            onPressed: () {
              // add comment to firebase store
              addComment(_commentTextController.text);

              // pop the box
              Navigator.pop(context);

              // clear the controller
              _commentTextController.clear();
            },
            child: Text(
              "Post",
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }

  // delete post
  void deletePost() {
    // show a dialog box for confirmation before deleting the post
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Delete Post",
          style: GoogleFonts.poppins(),
        ),
        content: Text(
          "Are you sure you want to delete this post ?",
          style: GoogleFonts.poppins(),
        ),
        actions: [
          // cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(),
            ),
          ),

          // delete button
          TextButton(
            onPressed: () async {
              // delete the comments form fire store firstly
              // if we do not delete the comments then then it will present in the fire store forever
              final commentDocs = await FirebaseFirestore.instance
                  .collection("User Posts")
                  .doc(widget.postId)
                  .collection("Comments")
                  .get();

              for (var doc in commentDocs.docs) {
                await FirebaseFirestore.instance
                    .collection("User Posts")
                    .doc(widget.postId)
                    .collection("Comments")
                    .doc(doc.id)
                    .delete();
              }

              // then delete the post
              FirebaseFirestore.instance
                  .collection("User Posts")
                  .doc(widget.postId)
                  .delete()
                  .then(
                    (value) => print("post deleted"),
                  )
                  .catchError(
                    (error) => print("failed to delete post : $error"),
                  );

              // dismiss the dialog box
              if (context.mounted) Navigator.pop(context);
            },
            child: Text(
              "Delete",
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }

  Stream<int> commentCountStream() {
    return FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comments")
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 25,
        left: 25,
        right: 25,
      ),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // linkUp post
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // group of text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // message
                  Text(
                    widget.message,
                    style: GoogleFonts.poppins(),
                  ),

                  const SizedBox(height: 5),

                  // current user email
                  Row(
                    children: [
                      Text(
                        widget.user,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        " . ",
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        widget.time,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // delete button
              if (widget.user == currentUser.email)
                DeleteButton(onTap: deletePost)
            ],
          ),

          const SizedBox(height: 20),

          // button
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // like button
              Column(
                children: [
                  // liked button
                  LikeButton(
                    isLiked: isLiked,
                    onTap: toggleLike,
                  ),

                  const SizedBox(height: 5),

                  // liked count
                  Text(
                    widget.likes.length.toString(),
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 14),

              // comment button
              Column(
                children: [
                  // comment
                  CommentButton(
                    onTap: showCommentDialog,
                  ),

                  const SizedBox(height: 5),

                  // comment count
                  StreamBuilder<int>(
                    stream: commentCountStream(),
                    builder: (context, snapshot) {
                      final count = snapshot.data ?? 0;
                      return Text(
                        '$count',
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // comment section under the post
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("User Posts")
                .doc(widget.postId)
                .collection("Comments")
                .orderBy("CommentTime", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              // show loading circle if no data yet
              if (!snapshot.hasData) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }

              return ListView(
                shrinkWrap: true, // for nested lists
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  // get the comment
                  final commentData = doc.data() as Map<String, dynamic>;

                  // return the comment
                  return MyComment(
                    text: commentData['CommentText'],
                    user: commentData['CommentedBy'],
                    time: formatData(commentData['CommentTime']),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
