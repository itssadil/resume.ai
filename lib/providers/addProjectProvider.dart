import 'package:flutter/material.dart';

class AddProjectProvider with ChangeNotifier {
  final List<TextEditingController> _projectTitleController =
      List.generate(1, (index) => TextEditingController());
  List<TextEditingController> get projectTitleController =>
      _projectTitleController;

  final List<TextEditingController> _roleController =
      List.generate(1, (index) => TextEditingController());
  List<TextEditingController> get roleController => _roleController;

  final List<TextEditingController> _descriptionController =
      List.generate(1, (index) => TextEditingController());
  List<TextEditingController> get descriptionController =>
      _descriptionController;

  final List<DateTime> _projectFromDate = [];
  List get projectFromDate => _projectFromDate;

  final List<DateTime> _projectToDate = [];
  List get projectToDate => _projectToDate;

  void addValue() {
    _projectTitleController.add(TextEditingController());
    _roleController.add(TextEditingController());
    _descriptionController.add(TextEditingController());
    notifyListeners();
  }

  void addFromTime(value) {
    _projectFromDate.add(value);
    notifyListeners();
  }

  void addToTime(value) {
    _projectToDate.add(value);
    notifyListeners();
  }
}
