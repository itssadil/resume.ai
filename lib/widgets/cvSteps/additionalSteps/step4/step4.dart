import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addProjectProvider.dart';
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
                value.addValue();
              },
              title: "Add Project",
            );
          },
        ),
      ],
    );
  }
}
