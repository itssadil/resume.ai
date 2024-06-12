import 'package:flutter/material.dart';

class ProfileLinkProvider with ChangeNotifier {
  List<TextEditingController> _controllers =
      List.generate(1, (index) => TextEditingController());
  List<TextEditingController> get urlControllers => _controllers;

  List<TextEditingController> _controllersName =
      List.generate(1, (index) => TextEditingController());
  List<TextEditingController> get urlNameControllers => _controllersName;

  void addProfile() {
    _controllers.add(TextEditingController());
    _controllersName.add(TextEditingController());
    notifyListeners();
  }
}
