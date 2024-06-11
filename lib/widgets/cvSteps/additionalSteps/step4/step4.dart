import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addProjectProvider.dart';
import 'package:resumeai/providers/employmentDateProvider.dart';
import 'package:resumeai/widgets/addBtn.dart';
import 'package:resumeai/widgets/addOption.dart';

class AdditionalStep4 extends StatefulWidget {
  const AdditionalStep4({Key? key}) : super(key: key);

  @override
  State<AdditionalStep4> createState() => _AdditionalStep4State();
}

class _AdditionalStep4State extends State<AdditionalStep4> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<AddProjectProvider>(
          builder: (context, value, child) {
            return AddOption(
              itemCount: value.projectTitleController.length,
              whoIs: "additionalStep4",
              projectTitleController: value.projectTitleController,
              roleController: value.roleController,
              descriptionController: value.descriptionController,
            );
          },
        ),
        Consumer<AddProjectProvider>(
          builder: (context, value, child) {
            return CustomAddButton(
              onPressed: () {
                for (var item in value.projectTitleController) {
                  print(item.text);
                }
                // currentProfile.addProfile();

                value.addValue();
                final employmentDate =
                    Provider.of<EmploymentDateProvider>(context, listen: false);
                value.addFromTime(employmentDate.fromDate ?? DateTime(3030));
                value.addToTime(employmentDate.toDate ?? DateTime(3030));

                employmentDate.nullValue();
              },
              title: "Add Project",
            );
          },
        ),
      ],
    );
  }
}
