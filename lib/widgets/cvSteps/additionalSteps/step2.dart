import 'package:flutter/material.dart';
import 'package:resumeai/widgets/customTextField.dart';

class Step5 extends StatelessWidget {
  const Step5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController languageController = TextEditingController();
    return Column(
      children: [
        const Card(
          color: Colors.greenAccent,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Separate your languages using commas (e.g., English, Spanish, French).",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        CustomTextField(
          controller: languageController,
          labelText: "Language(ex: English, Bangali, Sylhety, Hindi)",
          maxLines: 1,
        ),
      ],
    );
  }
}
