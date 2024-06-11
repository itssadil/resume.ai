import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addTrainingProvider.dart';
import 'package:resumeai/providers/employmentDateProvider.dart';
import 'package:resumeai/widgets/addBtn.dart';
import 'package:resumeai/widgets/addOption.dart';

class Step5 extends StatefulWidget {
  const Step5({Key? key}) : super(key: key);

  @override
  State<Step5> createState() => _Step5State();
}

class _Step5State extends State<Step5> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<AddTrainingProvider>(
          builder: (context, value, child) {
            return AddOption(
              itemCount: value.trainingTitleController.length,
              whoIs: "step5",
              trainingTitleController: value.trainingTitleController,
              instituteNameController: value.instituteNameController,
            );
          },
        ),
        Consumer<AddTrainingProvider>(
          builder: (context, value, child) {
            return CustomAddButton(
              onPressed: () {
                for (var item in value.trainingTitleController) {
                  print(item.text);
                }

                value.addValue();
                final employmentDate =
                    Provider.of<EmploymentDateProvider>(context, listen: false);
                value.addFromTime(employmentDate.fromDate ?? DateTime(3030));
                value.addToTime(employmentDate.toDate ?? DateTime(3030));

                employmentDate.nullValue();
              },
              title: "Add Training",
            );
          },
        ),
      ],
    );
  }
}
