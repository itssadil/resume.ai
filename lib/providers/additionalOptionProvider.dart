import 'package:flutter/material.dart';

class AdditionalOptionProvider with ChangeNotifier {
  bool _isAddValue = false;
  bool get isAddValue => _isAddValue;

  void isAdd(bool value) {
    _isAddValue = value;
    notifyListeners();
  }
}
