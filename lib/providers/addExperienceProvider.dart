import 'package:flutter/material.dart';

class AddExperienceProvider with ChangeNotifier {
  final List<TextEditingController> _jobTitleController =
      List.generate(1, (index) => TextEditingController());
  List<TextEditingController> get jobTitleController => _jobTitleController;

  final List<TextEditingController> _companyNameController =
      List.generate(1, (index) => TextEditingController());
  List<TextEditingController> get companyNameController =>
      _companyNameController;

  final List<TextEditingController> _locationController =
      List.generate(1, (index) => TextEditingController());
  List<TextEditingController> get locationController => _locationController;

  final List<DateTime> _employmentFromDate = [];
  List get employmentFromDate => _employmentFromDate;

  final List<DateTime> _employmentToDate = [];
  List get employmentToDate => _employmentToDate;

  void addValue() {
    _jobTitleController.add(TextEditingController());
    _companyNameController.add(TextEditingController());
    _locationController.add(TextEditingController());
    notifyListeners();
  }

  void addFromTime(value) {
    _employmentFromDate.add(value);
    notifyListeners();
  }

  void addToTime(value) {
    _employmentToDate.add(value);
    notifyListeners();
  }
}
