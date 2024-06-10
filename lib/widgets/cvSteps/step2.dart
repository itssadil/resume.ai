import 'package:flutter/material.dart';
import 'package:resumeai/widgets/customTextField.dart';

class Step2 extends StatelessWidget {
  const Step2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController skillsController = TextEditingController();
    return Column(
      children: [
        const Card(
          color: Colors.greenAccent,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Split your skills using ',' comma",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        CustomTextField(
          controller: skillsController,
          labelText: "skills(ex: Flutter, Dart, Github, Firebase, sqLite)",
        ),
      ],
    );
  }
}
