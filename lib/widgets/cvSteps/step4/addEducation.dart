import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addEducationProvider.dart';
import 'package:resumeai/providers/errorMessageProvider.dart';
import 'package:resumeai/widgets/customTextField.dart';
import 'package:resumeai/widgets/dateFormatter.dart';
import 'package:resumeai/widgets/errorMessage.dart';

class AddEducation extends StatelessWidget {
  AddEducation({
    Key? key,
    required this.studyTitleController,
    required this.universityNameController,
    required this.index,
  }) : super(key: key);
  final TextEditingController studyTitleController;
  final TextEditingController universityNameController;
  final int index;

  @override
  Widget build(BuildContext context) {
    Future<DateTime?> _selectDate(BuildContext context, bool isFromDate) async {
      final initialDate = DateTime.now(); // Set initial date as today

      final pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1971, 8, 1), // Optional minimum allowed date
        lastDate: initialDate, // Optional maximum allowed date
      );

      if (pickedDate != null) {
        final addEducationProvider =
            Provider.of<AddEducationProvider>(context, listen: false);

        isFromDate
            ? addEducationProvider.addFromTime(pickedDate)
            : addEducationProvider.addToTime(pickedDate);

        return pickedDate;
      } else {
        // User canceled the picker
        return null;
      }
    }

    final errorMessageProvider = Provider.of<ErrorMessageProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: studyTitleController,
          labelText: "Course Title*",
          maxLines: 1,
        ),
        errorMessage(
            title: 'course title',
            isVisible: errorMessageProvider.educaionTitle),
        CustomTextField(
          controller: universityNameController,
          labelText: "University Name*",
          maxLines: 1,
        ),
        errorMessage(
            title: 'university name',
            isVisible: errorMessageProvider.institute),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Consumer<AddEducationProvider>(
              builder: (context, addExValue, child) {
                return Wrap(
                  children: [
                    const Text(
                      "Graduated",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _selectDate(context, true),
                      child: addExValue.studyFromDate.length >= index + 1 &&
                              addExValue.studyFromDate.isNotEmpty &&
                              formatDate(addExValue.studyFromDate[index]) !=
                                  "01-01-3030"
                          ? Text(formatDate(addExValue.studyFromDate[index]))
                          : const Text('Select Date'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
