import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addEducationProvider.dart';
import 'package:resumeai/providers/addExperienceProvider.dart';
import 'package:resumeai/providers/additionalOptionProvider.dart';
import 'package:resumeai/providers/additionalStepperProvider.dart';
import 'package:resumeai/providers/profileLinkProvider.dart';
import 'package:resumeai/providers/stepperProvider.dart';
import 'package:resumeai/screens/getPdf.dart';
import 'package:resumeai/widgets/controllers.dart';
import 'package:resumeai/widgets/cvSteps/AdditionalSteps/step1/step1.dart';
import 'package:resumeai/widgets/cvSteps/additionalSteps/step2.dart';
import 'package:resumeai/widgets/cvSteps/additionalSteps/step3/step3.dart';
import 'package:resumeai/widgets/cvSteps/additionalSteps/step4/step4.dart';
import 'package:resumeai/widgets/cvSteps/step1/step1.dart';
import 'package:resumeai/widgets/cvSteps/step2.dart';
import 'package:resumeai/widgets/cvSteps/step3/step3.dart';
import 'package:resumeai/widgets/cvSteps/step4/step4.dart';
import 'package:resumeai/widgets/dateFormatter.dart';

class CvForm extends StatefulWidget {
  const CvForm({Key? key}) : super(key: key);

  @override
  State<CvForm> createState() => _CvFormState();
}

class _CvFormState extends State<CvForm> {
  // final TextEditingController _userMessage = TextEditingController();
  //
  // final model =
  //     GenerativeModel(model: "gemini-1.5-flash-latest", apiKey: GEMINI_API_KEY);
  //
  // // Note: For your API key, please create a file named consts.dart inside the lib folder and add the following line:
  // // const String GEMINI_API_KEY = "YOUR_API_KEY";
  //
  // String getResponse = "";
  //
  // sendMessage() async {
  //   final message = _userMessage.text;
  //   _userMessage.clear();
  //
  //   final prompt = message;
  //   final content = [Content.text(prompt)];
  //   final response = await model.generateContent(content);
  //
  //   print(response.text);
  //   setState(() {
  //     getResponse = response.text!;
  //   });
  // }

  void onSubmitPress(
    bool isLastStep,
    ControlsDetails details,
  ) {
    // For step1 controllers
    String name = TextControllers.nameController.text;
    String phone = TextControllers.phoneController.text;
    String email = TextControllers.emailController.text;
    String address = TextControllers.addressController.text;

    // For step1 controllers
    final printProfileLink =
        Provider.of<ProfileLinkProvider>(context, listen: false);

    // For step2 controllers
    String skills = TextControllers.skillsController.text;

    // For step3 controllers
    final addExperienceControllers =
        Provider.of<AddExperienceProvider>(context, listen: false);

    // For step4 controllers
    final addEducationControllers =
        Provider.of<AddEducationProvider>(context, listen: false);

    // For additional step2 controllers
    String language = TextControllers.languageController.text;

    if (isLastStep) {
      int index = 0;
      int exIndex = 0;
      int edIndex = 0;
      String itemFinal = "";
      String exItemFinal = "";
      String edItemFinal = "";
      String dividerColon = ":";

      //For step1.dart
      for (var profileLinkItem in printProfileLink.urlControllers) {
        dividerColon = printProfileLink.urlNameControllers[index].text != ""
            ? dividerColon
            : "";
        itemFinal =
            "$itemFinal\n ${printProfileLink.urlNameControllers[index].text}$dividerColon ${profileLinkItem.text}";
        index++;
      }

      //For step3.dart
      for (var addExItem in addExperienceControllers.jobTitleController) {
        String companyName =
            addExperienceControllers.companyNameController[exIndex].text;
        String location =
            addExperienceControllers.locationController[exIndex].text;

        String fromDate = addExperienceControllers
                    .employmentFromDate.isNotEmpty &&
                addExperienceControllers.employmentFromDate.length - 1 ==
                    exIndex
            ? formatDate(addExperienceControllers.employmentFromDate[exIndex])
            : "";

        String toDate = addExperienceControllers.employmentToDate.isNotEmpty &&
                addExperienceControllers.employmentToDate.length - 1 == exIndex
            ? formatDate(addExperienceControllers.employmentToDate[exIndex])
            : "";

        exItemFinal =
            "$exItemFinal\n\n\n ${addExItem.text}\n $companyName\n $location\n From: $fromDate To: $toDate";
        print(
            "$exIndex : ${addExperienceControllers.employmentFromDate.length}");
        exIndex++;
      }

      //For step4.dart
      for (var addEdItem in addEducationControllers.studyTitleController) {
        String subject =
            addEducationControllers.universityNameController[edIndex].text;

        String graduateDate =
            addEducationControllers.studyFromDate.isNotEmpty &&
                    addEducationControllers.studyFromDate.length - 1 == edIndex
                ? formatDate(addEducationControllers.studyFromDate[edIndex])
                : "";

        edItemFinal =
            "$edItemFinal\n\n\n ${addEdItem.text}\n $subject\n Graduate: $graduateDate";
        edIndex++;
      }

      String myPrompt =
          "name: $name\n Skills: $skills\n $exItemFinal\n $edItemFinal";
      //
      // String myPrompt =
      //     "please make a description for me, here is my details: name: $name\n Skills: $skills\n $exItemFinal\n $edItemFinal. Please note:[1. do not suggest me anything (like; title, subtitle etc), just write description in a paragraph. 2. Aim for  description between 50-70 words or 5-7 Bullet Points. 3. no need to use my name 4. no need to bold, italic, underline etc.]";

      // String myPrompt =
      //     "please make a cv description for me, here is my details: name: $name\n phone: $phone\n email: $email\n address: $address\n Portfolio [ $itemFinal ]\n Skills: $skills\n $exItemFinal\n $edItemFinal. Please note: Aim for cv description between 50-70 words or 5-7 Bullet Points";
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GetPdf(
            name: name,
            email: email,
            phone: phone,
            address: address,
            skills: skills,
            language: language,
            myPrompt: myPrompt,
          ),
        ),
      );
    }
    details.onStepContinue!();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Consumer<StepperProvider>(
              builder: (context, value, child) {
                return Stepper(
                  currentStep: value.currentStep,
                  onStepContinue: () {
                    final isLastStep = value.currentStep ==
                        getStep(currentStep: value.currentStep).length - 1;
                    if (isLastStep) {
                    } else {
                      value.continueStep();
                    }
                  },
                  onStepCancel: () {
                    value.currentStep == 0 ? null : value.cancelStep();
                  },
                  controlsBuilder: (context, details) {
                    final isLastStep = value.currentStep ==
                        getStep(currentStep: value.currentStep).length - 1;
                    return Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Consumer<AdditionalOptionProvider>(
                        builder: (context, isAddValue, child) {
                          return Visibility(
                            visible: !isAddValue.isAddValue,
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () =>
                                      onSubmitPress(isLastStep, details),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  child: Text(
                                    isLastStep ? "Submit" : "Next",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                if (value.currentStep != 0)
                                  ElevatedButton(
                                    onPressed: details.onStepCancel,
                                    child: const Text("Back"),
                                  ),
                                const SizedBox(width: 10),
                                if (isLastStep)
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      isAddValue.isAdd(!isAddValue.isAddValue);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                    ),
                                    icon: const Icon(
                                      Icons.add_box,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      "Additional Options",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                  steps: getStep(currentStep: value.currentStep),
                );
              },
            ),
            Consumer<AdditionalOptionProvider>(
              builder: (context, value, child) {
                return Visibility(
                  visible: value.isAddValue,
                  child: Consumer<AdditionalStepperProvider>(
                    builder: (context, value, child) {
                      return Stepper(
                        currentStep: value.currentStep,
                        onStepContinue: () {
                          final isLastStep = value.currentStep ==
                              additionalGetStep(currentStep: value.currentStep)
                                      .length -
                                  1;
                          if (isLastStep) {
                          } else {
                            value.continueStep();
                          }
                        },
                        onStepCancel: () {
                          value.currentStep == 0 ? null : value.cancelStep();
                        },
                        controlsBuilder: (context, details) {
                          final isLastStep = value.currentStep ==
                              additionalGetStep(currentStep: value.currentStep)
                                      .length -
                                  1;
                          return Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () =>
                                      onSubmitPress(isLastStep, details),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  child: Text(
                                    isLastStep ? "Submit" : "Next",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                if (value.currentStep != 0)
                                  ElevatedButton(
                                    onPressed: details.onStepCancel,
                                    child: const Text("Back"),
                                  ),
                              ],
                            ),
                          );
                        },
                        steps:
                            additionalGetStep(currentStep: value.currentStep),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Step> getStep({required int currentStep}) {
    return [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Personal Details"),
        content: const Step1(),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Skills"),
        content: const Step2(),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Experience"),
        content: const Step3(),
      ),
      Step(
        isActive: currentStep >= 3,
        title: const Text("Education"),
        content: const Step4(),
      ),
    ];
  }

  List<Step> additionalGetStep({required int currentStep}) {
    return [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Additional Training"),
        content: const AdditionalStep1(),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Languages"),
        content: const Step5(),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("References"),
        content: const AdditionalStep3(),
      ),
      Step(
        // state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 3,
        title: const Text("Projects"),
        content: const AdditionalStep4(),
      ),
    ];
  }
}
