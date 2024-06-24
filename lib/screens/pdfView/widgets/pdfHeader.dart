import 'package:flutter/material.dart';
import 'package:resumeai/widgets/appLoading.dart';

Widget pdfHeader({
  required Color color,
  required bool loading,
  String? name,
  String? subtitle,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 5),
    decoration: BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(50),
      ),
    ),
    padding: const EdgeInsets.all(30),
    child: loading
        ? SizedBox(
            height: 100,
            child: Align(
              alignment: Alignment.centerLeft,
              child: appLoading(),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              Text(
                subtitle!,
              ),
            ],
          ),
  );
}
