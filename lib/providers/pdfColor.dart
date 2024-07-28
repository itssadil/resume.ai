import 'package:flutter/material.dart';

class PdfColorProvider with ChangeNotifier {
  Color _SelectedColor = Colors.cyanAccent;
  Color get SelectedColor => _SelectedColor;

  void changeColor(color) {
    _SelectedColor = color;
    notifyListeners();
  }
}
