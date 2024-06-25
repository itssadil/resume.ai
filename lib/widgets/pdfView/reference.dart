import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addReferenceProvider.dart';
import 'package:resumeai/widgets/pdfView/customText.dart';

Widget reference() {
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
              CustomText.sideBarText(
                  text: value.referenceController[index].text,
                  fontWeight: FontWeight.bold),
              CustomText.sideBarText(
                  text: value.referenceOptionController[index].text),
            ],
          );
        },
      );
    },
  );
}
