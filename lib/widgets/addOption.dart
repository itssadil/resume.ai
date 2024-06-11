import 'package:flutter/material.dart';
import 'package:resumeai/widgets/cvSteps/step1/profileLinkes.dart';
import 'package:resumeai/widgets/cvSteps/step3/addExperience.dart';
import 'package:resumeai/widgets/cvSteps/step4/addEducation.dart';
import 'package:resumeai/widgets/cvSteps/step5/addTraining.dart';

class AddOption extends StatefulWidget {
  AddOption({
    Key? key,
    required this.itemCount,
    required this.whoIs,
    this.urlControllers,
    this.urlNameControllers,
    this.jobTitleController,
    this.companyNameController,
    this.locationController,
    this.studyTitleController,
    this.universityNameController,
    this.trainingTitleController,
    this.instituteNameController,
  }) : super(key: key);

  final int itemCount;
  final String whoIs;
  List<TextEditingController>? urlControllers;
  List<TextEditingController>? urlNameControllers;
  List<TextEditingController>? jobTitleController;
  List<TextEditingController>? companyNameController;
  List<TextEditingController>? locationController;
  List<TextEditingController>? studyTitleController;
  List<TextEditingController>? universityNameController;
  List<TextEditingController>? trainingTitleController;
  List<TextEditingController>? instituteNameController;

  @override
  State<AddOption> createState() => _AddOptionState();
}

class _AddOptionState extends State<AddOption> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        switch (widget.whoIs) {
          case "step1":
            return ProfileLinks(
              urlController: widget.urlControllers![index],
              urlNameController: widget.urlNameControllers![index],
            );
          case "step2":
            return AddExperience(
              jobTitleController: widget.jobTitleController![index],
              companyNameController: widget.companyNameController![index],
              locationController: widget.locationController![index],
              index: index,
            );
          case "step4":
            return AddEducation(
              studyTitleController: widget.studyTitleController![index],
              universityNameController: widget.universityNameController![index],
              index: index,
            );
          case "step5":
            return AddTraining(
              trainingTitleController: widget.trainingTitleController![index],
              instituteNameController: widget.instituteNameController![index],
              index: index,
            );
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
