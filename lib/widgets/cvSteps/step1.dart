import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/profileLinkProvider.dart';
import 'package:resumeai/widgets/addBtn.dart';
import 'package:resumeai/widgets/addOption.dart';
import 'package:resumeai/widgets/customTextField.dart';

class Step1 extends StatelessWidget {
  const Step1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    return Column(
      children: [
        CustomTextField(controller: nameController, labelText: "Name"),
        CustomTextField(controller: phoneController, labelText: "Phone"),
        CustomTextField(controller: emailController, labelText: "Email"),
        CustomTextField(controller: messageController, labelText: "Address"),
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
            itemCount:
                value.controllers.length < 4 ? value.controllers.length : 4,
            urlControllers: value.controllers,
            urlNameControllers: value.controllersName,
            whoIs: "step1",
          );
        }),
        Consumer<ProfileLinkProvider>(
          builder: (context, currentProfile, child) {
            return Visibility(
              // visible: currentProfile.currentProfile != 4 ? true : false,
              visible: currentProfile.controllers.length >= 4 ? false : true,
              child: CustomAddButton(
                onPressed: () {
                  for (var item in currentProfile.controllers) {
                    print(item.text);
                  }
                  for (var item in currentProfile.controllersName) {
                    print(item.text);
                  }
                  currentProfile.addProfile();
                },
                title: "Add Link ${currentProfile.controllers.length}/4",
              ),
            );
          },
        )
      ],
    );
  }
}
