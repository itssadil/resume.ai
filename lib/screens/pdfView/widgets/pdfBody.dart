import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addReferenceProvider.dart';
import 'package:resumeai/screens/pdfView/widgets/contact.dart';
import 'package:resumeai/screens/pdfView/widgets/customHeadLine.dart';
import 'package:resumeai/screens/pdfView/widgets/customText.dart';
import 'package:resumeai/screens/pdfView/widgets/description.dart';
import 'package:resumeai/screens/pdfView/widgets/education.dart';
import 'package:resumeai/screens/pdfView/widgets/experience.dart';
import 'package:resumeai/screens/pdfView/widgets/language.dart';
import 'package:resumeai/screens/pdfView/widgets/pdfHeader.dart';
import 'package:resumeai/screens/pdfView/widgets/project.dart';
import 'package:resumeai/screens/pdfView/widgets/reference.dart';
import 'package:resumeai/screens/pdfView/widgets/skills.dart';
import 'package:resumeai/screens/pdfView/widgets/training.dart';

class pdfBody extends StatelessWidget {
  pdfBody({
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
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 30),
        padding: const EdgeInsets.all(5.0),
        color: Colors.white,
        child: Column(
          children: [
            pdfHeader(
              color: secondaryColor,
              loading: false,
              name: name,
              subtitle: subtitle,
            ),
            Container(
              color: secondaryColor,
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
                            visible:
                                referenceProvider.referenceController[0].text !=
                                        ""
                                    ? true
                                    : false,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
          ],
        ),
      ),
    );
  }
}
