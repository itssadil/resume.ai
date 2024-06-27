import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:resumeai/screens/cvForm.dart';
import 'package:resumeai/screens/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.whois}) : super(key: key);

  final String whois;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (_) => navigateToHome(_));
  }

  void navigateToHome(Timer timer) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return widget.whois == "homeScreen"
            ? const CvForm()
            : const HomeScreen();
      }),
    );
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Lottie.asset("assets/json/splash.json")),
        ],
      ),
    );
  }
}
