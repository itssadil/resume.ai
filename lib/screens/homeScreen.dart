import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:resumeai/screens/splashScreen.dart';
import 'package:resumeai/widgets/homeScreen/exampleSection.dart';
import 'package:resumeai/widgets/homeScreen/introSection.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          color: Colors.deepPurple.shade900.withOpacity(0.3),
          height: double.infinity,
          child: !kIsWeb
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: exampleSection(),
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
                      const IntroSection(),
                    ],
                  ),
                )
              : Row(
                  children: [
                    const Expanded(child: IntroSection()),
                    Expanded(child: exampleSection()),
                  ],
                ),
        ),
      ),
    );
  }
}
