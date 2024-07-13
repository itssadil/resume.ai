import 'package:flutter/material.dart';

Widget errorMessage({
  required String title,
  required bool isVisible,
}) {
  return Visibility(
    visible: isVisible,
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        "Please insert your $title",
        style: const TextStyle(color: Colors.red),
      ),
    ),
  );
}
