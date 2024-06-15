import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addExperienceProvider.dart';
import 'package:resumeai/widgets/addBtn.dart';
import 'package:resumeai/widgets/addOption.dart';

class Step3 extends StatefulWidget {
  const Step3({Key? key}) : super(key: key);

  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<AddExperienceProvider>(
          builder: (context, value, child) {
            return AddOption(
              itemCount: value.jobTitleController.length,
              whoIs: "step3",
              jobTitleController: value.jobTitleController,
              companyNameController: value.companyNameController,
              locationController: value.locationController,
            );
          },
        ),
        Consumer<AddExperienceProvider>(
          builder: (context, value, child) {
            // final employmentDate =
            //     Provider.of<EmploymentDateProvider>(context, listen: false);
            return CustomAddButton(
              onPressed: () {
                value.addValue();
                // value.addFromTime(employmentDate.fromDate ?? DateTime(3030));
                // value.addToTime(employmentDate.toDate ?? DateTime(3030));
                //
                //
                // employmentDate.nullValue();
              },
              title: "Add Experience",
            );
          },
        ),
      ],
    );
  }
}
