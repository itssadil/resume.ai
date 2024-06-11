import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addProjectProvider.dart';
import 'package:resumeai/providers/employmentDateProvider.dart';
import 'package:resumeai/widgets/customTextField.dart';

class AddProject extends StatelessWidget {
  AddProject({
    Key? key,
    required this.projectTitleController,
    required this.roleController,
    required this.descriptionController,
    required this.index,
  }) : super(key: key);
  final TextEditingController projectTitleController;
  final TextEditingController roleController;
  final TextEditingController descriptionController;
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

        employmentDateProvider.changeDate(isFromDate, pickedDate);

        return pickedDate;
      } else {
        // User canceled the picker
        return null;
      }
    }

    String _formatDate(DateTime date) {
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
          controller: projectTitleController,
          labelText: "Title",
          maxLines: 1,
        ),
        CustomTextField(
          controller: roleController,
          labelText: "Your Role",
          maxLines: 1,
        ),
        CustomTextField(
          controller: descriptionController,
          labelText: "Description",
          maxLines: 3,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Consumer<EmploymentDateProvider>(
              builder: (context, value, child) {
                return Consumer<AddProjectProvider>(
                  builder: (context, addExValue, child) {
                    return Wrap(
                      children: [
                        const Text(
                          "Duration",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => _selectDate(context, true),
                          child: addExValue.projectFromDate.length >=
                                      index + 1 &&
                                  addExValue.projectFromDate.isNotEmpty &&
                                  _formatDate(
                                          addExValue.projectFromDate[index]) !=
                                      "01-01-3030"
                              ? Text(_formatDate(
                                  addExValue.projectFromDate[index]))
                              : value.fromDate != null
                                  ? Text(_formatDate(value.fromDate!))
                                  : const Text('From'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => _selectDate(context, false),
                          child: addExValue.projectToDate.length >= index + 1 &&
                                  addExValue.projectToDate.isNotEmpty &&
                                  _formatDate(
                                          addExValue.projectToDate[index]) !=
                                      "01-01-3030"
                              ? Text(
                                  _formatDate(addExValue.projectToDate[index]))
                              : value.toDate != null
                                  ? Text(_formatDate(value.toDate!))
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
