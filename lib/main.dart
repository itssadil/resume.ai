import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addExperienceProvider.dart';
import 'package:resumeai/providers/employmentDateProvider.dart';
import 'package:resumeai/providers/profileLinkProvider.dart';
import 'package:resumeai/providers/stepperProvider.dart';
import 'package:resumeai/screens/homeScreen/homeScreen.dart';

const apiKey = "AIzaSyAFRNqPSeiWDOOI9GEyik2d9H00_z_ItTk";

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => StepperProvider()),
      ChangeNotifierProvider(create: (context) => ProfileLinkProvider()),
      ChangeNotifierProvider(create: (context) => EmploymentDateProvider()),
      ChangeNotifierProvider(create: (context) => AddExperienceProvider()),
    ],
    child: MyApp(),
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
      // home: const SplashScreen(),
      home: const HomeScreen(),
    );
  }
}
