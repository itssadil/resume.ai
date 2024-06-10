import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resumeai/screens/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (_) => navigateToHome(_));
  }

  void navigateToHome(Timer timer) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }),
    );
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "resume.ai",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
