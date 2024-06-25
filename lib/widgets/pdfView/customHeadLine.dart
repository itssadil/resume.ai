import 'package:flutter/material.dart';
import 'package:resumeai/widgets/pdfView/customText.dart';

customHeadLine({required String title}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.sideBarText(
          text: title,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        const Divider(),
      ],
    ),
  );
}
