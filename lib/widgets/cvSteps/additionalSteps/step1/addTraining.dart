import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumeai/providers/addTrainingProvider.dart';
import 'package:resumeai/widgets/customTextField.dart';

class AddTraining extends StatelessWidget {
  AddTraining({
    Key? key,
    required this.trainingTitleController,
    required this.instituteNameController,
    required this.index,
  }) : super(key: key);
  final TextEditingController trainingTitleController;
  final TextEditingController instituteNameController;
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
        final addTrainingProvider =
            Provider.of<AddTrainingProvider>(context, listen: false);

        isFromDate
            ? addTrainingProvider.addFromTime(pickedDate)
            : addTrainingProvider.addToTime(pickedDate);

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
          controller: trainingTitleController,
          labelText: "Title",
          maxLines: 1,
        ),
        CustomTextField(
          controller: instituteNameController,
          labelText: "Institute Name",
          maxLines: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Consumer<AddTrainingProvider>(
              builder: (context, addExValue, child) {
                return Wrap(
                  children: [
                    const Text(
                      "Dates Attended",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _selectDate(context, true),
                      child: addExValue.trainingFromDate.length >= index + 1 &&
                              addExValue.trainingFromDate.isNotEmpty &&
                              _formatDate(addExValue.trainingFromDate[index]) !=
                                  "01-01-3030"
                          ? Text(
                              _formatDate(addExValue.trainingFromDate[index]))
                          : const Text('From'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _selectDate(context, false),
                      child: addExValue.trainingToDate.length >= index + 1 &&
                              addExValue.trainingToDate.isNotEmpty &&
                              _formatDate(addExValue.trainingToDate[index]) !=
                                  "01-01-3030"
                          ? Text(_formatDate(addExValue.trainingToDate[index]))
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
