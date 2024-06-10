import 'package:flutter/material.dart';
import 'package:resumeai/screens/cvForm.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text("resume.ai"),
      ),
      body: const CvForm(),
    );
  }
}
