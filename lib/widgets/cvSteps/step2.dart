import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/errorMessageProvider.dart';
import 'package:resumeai/widgets/controllers.dart';
import 'package:resumeai/widgets/customTextField.dart';
import 'package:resumeai/widgets/errorMessage.dart';

class Step2 extends StatelessWidget {
  const Step2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessageProvider = Provider.of<ErrorMessageProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Card(
          color: Colors.greenAccent,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Separate your skills using ' , ' commas. We will describe them briefly.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        CustomTextField(
          controller: TextControllers.skillsController,
          labelText: "skills*(ex: Flutter, Dart, Github, Firebase, sqLite)",
          maxLines: 1,
        ),
        errorMessage(title: 'skills', isVisible: errorMessageProvider.skills),
      ],
    );
  }
}
