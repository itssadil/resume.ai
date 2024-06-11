import 'package:flutter/material.dart';

class AdditionalStepperProvider with ChangeNotifier {
  int _currentStep = 0;
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
