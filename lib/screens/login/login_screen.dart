import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: const SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),

              // logo
              Icon(
                Icons.bakery_dining_rounded,
                // Icons.link
                size: 100,
              ),

              SizedBox(height: 50)

              // welcome back, you've been missed!

              // user textfield

              // password textfield

              // forgot password ?

              // sign in button

              // or continue with

              // google + apple sign in button

              // not a member?  register now
            ],
          ),
        ),
      ),
    );
  }
}
