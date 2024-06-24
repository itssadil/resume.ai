import 'package:flutter/material.dart';

class CustomText {
  static Widget sideBarText({
    required String text,
    double? fontSize = 14,
    FontWeight? fontWeight = FontWeight.normal,
    TextDecoration? textDecoration = TextDecoration.none,
    double? letterSpacing = 1,
    Color? color = Colors.black,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
        letterSpacing: letterSpacing,
        color: color,
      ),
    );
  }

  static Widget textWithLabel({
    required String text,
    required String label,
    double? fontSize = 14,
    FontWeight? fontWeight = FontWeight.normal,
    TextDecoration? textDecoration = TextDecoration.none,
    double? letterSpacing = 1,
  }) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.grey.shade800,
          ),
        ),
        TextSpan(
          text: text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            decoration: textDecoration,
            letterSpacing: letterSpacing,
          ),
        ),
      ]),
    );
  }
}
