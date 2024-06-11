import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addReferenceProvider.dart';
import 'package:resumeai/widgets/addBtn.dart';
import 'package:resumeai/widgets/addOption.dart';

class AdditionalStep3 extends StatefulWidget {
  const AdditionalStep3({Key? key}) : super(key: key);

  @override
  State<AdditionalStep3> createState() => _AdditionalStep3State();
}

class _AdditionalStep3State extends State<AdditionalStep3> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<AddReferenceProvider>(
          builder: (context, value, child) {
            return AddOption(
              itemCount: value.referenceOptionController.length,
              whoIs: "additionalStep3",
              referenceOptionController: value.referenceOptionController,
              referenceController: value.referenceController,
            );
          },
        ),
        Consumer<AddReferenceProvider>(
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomAddButton(
                  onPressed: () {
                    for (var item in value.referenceOptionController) {
                      print(item.text);
                    }
                    // currentProfile.addProfile();

                    value.addValue();
                  },
                  title: "Add Reference",
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
