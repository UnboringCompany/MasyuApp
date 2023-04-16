import 'package:flutter/material.dart';
import 'package:soundpool/soundpool.dart';

class AppState with ChangeNotifier {

  Soundpool pool = Soundpool.fromOptions();

  bool _isVibrationEnabled = true;
  bool _isSoundEnabled = true;

  int _victoireSound = -1;
  int _defaiteSound  = -1;


  bool get isVibrationEnabled => _isVibrationEnabled;
  bool get isSoundEnabled => _isSoundEnabled;
  int get victoireSound => _victoireSound;
  int get defaiteSound => _defaiteSound;

  set isVibrationEnabled(bool value) {
    _isVibrationEnabled = value;
    notifyListeners();
  }

  set isSoundEnabled(bool value) {
    _isSoundEnabled = value;
    notifyListeners();
  }

  void loadSound(pool, rootBundle) async {
    _victoireSound = await pool.load(await rootBundle.load('assets/sons/Victoire.m4a'));
    _defaiteSound = await pool.load(await rootBundle.load('assets/sons/Looser.m4a'));
  }

  void playSound(int soundId) async {
    await pool.play(soundId);
  }
}