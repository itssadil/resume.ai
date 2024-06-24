import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/consts.dart';
import 'package:resumeai/providers/addEducationProvider.dart';
import 'package:resumeai/providers/addExperienceProvider.dart';
import 'package:resumeai/providers/addProjectProvider.dart';
import 'package:resumeai/providers/addReferenceProvider.dart';
import 'package:resumeai/providers/addTrainingProvider.dart';
import 'package:resumeai/providers/profileLinkProvider.dart';
import 'package:resumeai/widgets/appLoading.dart';
import 'package:resumeai/widgets/dateFormatter.dart';
import 'package:url_launcher/url_launcher.dart';

class GetPdf extends StatefulWidget {
  const GetPdf({
    Key? key,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.skills,
    required this.myPrompt,
    required this.language,
  }) : super(key: key);
  final String name;
  final String phone;
  final String email;
  final String address;
  final String skills;
  final String language;
  final String myPrompt;

  @override
  State<GetPdf> createState() => _GetPdfState();
}

class _GetPdfState extends State<GetPdf> {
  final model =
      GenerativeModel(model: "gemini-1.5-flash-latest", apiKey: GEMINI_API_KEY);

  // Note: For your API key, please create a file named consts.dart inside the lib folder and add the following line:
  // const String GEMINI_API_KEY = "YOUR_API_KEY";

  String getResponse = "";
  String getSubtitle = "";
  String getSkills = "";
  List<String> generatedList = [];

  @override
  void initState() {
    sendMessage();
    super.initState();
  }

  sendMessage() async {
    // For Description Prompt
    final description =
        "please make a description for me, here is my details: '${widget.myPrompt}'  Please note:[1. do not suggest me anything (like; title, subtitle etc), just write description in a paragraph. 2. Aim for  description between 50-70 words or 5-7 Bullet Points. 3. no need to use my name 4. no need to bold, italic, underline etc.]";

    // For  Subtitle Prompt(e.g. Flutter Developer)
    final subtitle =
        "'${widget.myPrompt}' According to those qualification, please write a title which is suitable for me. note: [1. don't suggest me, just provide one title. 2. title should be no more then 3 words.]";

    // For Skills Prompt
    final mySkills =
        "${widget.skills} please Brief my skills up to 5 words. note:[1. separate all skills with double new line. 2. write title, then write a colon followed by a brief description of the skills. 3.  don't suggest me anything else 4.  don't write any other words. 5. do not suggest me anything (like; title, subtitle etc)]";

    // Get Project List
    final projectProvider =
        Provider.of<AddProjectProvider>(context, listen: false);

    //Generate Description

    final prompt = description;
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    //Generate Subtitle (e.g. Flutter Developer)

    final subPrompt = subtitle;
    final subContent = [Content.text(subPrompt)];
    final subResponse = await model.generateContent(subContent);

    //Generate Skills

    final skillPrompt = mySkills;
    final skillContent = [Content.text(skillPrompt)];
    final skillResponse = await model.generateContent(skillContent);

    // Generate Project
    for (int i = 0; i < projectProvider.projectTitleController.length; i++) {
      // For Project Description Prompt

      final projectPrompt =
          "please generate a short description for my project, project info: name: ${projectProvider.projectTitleController[i].text}, basic info: ${projectProvider.descriptionController[i].text}  Please note:[1. do not suggest me anything (like; title, subtitle etc), just write description in a paragraph. 2. Aim for  description between 25-45 words or 3-4 Bullet Points. 3. no need to bold, italic, underline etc.]";
      final projectContent = [Content.text(projectPrompt)];
      final projectResponse = await model.generateContent(projectContent);
      generatedList.add("${projectResponse.text}");
    }

    setState(() {
      getResponse = response.text!;
      getSubtitle = subResponse.text!;
      getSkills = skillResponse.text!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (kIsWeb) {
              return AspectRatio(
                aspectRatio: 3 / 3,
                child: getResponse != "" && getSubtitle != ""
                    ? pdfContainer()
                    : pdfLoading(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: pdfContainer(),
            );
          },
        ),
      ),
    );
  }

  Widget pdfContainer() {
    const Color secondaryColor = Colors.tealAccent;
    return LayoutBuilder(
      builder: (context, constraints) {
        final referenceProvider =
            Provider.of<AddReferenceProvider>(context, listen: false);
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  customHeader(color: secondaryColor, loading: false),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                            ),
                            color: secondaryColor,
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              contact(),
                              const SizedBox(height: 50),
                              skills(),
                              const SizedBox(height: 50),
                              language(),
                              const SizedBox(height: 50),
                              Visibility(
                                visible: referenceProvider
                                            .referenceController[0].text !=
                                        ""
                                    ? true
                                    : false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    sideBarText(
                                      text: "Reference",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const Divider(),
                                    reference(),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            description(),
                            const SizedBox(height: 10),
                            customHeadLine(title: "Education"),
                            education(),
                            const SizedBox(height: 10),
                            experience(),
                            const SizedBox(height: 10),
                            training(),
                            const SizedBox(height: 10),
                            project(),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget customHeader({
    required Color color,
    required bool loading,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
        ),
      ),
      padding: const EdgeInsets.all(30),
      child: loading
          ? SizedBox(
              height: 100,
              child: Align(
                alignment: Alignment.centerLeft,
                child: appLoading(),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                Text(
                  getSubtitle,
                ),
              ],
            ),
    );
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        getResponse,
        style: TextStyle(color: Colors.grey.shade900, letterSpacing: 1.3),
        textAlign: TextAlign.justify,
      ),
    );
  }

  static customHeadLine({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sideBarText(
            text: title,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          const Divider(),
        ],
      ),
    );
  }

  static Widget education() {
    return Consumer<AddEducationProvider>(
      builder: (context, value, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: value.studyTitleController.length,
          itemBuilder: (context, index) {
            final String graduateDate = value.studyFromDate.isNotEmpty &&
                    value.studyFromDate.length - 1 >= index
                ? formatDate(value.studyFromDate[index])
                : "";
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sideBarText(
                    text: value.studyTitleController[index].text,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.grey.shade800,
                  ),
                  const Divider(
                    thickness: 0.1,
                    height: 10,
                  ),
                  textWithLabel(
                    label: "Institute: ",
                    text: value.universityNameController[index].text,
                    letterSpacing: 1.3,
                  ),
                  // const SizedBox(height: 3),
                  // textWithLabel(
                  //   label: "Department: ",
                  //   text: "Computer Technology (CMT)",
                  //   letterSpacing: 1.3,
                  // ),
                  const SizedBox(height: 3),
                  textWithLabel(
                    label: value.studyFromDate.isNotEmpty ? "Graduated: " : "",
                    text: graduateDate,
                    letterSpacing: 1.3,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static Widget experience() {
    return Consumer<AddExperienceProvider>(
      builder: (context, value, child) {
        return Visibility(
          visible: value.jobTitleController[0].text != "" ? true : false,
          child: Column(
            children: [
              customHeadLine(title: "Experience"),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.companyNameController.length,
                itemBuilder: (context, index) {
                  final String exFromDate =
                      value.employmentFromDate.isNotEmpty &&
                              value.employmentFromDate.length - 1 >= index
                          ? formatDate(value.employmentFromDate[index])
                          : "";

                  final String exToDate = value.employmentToDate.isNotEmpty &&
                          value.employmentToDate.length - 1 >= index
                      ? formatDate(value.employmentToDate[index])
                      : "";

                  final String exDate = exToDate != "" && exFromDate != ""
                      ? "$exFromDate - $exToDate"
                      : "$exFromDate $exToDate";

                  final String companyLocation =
                      value.locationController[index].text != ""
                          ? " (${value.locationController[index].text})"
                          : "";
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWithLabel(
                          label: value.companyNameController[index].text,
                          text: companyLocation,
                          letterSpacing: 1.5,
                        ),
                        const Divider(
                          thickness: 0.1,
                          height: 10,
                        ),
                        textWithLabel(
                          label: "Title: ",
                          text: value.jobTitleController[index].text,
                          letterSpacing: 1.3,
                        ),
                        const SizedBox(height: 3),
                        sideBarText(
                          text: exDate,
                          letterSpacing: 1.3,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget training() {
    return Consumer<AddTrainingProvider>(
      builder: (context, value, child) {
        return Visibility(
          visible: value.trainingTitleController[0].text != "" ? true : false,
          child: Column(
            children: [
              customHeadLine(title: "Training"),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.trainingTitleController.length,
                itemBuilder: (context, index) {
                  final String trFromDate = value.trainingFromDate.isNotEmpty &&
                          value.trainingFromDate.length - 1 == index
                      ? formatDate(value.trainingFromDate[index])
                      : "";

                  final String trToDate = value.trainingToDate.isNotEmpty &&
                          value.trainingToDate.length - 1 == index
                      ? formatDate(value.trainingToDate[index])
                      : "";

                  final String trDate = trToDate != "" && trFromDate != ""
                      ? "$trFromDate - $trToDate"
                      : "$trFromDate $trToDate";

                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sideBarText(
                          text: value.trainingTitleController[index].text,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                        const Divider(
                          thickness: 0.1,
                          height: 10,
                        ),
                        textWithLabel(
                          label: "Institute: ",
                          text: value.instituteNameController[index].text,
                          letterSpacing: 1.3,
                        ),
                        const SizedBox(height: 3),
                        sideBarText(
                          text: trDate,
                          letterSpacing: 1.3,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget project() {
    return Consumer<AddProjectProvider>(
      builder: (context, value, child) {
        return Visibility(
          visible: value.projectTitleController[0].text != "" ? true : false,
          child: Column(
            children: [
              customHeadLine(title: "Projects"),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.projectTitleController.length,
                itemBuilder: (context, index) {
                  final String prFromDate = value.projectFromDate.isNotEmpty &&
                          value.projectFromDate.length - 1 == index
                      ? formatDate(value.projectFromDate[index])
                      : "";

                  final String prToDate = value.projectToDate.isNotEmpty &&
                          value.projectToDate.length - 1 == index
                      ? formatDate(value.projectToDate[index])
                      : "";

                  final String prDate = prToDate != "" && prFromDate != ""
                      ? "$prFromDate - $prToDate"
                      : "$prFromDate $prToDate";

                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sideBarText(
                          text: value.projectTitleController[index].text,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                        const Divider(
                          thickness: 0.1,
                          height: 10,
                        ),
                        textWithLabel(
                          label: "Role: ",
                          text: value.roleController[index].text,
                          letterSpacing: 1.3,
                        ),
                        const SizedBox(height: 3),
                        sideBarText(
                          text: generatedList[index],
                          letterSpacing: 1.5,
                        ),
                        const SizedBox(height: 3),
                        sideBarText(
                          text: prDate,
                          letterSpacing: 1.3,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget contact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        sideBarText(
          text: "Contact",
          fontWeight: FontWeight.bold,
        ),
        const Divider(),
        sideBarText(
          text: widget.email,
        ),
        sideBarText(
          text: widget.phone,
        ),
        sideBarText(
          text: widget.address,
        ),
        Consumer<ProfileLinkProvider>(
          builder: (context, value, child) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.urlControllers.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    // Launch the URL in a web browser
                    if (await canLaunchUrl(
                      Uri.parse(value.urlControllers[index].text),
                    )) {
                      await launchUrl(
                          Uri.parse(value.urlControllers[index].text));
                    } else {
                      throw 'Could not launch URL';
                    }
                  },
                  child: sideBarText(
                    text: value.urlControllers[index].text,
                    color: Colors.blue.shade900,
                    // textDecoration: TextDecoration.underline,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget skills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        sideBarText(
          text: "Skills",
          fontWeight: FontWeight.bold,
        ),
        const Divider(),
        sideBarText(
          text: getSkills,
        ),
      ],
    );
  }

  Widget language() {
    return Visibility(
      visible: widget.language.isNotEmpty ? true : false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          sideBarText(
            text: "Language",
            fontWeight: FontWeight.bold,
          ),
          const Divider(),
          sideBarText(
            text: widget.language,
          ),
        ],
      ),
    );
  }

  static Widget reference() {
    return Consumer<AddReferenceProvider>(
      builder: (context, value, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: value.referenceController.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sideBarText(
                    text: value.referenceController[index].text,
                    fontWeight: FontWeight.bold),
                sideBarText(text: value.referenceOptionController[index].text),
              ],
            );
          },
        );
      },
    );
  }

  Widget pdfLoading() {
    const Color secondaryColor = Colors.tealAccent;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  customHeader(color: secondaryColor, loading: true),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                            ),
                            color: secondaryColor,
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              appLoading(),
                              const SizedBox(height: 50),
                              appLoading(),
                              const SizedBox(height: 50),
                              appLoading(),
                              const SizedBox(height: 50),
                              appLoading(),
                              const SizedBox(height: 50),
                              appLoading(),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appLoading(),
                            const SizedBox(height: 50),
                            appLoading(),
                            const SizedBox(height: 50),
                            appLoading(),
                            const SizedBox(height: 50),
                            appLoading(),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget sideBarText({
    required String text,
    double? fontSize = 14,
    FontWeight? fontWeight = FontWeight.normal,
    TextDecoration? textDecoration = TextDecoration.none,
    double? letterSpacing = 1,
    Color? color = Colors.black,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
        letterSpacing: letterSpacing,
        color: color,
      ),
    );
  }

  static Widget textWithLabel({
    required String text,
    required String label,
    double? fontSize = 14,
    FontWeight? fontWeight = FontWeight.normal,
    TextDecoration? textDecoration = TextDecoration.none,
    double? letterSpacing = 1,
  }) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.grey.shade800,
          ),
        ),
        TextSpan(
          text: text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            decoration: textDecoration,
            letterSpacing: letterSpacing,
          ),
        ),
      ]),
    );
  }
}
