import 'package:flutter/material.dart';

class AddTrainingProvider with ChangeNotifier {
  final List<TextEditingController> _trainingTitleController =
      List.generate(1, (index) => TextEditingController());
  List<TextEditingController> get trainingTitleController =>
      _trainingTitleController;

  final List<TextEditingController> _instituteNameController =
      List.generate(1, (index) => TextEditingController());
  List<TextEditingController> get instituteNameController =>
      _instituteNameController;

  final List<DateTime> _trainingFromDate = [];
  List get trainingFromDate => _trainingFromDate;

  final List<DateTime> _trainingToDate = [];
  List get trainingToDate => _trainingToDate;

  void addValue() {
    _trainingTitleController.add(TextEditingController());
    _instituteNameController.add(TextEditingController());
    notifyListeners();
  }

  void addFromTime(value) {
    _trainingFromDate.add(value);
    notifyListeners();
  }

  void addToTime(value) {
    _trainingToDate.add(value);
    notifyListeners();
  }
}
