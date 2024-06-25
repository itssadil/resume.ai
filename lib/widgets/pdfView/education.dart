import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addEducationProvider.dart';
import 'package:resumeai/widgets/dateFormatter.dart';
import 'package:resumeai/widgets/pdfView/customText.dart';

class Education extends StatelessWidget {
  const Education({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  CustomText.sideBarText(
                    text: value.studyTitleController[index].text,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.grey.shade800,
                  ),
                  const Divider(
                    thickness: 0.1,
                    height: 10,
                  ),
                  CustomText.textWithLabel(
                    label: "Institute: ",
                    text: value.universityNameController[index].text,
                    letterSpacing: 1.3,
                  ),
                  // const SizedBox(height: 3),
                  // CustomText.textWithLabel(
                  //   label: "Department: ",
                  //   text: "Computer Technology (CMT)",
                  //   letterSpacing: 1.3,
                  // ),
                  const SizedBox(height: 3),
                  CustomText.textWithLabel(
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
}
