import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkup_app/components/my_button.dart';
import 'package:linkup_app/components/my_textfield.dart';
import 'package:linkup_app/components/square_tile.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  // text editing controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign in user method
  void signInUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),

                // logo
                const Icon(
                  Icons.bakery_dining_rounded,
                  // Icons.link
                  size: 100,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  "Welcome back, you've been missed?",
                  style: GoogleFonts.poppins(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // user textfield
                MyTextfield(
                  controller: usernameController,
                  hintText: "Username",
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

                // forgot password ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot password ?",
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25.0),

                // sign in button
                MyButton(
                  onTap: signInUser,
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imgPath: "assets/images/google.png"),

                    SizedBox(width: 20),

                    // apple button
                    SquareTile(imgPath: "assets/images/apple-logo.png"),
                  ],
                ),

                const SizedBox(height: 35),

                // not a member?  register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member ?",
                      style: GoogleFonts.poppins(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Register now",
                      style: GoogleFonts.poppins(
                        color: Colors.blueAccent,
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
