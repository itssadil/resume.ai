import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addProjectProvider.dart';
import 'package:resumeai/widgets/customTextField.dart';
import 'package:resumeai/widgets/dateFormatter.dart';

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
        final addProjectProvider =
            Provider.of<AddProjectProvider>(context, listen: false);

        isFromDate
            ? addProjectProvider.addFromTime(pickedDate)
            : addProjectProvider.addToTime(pickedDate);

        return pickedDate;
      } else {
        // User canceled the picker
        return null;
      }
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
        const Card(
          color: Colors.greenAccent,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Short project description, please. We'll summarize it briefly.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        CustomTextField(
          controller: descriptionController,
          labelText:
              "1: Measures body mass index using weight and height.\n2: Indicates if weight is under, normal, or overweight.",
          maxLines: 3,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Consumer<AddProjectProvider>(
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
                      child: addExValue.projectFromDate.length >= index + 1 &&
                              addExValue.projectFromDate.isNotEmpty &&
                              formatDate(addExValue.projectFromDate[index]) !=
                                  "01-01-3030"
                          ? Text(formatDate(addExValue.projectFromDate[index]))
                          : const Text('From'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _selectDate(context, false),
                      child: addExValue.projectToDate.length >= index + 1 &&
                              addExValue.projectToDate.isNotEmpty &&
                              formatDate(addExValue.projectToDate[index]) !=
                                  "01-01-3030"
                          ? Text(formatDate(addExValue.projectToDate[index]))
                          : const Text('To'),
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
