// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:linkup_app/components/my_button.dart';
import 'package:linkup_app/screens/auth_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late SharedPreferences _preferences;
  bool _showIntro = true; // Default to show intro screen
  bool _isLoading = false; // Track loading state

  @override
  void initState() {
    super.initState();
    _loadPreference();
  }

  Future<void> _loadPreference() async {
    _preferences = await SharedPreferences.getInstance();
    bool hasSeenIntro = _preferences.getBool('hasSeenIntro') ?? false;
    if (hasSeenIntro) {
      setState(() {
        _showIntro = false;
      });
    }
  }

  Future<void> _markIntroAsSeen() async {
    await _preferences.setBool('hasSeenIntro', true);
  }

  void _showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  void _hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_showIntro) {
      // Skip intro screen and navigate directly
      return const AuthScreen();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : SingleChildScrollView(
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
                        "             LinkUp is a social medias\nplatform that connects people together .",
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 280),

                      MyButton(
                        text: "Get Started",
                        isLandingScreen: true,
                        onTap: () async {
                          _showLoading();
                          await _markIntroAsSeen();
                          await Future.delayed(const Duration(seconds: 2));
                          _hideLoading();
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
