import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/profileLinkProvider.dart';
import 'package:resumeai/widgets/addBtn.dart';
import 'package:resumeai/widgets/addOption.dart';
import 'package:resumeai/widgets/controllers.dart';
import 'package:resumeai/widgets/customTextField.dart';

class Step1 extends StatelessWidget {
  const Step1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: TextControllers.nameController,
          labelText: "Name",
          maxLines: 1,
        ),
        CustomTextField(
          controller: TextControllers.phoneController,
          labelText: "Phone",
          maxLines: 1,
        ),
        CustomTextField(
          controller: TextControllers.emailController,
          labelText: "Email",
          maxLines: 1,
        ),
        CustomTextField(
          controller: TextControllers.addressController,
          labelText: "Address",
          maxLines: 3,
        ),
        const Card(
          color: Colors.greenAccent,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Add Links - Like: Linkedin, Facebook, Instagram etc (Optional)",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        Consumer<ProfileLinkProvider>(builder: (context, value, child) {
          return AddOption(
            itemCount: value.urlControllers.length < 4
                ? value.urlControllers.length
                : 4,
            urlControllers: value.urlControllers,
            urlNameControllers: value.urlNameControllers,
            whoIs: "step1",
          );
        }),
        Consumer<ProfileLinkProvider>(
          builder: (context, currentProfile, child) {
            return Visibility(
              // visible: currentProfile.currentProfile != 4 ? true : false,
              visible: currentProfile.urlControllers.length >= 4 ? false : true,
              child: CustomAddButton(
                onPressed: () {
                  // int index = 0;
                  // for (var item in currentProfile.urlControllers) {
                  //   print(
                  //       "${currentProfile.urlNameControllers[index].text}: ${item.text}");
                  //   index++;
                  // }
                  // for (var item in currentProfile.urlNameControllers) {
                  //   print(item.text);
                  // }
                  currentProfile.addProfile();
                },
                title: "Add Link ${currentProfile.urlControllers.length}/4",
              ),
            );
          },
        )
      ],
    );
  }
}
