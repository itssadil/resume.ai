import 'package:flutter/material.dart';

class AddLanguageProvider with ChangeNotifier {
  final List<TextEditingController> _languageController =
      List.generate(1, (index) => TextEditingController());
  List<TextEditingController> get languageController => _languageController;

  void addValue() {
    _languageController.add(TextEditingController());
    notifyListeners();
  }
}
