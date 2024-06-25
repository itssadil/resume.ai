import 'package:flutter/material.dart';
import 'package:resumeai/widgets/pdfView/customText.dart';

Widget language({required String languages}) {
  return Visibility(
    visible: languages.isNotEmpty ? true : false,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        CustomText.sideBarText(
          text: "Language",
          fontWeight: FontWeight.bold,
        ),
        const Divider(),
        CustomText.sideBarText(
          text: languages,
        ),
      ],
    ),
  );
}
