import 'package:flutter/material.dart';

class AddEducationProvider with ChangeNotifier {
  final List<TextEditingController> _studyTitleController =
      List.generate(1, (index) => TextEditingController());
  List<TextEditingController> get studyTitleController => _studyTitleController;

  final List<TextEditingController> _universityNameController =
      List.generate(1, (index) => TextEditingController());
  List<TextEditingController> get universityNameController =>
      _universityNameController;

  final List<DateTime> _studyFromDate = [];
  List get studyFromDate => _studyFromDate;

  final List<DateTime> _studyToDate = [];
  List get studyToDate => _studyToDate;

  void addValue() {
    _studyTitleController.add(TextEditingController());
    _universityNameController.add(TextEditingController());
    notifyListeners();
  }

  void addFromTime(value) {
    _studyFromDate.add(value);
    notifyListeners();
  }

  void addToTime(value) {
    _studyToDate.add(value);
    notifyListeners();
  }
}
