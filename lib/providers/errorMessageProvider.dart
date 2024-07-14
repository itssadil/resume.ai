import 'package:flutter/material.dart';

class ErrorMessageProvider with ChangeNotifier {
  bool _name = false;
  bool get name => _name;
  bool _phone = false;
  bool get phone => _phone;
  bool _address = false;
  bool get address => _address;
  bool _skills = false;
  bool get skills => _skills;
  bool _educaionTitle = false;
  bool get educaionTitle => _educaionTitle;
  bool _institute = false;
  bool get institute => _institute;

  void isName(bool value) {
    _name = value;
    notifyListeners();
  }

  void isPhone(bool value) {
    _phone = value;
    notifyListeners();
  }

  void isAddress(bool value) {
    _address = value;
    notifyListeners();
  }

  void isSkills(bool value) {
    _skills = value;
    notifyListeners();
  }

  void isEducaionTitle(bool value) {
    _educaionTitle = value;
    notifyListeners();
  }

  void isInstitute(bool value) {
    _institute = value;
    notifyListeners();
  }
}
