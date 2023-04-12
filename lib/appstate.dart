import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  bool _isVibrationEnabled = true;
  bool _isSoundEnabled = true;

  bool get isVibrationEnabled => _isVibrationEnabled;
  bool get isSoundEnabled => _isSoundEnabled;

  set isVibrationEnabled(bool value) {
    _isVibrationEnabled = value;
    notifyListeners();
  }

  set isSoundEnabled(bool value) {
    _isSoundEnabled = value;
    notifyListeners();
  }
}