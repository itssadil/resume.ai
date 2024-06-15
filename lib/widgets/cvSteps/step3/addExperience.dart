import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addExperienceProvider.dart';
import 'package:resumeai/providers/employmentDateProvider.dart';
import 'package:resumeai/widgets/customTextField.dart';

class AddExperience extends StatelessWidget {
  AddExperience({
    Key? key,
    required this.jobTitleController,
    required this.companyNameController,
    required this.locationController,
    required this.index,
  }) : super(key: key);
  final TextEditingController jobTitleController;
  final TextEditingController companyNameController;
  final TextEditingController locationController;
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
        final employmentDateProvider =
            Provider.of<EmploymentDateProvider>(context, listen: false);

        final addExperienceProvider =
            Provider.of<AddExperienceProvider>(context, listen: false);

        isFromDate
            ? addExperienceProvider.addFromTime(pickedDate)
            : addExperienceProvider.addToTime(pickedDate);

        employmentDateProvider.changeDate(isFromDate, pickedDate);

        return pickedDate;
      } else {
        // User canceled the picker
        return null;
      }
    }

    String formatDate(DateTime date) {
      // Extract year, month, and day as strings
      final year = date.year.toString();
      final month =
          date.month.toString().padLeft(2, '0'); // Pad month with leading zero
      final day =
          date.day.toString().padLeft(2, '0'); // Pad day with leading zero

      return '$day-$month-$year'; // Combine formatted components
    }

    return Column(
      children: [
        CustomTextField(
          controller: jobTitleController,
          labelText: "Job Title",
          maxLines: 1,
        ),
        CustomTextField(
          controller: companyNameController,
          labelText: "Company Name",
          maxLines: 1,
        ),
        CustomTextField(
          controller: locationController,
          labelText: "Location(Optional)",
          maxLines: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Consumer<EmploymentDateProvider>(
              builder: (context, value, child) {
                return Consumer<AddExperienceProvider>(
                  builder: (context, addExValue, child) {
                    return Wrap(
                      children: [
                        const Text(
                          "Dates of employment",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => _selectDate(context, true),
                          child: addExValue.employmentFromDate.length >=
                                      index + 1 &&
                                  addExValue.employmentFromDate.isNotEmpty &&
                                  formatDate(addExValue
                                          .employmentFromDate[index]) !=
                                      "01-01-3030"
                              ? Text(formatDate(
                                  addExValue.employmentFromDate[index]))
                              : value.fromDate != null
                                  ? Text(formatDate(value.fromDate!))
                                  : const Text('From'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => _selectDate(context, false),
                          child: addExValue.employmentToDate.length >=
                                      index + 1 &&
                                  addExValue.employmentToDate.isNotEmpty &&
                                  formatDate(
                                          addExValue.employmentToDate[index]) !=
                                      "01-01-3030"
                              ? Text(formatDate(
                                  addExValue.employmentToDate[index]))
                              : value.toDate != null
                                  ? Text(formatDate(value.toDate!))
                                  : const Text('To'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
