import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.maxLines,
    this.onChanged,
  }) : super(key: key);

  final controller;
  final labelText;
  final int maxLines;
  void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          labelText: "$labelText",
          labelStyle: TextStyle(color: Colors.grey),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
        maxLines: maxLines,
        onChanged: onChanged,
      ),
    );
  }
}
