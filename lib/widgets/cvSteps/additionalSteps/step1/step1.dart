import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addTrainingProvider.dart';
import 'package:resumeai/widgets/addBtn.dart';
import 'package:resumeai/widgets/addOption.dart';

class AdditionalStep1 extends StatefulWidget {
  const AdditionalStep1({Key? key}) : super(key: key);

  @override
  State<AdditionalStep1> createState() => _AdditionalStep1State();
}

class _AdditionalStep1State extends State<AdditionalStep1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<AddTrainingProvider>(
          builder: (context, value, child) {
            return AddOption(
              itemCount: value.trainingTitleController.length,
              whoIs: "additionalStep1",
              trainingTitleController: value.trainingTitleController,
              instituteNameController: value.instituteNameController,
            );
          },
        ),
        Consumer<AddTrainingProvider>(
          builder: (context, value, child) {
            return CustomAddButton(
              onPressed: () {
                value.addValue();
              },
              title: "Add Training",
            );
          },
        ),
      ],
    );
  }
}
