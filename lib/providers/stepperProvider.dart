import 'package:flutter/material.dart';

class StepperProvider with ChangeNotifier {
  int _currentStep = 5;
  int get currentStep => _currentStep;

  void continueStep() {
    _currentStep += 1;
    notifyListeners();
  }

  void cancelStep() {
    _currentStep -= 1;
    notifyListeners();
  }
}
