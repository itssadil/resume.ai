import 'package:flutter/material.dart';
import 'package:resumeai/screens/pdfView/widgets/customText.dart';

Widget skills({required String skill}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      CustomText.sideBarText(
        text: "Skills",
        fontWeight: FontWeight.bold,
      ),
      const Divider(),
      CustomText.sideBarText(
        text: skill,
      ),
    ],
  );
}
