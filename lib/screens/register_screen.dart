import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkup_app/components/my_alert_dialog.dart';
import 'package:linkup_app/components/my_button.dart';
import 'package:linkup_app/components/my_textfield.dart';
import 'package:linkup_app/components/square_tile.dart';
import 'package:linkup_app/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onPress;
  const RegisterScreen({
    super.key,
    this.onPress,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign in user method
  void signUpUser() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );

    // check if password is confirmed
    if (passwordController.text != confirmPasswordController.text) {
      // pop loading circle
      Navigator.pop(context);
      // show error to user
      showErrorMsg("Password don't match !");
      return;
    }

    // Navigate to the Username and Bio screen
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UsernameAndBioScreen(
          email: emailController.text,
          password: passwordController.text,
        ),
      ),
    );
  }

  // error email message popup
  void showErrorMsg(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertDialog(content: message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 25),

                // logo
                const Icon(
                  CupertinoIcons.link_circle_fill,
                  // Icons.link
                  size: 100,
                ),

                const SizedBox(height: 25),

                // Let's create an account for you !
                Text(
                  "Let's create an account for you !",
                  style: GoogleFonts.poppins(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // user textfield
                MyTextfield(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextfield(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // confirm password textfield
                MyTextfield(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),

                const SizedBox(height: 5),

                // // forgot password ?
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         "Forgot password ?",
                //         style: GoogleFonts.poppins(
                //           color: Colors.grey[600],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 25.0),

                // sign in button
                MyButton(
                  text: "Sign Up",
                  onTap: signUpUser,
                ),

                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Or continue with",
                          style: GoogleFonts.poppins(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                // google + apple sign in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imgPath: "assets/images/google.png",
                    ),

                    const SizedBox(width: 20),

                    // apple button
                    SquareTile(
                      onTap: () {},
                      imgPath: "assets/images/apple-logo.png",
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // Already have an account ? Login Now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: GoogleFonts.poppins(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onPress,
                      child: Text(
                        "Login Now",
                        style: GoogleFonts.poppins(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UsernameAndBioScreen extends StatefulWidget {
  final String email;
  final String password;
  const UsernameAndBioScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<UsernameAndBioScreen> createState() => _UsernameAndBioScreen();
}

class _UsernameAndBioScreen extends State<UsernameAndBioScreen> {
  final usernameController = TextEditingController();
  final bioController = TextEditingController();

  void saveProfile() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'username': usernameController.text,
        'bio': bioController.text,
      });

      if (context.mounted) Navigator.pop(context);
      if (context.mounted) Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      showErrorMsg(e.toString());
    }
    if (context.mounted) Navigator.pop(context);
  }

  void showErrorMsg(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertDialog(content: message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios_new,
        //   ),
        // ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),

              // logo
              const Icon(
                CupertinoIcons.link_circle_fill,
                // Icons.link
                size: 100,
              ),
              const SizedBox(height: 25),

              // Fill in your username and bio
              Text(
                "Fill in your username and bio",
                style: GoogleFonts.poppins(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              MyTextfield(
                controller: usernameController,
                hintText: "Username",
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextfield(
                controller: bioController,
                hintText: "Bio",
                obscureText: false,
              ),
              const SizedBox(height: 25),
              MyButton(
                text: "Save",
                onTap: saveProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
