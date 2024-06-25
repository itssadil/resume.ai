import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addExperienceProvider.dart';
import 'package:resumeai/widgets/dateFormatter.dart';
import 'package:resumeai/widgets/pdfView/customHeadLine.dart';
import 'package:resumeai/widgets/pdfView/customText.dart';

class Experience extends StatelessWidget {
  const Experience({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        CustomText.textWithLabel(
                          label: value.companyNameController[index].text,
                          text: companyLocation,
                          letterSpacing: 1.5,
                        ),
                        const Divider(
                          thickness: 0.1,
                          height: 10,
                        ),
                        CustomText.textWithLabel(
                          label: "Title: ",
                          text: value.jobTitleController[index].text,
                          letterSpacing: 1.3,
                        ),
                        const SizedBox(height: 3),
                        CustomText.sideBarText(
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
}
