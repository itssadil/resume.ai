import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/consts.dart';
import 'package:resumeai/providers/stepperProvider.dart';
import 'package:resumeai/widgets/cvSteps/step1/step1.dart';
import 'package:resumeai/widgets/cvSteps/step2.dart';
import 'package:resumeai/widgets/cvSteps/step3/step3.dart';
import 'package:resumeai/widgets/cvSteps/step4/step4.dart';

class CvForm extends StatefulWidget {
  const CvForm({Key? key}) : super(key: key);

  @override
  State<CvForm> createState() => _CvFormState();
}

class _CvFormState extends State<CvForm> {
  final TextEditingController _userMessage = TextEditingController();

  final model =
      GenerativeModel(model: "gemini-1.5-flash-latest", apiKey: GEMINI_API_KEY);

  String getResponse = "";

  sendMessage() async {
    final message = _userMessage.text;
    _userMessage.clear();

    final prompt = message;
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    print(response.text);
    setState(() {
      getResponse = response.text!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<StepperProvider>(
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

                // final addProfileValue =
                //     Provider.of<ProfileLinkProvider>(context, listen: false);
                // if (value.currentStep == 1) {
                //   addProfileValue.addProfile();
                // }
              },
              onStepCancel: () {
                value.currentStep == 0 ? null : value.cancelStep();
              },
              controlsBuilder: (context, details) {
                final isLastStep = value.currentStep ==
                    getStep(currentStep: value.currentStep).length - 1;
                return Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => details.onStepContinue!(),
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
              steps: getStep(currentStep: value.currentStep),
            );
          },
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
        state: currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 3,
        title: const Text("Education"),
        content: const Step4(),
      ),
      Step(
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 4,
        title: const Text("Additional Training"),
        content: Container(),
      ),
      Step(
        state: currentStep > 5 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 5,
        title: const Text("Projects"),
        content: Container(),
      ),
      Step(
        state: currentStep > 6 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 6,
        title: const Text("Languages"),
        content: Container(),
      ),
      Step(
        isActive: currentStep >= 7,
        title: const Text("References"),
        content: Container(),
      ),
    ];
  }
}
