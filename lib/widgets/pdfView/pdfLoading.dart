import 'package:flutter/material.dart';
import 'package:resumeai/widgets/appLoading.dart';
import 'package:resumeai/widgets/pdfView/pdfHeader.dart';

Widget pdfLoading() {
  const Color secondaryColor = Colors.tealAccent;
  return SingleChildScrollView(
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      padding: const EdgeInsets.all(5.0),
      color: Colors.white,
      child: Column(
        children: [
          pdfHeader(color: secondaryColor, loading: true),
          Container(
            color: secondaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        appLoading(),
                        const SizedBox(height: 50),
                        appLoading(),
                        const SizedBox(height: 50),
                        appLoading(),
                        const SizedBox(height: 50),
                        appLoading(),
                        const SizedBox(height: 50),
                        appLoading(),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appLoading(),
                        const SizedBox(height: 50),
                        appLoading(),
                        const SizedBox(height: 50),
                        appLoading(),
                        const SizedBox(height: 50),
                        appLoading(),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
