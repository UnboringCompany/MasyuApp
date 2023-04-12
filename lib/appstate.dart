import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  bool _isVibrationEnabled = true;

  bool get isVibrationEnabled => _isVibrationEnabled;

  set isVibrationEnabled(bool value) {
    _isVibrationEnabled = value;
    notifyListeners();
  }
}