import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/profileLinkProvider.dart';
import 'package:resumeai/screens/pdfView/widgets/customText.dart';
import 'package:url_launcher/url_launcher.dart';

Widget contact(
    {required String email, required String phone, required String address}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      CustomText.sideBarText(
        text: "Contact",
        fontWeight: FontWeight.bold,
      ),
      const Divider(),
      CustomText.sideBarText(
        text: email,
      ),
      CustomText.sideBarText(
        text: phone,
      ),
      CustomText.sideBarText(
        text: address,
      ),
      Consumer<ProfileLinkProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: value.urlControllers.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  // Launch the URL in a web browser
                  if (await canLaunchUrl(
                    Uri.parse(value.urlControllers[index].text),
                  )) {
                    await launchUrl(
                        Uri.parse(value.urlControllers[index].text));
                  } else {
                    throw 'Could not launch URL';
                  }
                },
                child: CustomText.sideBarText(
                  text: value.urlControllers[index].text,
                  color: Colors.blue.shade900,
                  // textDecoration: TextDecoration.underline,
                ),
              );
            },
          );
        },
      ),
    ],
  );
}
