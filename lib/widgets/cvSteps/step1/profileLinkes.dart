import 'package:flutter/material.dart';
import 'package:resumeai/widgets/customTextField.dart';

class ProfileLinks extends StatelessWidget {
  ProfileLinks(
      {Key? key, required this.urlController, required this.urlNameController})
      : super(key: key);
  final TextEditingController urlController;
  final TextEditingController urlNameController;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CustomTextField(
              controller: urlController,
              labelText: "Link(ex: https://www.linkedin.com/in/itss-adil/)",
              maxLines: 1,
            ),
            // CustomTextField(
            //   controller: urlNameController,
            //   labelText: "Profile Name(ex: Linkedin)",
            //   maxLines: 1,
            // ),
          ],
        ),
      ),
    );
  }
}
