import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addTrainingProvider.dart';
import 'package:resumeai/widgets/dateFormatter.dart';
import 'package:resumeai/widgets/pdfView/customHeadLine.dart';
import 'package:resumeai/widgets/pdfView/customTextatter.dart';

class Training extends StatelessWidget {
  const Training({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        CustomText.sideBarText(
                          text: value.trainingTitleController[index].text,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                        const Divider(
                          thickness: 0.1,
                          height: 10,
                        ),
                        CustomText.textWithLabel(
                          label: "Institute: ",
                          text: value.instituteNameController[index].text,
                          letterSpacing: 1.3,
                        ),
                        const SizedBox(height: 3),
                        CustomText.sideBarText(
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
}
