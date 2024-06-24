import 'package:flutter/material.dart';

Widget description({required String description}) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Text(
      description,
      style: TextStyle(color: Colors.grey.shade900, letterSpacing: 1.3),
      textAlign: TextAlign.justify,
    ),
  );
}
