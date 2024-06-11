import 'package:flutter/material.dart';
import 'package:resumeai/widgets/cvSteps/additionalSteps/step1/addTraining.dart';
import 'package:resumeai/widgets/cvSteps/additionalSteps/step3/addReference.dart';
import 'package:resumeai/widgets/cvSteps/additionalSteps/step4/addProject.dart';
import 'package:resumeai/widgets/cvSteps/step1/profileLinkes.dart';
import 'package:resumeai/widgets/cvSteps/step3/addExperience.dart';
import 'package:resumeai/widgets/cvSteps/step4/addEducation.dart';

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
    this.languageController,
    this.referenceOptionController,
    this.referenceController,
    this.projectTitleController,
    this.roleController,
    this.descriptionController,
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
  List<TextEditingController>? languageController;
  List<TextEditingController>? referenceOptionController;
  List<TextEditingController>? referenceController;
  List<TextEditingController>? projectTitleController;
  List<TextEditingController>? roleController;
  List<TextEditingController>? descriptionController;

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
          case "step3":
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
          case "additionalStep3":
            return AddReference(
              referenceOptionController:
                  widget.referenceOptionController![index],
              referenceController: widget.referenceController![index],
              index: index,
            );
          case "additionalStep1":
            return AddTraining(
              trainingTitleController: widget.trainingTitleController![index],
              instituteNameController: widget.instituteNameController![index],
              index: index,
            );
          case "additionalStep4":
            return AddProject(
              projectTitleController: widget.projectTitleController![index],
              roleController: widget.roleController![index],
              descriptionController: widget.descriptionController![index],
              index: index,
            );
          default:
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ));
        }
      },
    );
  }
}
