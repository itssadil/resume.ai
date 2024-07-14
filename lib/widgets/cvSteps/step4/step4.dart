import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addEducationProvider.dart';
import 'package:resumeai/widgets/addBtn.dart';
import 'package:resumeai/widgets/addOption.dart';

class Step4 extends StatefulWidget {
  const Step4({Key? key}) : super(key: key);

  @override
  State<Step4> createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<AddEducationProvider>(
          builder: (context, value, child) {
            return AddOption(
              itemCount: value.studyTitleController.length,
              whoIs: "step4",
              studyTitleController: value.studyTitleController,
              universityNameController: value.universityNameController,
            );
          },
        ),
        Consumer<AddEducationProvider>(
          builder: (context, value, child) {
            return CustomAddButton(
              onPressed: () {
                value.addValue();
              },
              title: "Add Education",
            );
          },
        ),
      ],
    );
  }
}
