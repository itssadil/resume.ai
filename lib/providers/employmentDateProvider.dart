import 'package:flutter/material.dart';

class EmploymentDateProvider with ChangeNotifier {
  DateTime? _fromDate;
  DateTime? get fromDate => _fromDate;

  DateTime? _toDate;
  DateTime? get toDate => _toDate;

  void changeDate(bool isFromDate, pickedDate) {
    isFromDate ? _fromDate = pickedDate : _toDate = pickedDate;
    notifyListeners();
  }

  nullValue() {
    _fromDate = null;
    _toDate = null;
  }
}
