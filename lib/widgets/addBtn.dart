import 'package:flutter/material.dart';

class CustomAddButton extends StatefulWidget {
  const CustomAddButton(
      {Key? key, required this.onPressed, required this.title})
      : super(key: key);

  final void Function()? onPressed;
  final title;

  @override
  State<CustomAddButton> createState() => _CustomAddButtonState();
}

class _CustomAddButtonState extends State<CustomAddButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: Text(widget.title),
        // child: Text("Add Link ${currentProfile.currentProfile}/4"),
      ),
    );
  }
}
