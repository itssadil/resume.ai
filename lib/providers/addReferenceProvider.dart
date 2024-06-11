import 'package:flutter/material.dart';

class AddReferenceProvider with ChangeNotifier {
  final List<TextEditingController> _referenceOptionController =
      List.generate(1, (index) => TextEditingController());
  List<TextEditingController> get referenceOptionController =>
      _referenceOptionController;

  final List<TextEditingController> _referenceController =
      List.generate(1, (index) => TextEditingController());
  List<TextEditingController> get referenceController => _referenceController;

  final List<DateTime> _trainingFromDate = [];
  List get trainingFromDate => _trainingFromDate;

  final List<DateTime> _trainingToDate = [];
  List get trainingToDate => _trainingToDate;

  void addValue() {
    _referenceOptionController.add(TextEditingController());
    _referenceController.add(TextEditingController());
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
