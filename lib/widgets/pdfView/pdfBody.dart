import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addReferenceProvider.dart';
import 'package:resumeai/providers/pdfColor.dart';
import 'package:resumeai/widgets/pdfView/contact.dart';
import 'package:resumeai/widgets/pdfView/customHeadLine.dart';
import 'package:resumeai/widgets/pdfView/customText.dart';
import 'package:resumeai/widgets/pdfView/description.dart';
import 'package:resumeai/widgets/pdfView/education.dart';
import 'package:resumeai/widgets/pdfView/experience.dart';
import 'package:resumeai/widgets/pdfView/language.dart';
import 'package:resumeai/widgets/pdfView/pdfHeader.dart';
import 'package:resumeai/widgets/pdfView/project.dart';
import 'package:resumeai/widgets/pdfView/reference.dart';
import 'package:resumeai/widgets/pdfView/skills.dart';
import 'package:resumeai/widgets/pdfView/training.dart';

class PdfBody extends StatelessWidget {
  PdfBody({
    Key? key,
    required this.name,
    required this.subtitle,
    required this.email,
    required this.phone,
    required this.address,
    required this.skill,
    required this.languages,
    required this.desc,
    required this.generatedList,
  }) : super(key: key);

  final String name;
  final String subtitle;
  final String email;
  final String phone;
  final String address;
  final String skill;
  final String languages;
  final String desc;
  final List<String> generatedList;

  @override
  Widget build(BuildContext context) {
    const Color secondaryColor = Colors.tealAccent;
    final referenceProvider =
        Provider.of<AddReferenceProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            padding: const EdgeInsets.all(5.0),
            color: Colors.white,
            child: Column(
              children: [
                Consumer<PdfColorProvider>(
                  builder: (context, value, child) {
                    return pdfHeader(
                      color: value.SelectedColor,
                      loading: false,
                      name: name,
                      subtitle: subtitle,
                    );
                  },
                ),
                Consumer<PdfColorProvider>(
                  builder: (context, value, child) {
                    return Container(
                      color: value.SelectedColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  contact(
                                    email: email,
                                    phone: phone,
                                    address: address,
                                  ),
                                  const SizedBox(height: 50),
                                  skills(skill: skill),
                                  language(languages: languages),
                                  Visibility(
                                    visible: referenceProvider
                                                .referenceController[0].text !=
                                            ""
                                        ? true
                                        : false,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 50),
                                        CustomText.sideBarText(
                                          text: "Reference",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        const Divider(),
                                        reference(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  description(description: desc),
                                  const SizedBox(height: 10),
                                  customHeadLine(title: "Education"),
                                  const Education(),
                                  const SizedBox(height: 10),
                                  const Experience(),
                                  const SizedBox(height: 10),
                                  const Training(),
                                  const SizedBox(height: 10),
                                  Project(projectInfoList: generatedList),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
