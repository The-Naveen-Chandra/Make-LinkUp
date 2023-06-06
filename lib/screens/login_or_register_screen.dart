import 'package:flutter/material.dart';
import 'package:linkup_app/screens/login_screen.dart';
import 'package:linkup_app/screens/register_screen.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  // initially show login page
  bool showLoginPage = true;

  // toggle between login and register screen
  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(
        onPress: toggleScreen,
      );
    } else {
      return RegisterScreen(
        onPress: toggleScreen,
      );
    }
  }
}
