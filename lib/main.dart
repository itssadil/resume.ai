import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addEducationProvider.dart';
import 'package:resumeai/providers/addExperienceProvider.dart';
import 'package:resumeai/providers/addProjectProvider.dart';
import 'package:resumeai/providers/addReferenceProvider.dart';
import 'package:resumeai/providers/addTrainingProvider.dart';
import 'package:resumeai/providers/additionalOptionProvider.dart';
import 'package:resumeai/providers/additionalStepperProvider.dart';
import 'package:resumeai/providers/profileLinkProvider.dart';
import 'package:resumeai/providers/stepperProvider.dart';
import 'package:resumeai/screens/splashScreen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => StepperProvider()),
      ChangeNotifierProvider(create: (context) => ProfileLinkProvider()),
      ChangeNotifierProvider(create: (context) => AddExperienceProvider()),
      ChangeNotifierProvider(create: (context) => AddEducationProvider()),
      ChangeNotifierProvider(create: (context) => AddTrainingProvider()),
      ChangeNotifierProvider(create: (context) => AdditionalStepperProvider()),
      ChangeNotifierProvider(create: (context) => AddReferenceProvider()),
      ChangeNotifierProvider(create: (context) => AddProjectProvider()),
      ChangeNotifierProvider(create: (context) => AdditionalOptionProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade300,
        colorScheme: const ColorScheme.light(
          primary: Colors.green,
          secondary: Colors.greenAccent,
        ),
      ),
      title: 'resume.ai',
      home: const SplashScreen(
        whois: "main",
      ),
      // home: const HomeScreen(),
    );
  }
}
