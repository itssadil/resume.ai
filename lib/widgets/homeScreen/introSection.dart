import 'package:flutter/material.dart';
import 'package:resumeai/screens/splashScreen.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "resume.ai:\nStand out from\nthe crowd",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 70,
            color: Colors.white,
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SplashScreen(
                whois: "homeScreen",
              ),
            ),
          ),
          child: const Text("Get Started"),
        ),
      ],
    );
  }
}
