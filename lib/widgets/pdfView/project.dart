import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addProjectProvider.dart';
import 'package:resumeai/widgets/dateFormatter.dart';
import 'package:resumeai/widgets/pdfView/customHeadLine.dart';
import 'package:resumeai/widgets/pdfView/customText.dart';

class Project extends StatelessWidget {
  Project({Key? key, required this.projectInfoList}) : super(key: key);
  final List<String> projectInfoList;

  @override
  Widget build(BuildContext context) {
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
                        CustomText.sideBarText(
                          text: value.projectTitleController[index].text,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                        const Divider(
                          thickness: 0.1,
                          height: 10,
                        ),
                        CustomText.textWithLabel(
                          label: "Role: ",
                          text: value.roleController[index].text,
                          letterSpacing: 1.3,
                        ),
                        const SizedBox(height: 3),
                        CustomText.sideBarText(
                          text: projectInfoList[index],
                          letterSpacing: 1.5,
                        ),
                        const SizedBox(height: 3),
                        CustomText.sideBarText(
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
}
