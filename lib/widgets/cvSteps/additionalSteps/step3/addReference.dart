import 'package:flutter/material.dart';
import 'package:resumeai/widgets/customTextField.dart';

class AddReference extends StatelessWidget {
  AddReference({
    Key? key,
    required this.referenceController,
    required this.referenceOptionController,
    required this.index,
  }) : super(key: key);
  final TextEditingController referenceController;
  final TextEditingController referenceOptionController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: referenceController,
          labelText: "Name",
          maxLines: 1,
        ),
        CustomTextField(
          controller: referenceOptionController,
          labelText:
              "e.g., Software Developer, Brain Imagine LTD, Former Colleague, xyz@gmail.com etc",
          maxLines: 2,
        ),
      ],
    );
  }
}
