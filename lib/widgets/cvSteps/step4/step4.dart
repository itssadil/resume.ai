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
                // for (var item in value.studyTitleController) {
                //   print(item.text);
                // }

                value.addValue();
                // final employmentDate =
                //     Provider.of<EmploymentDateProvider>(context, listen: false);
                // value.addFromTime(employmentDate.fromDate ?? DateTime(3030));
                // value.addToTime(employmentDate.toDate ?? DateTime(3030));
                //
                // employmentDate.nullValue();
              },
              title: "Add Education",
            );
          },
        ),
      ],
    );
  }
}
