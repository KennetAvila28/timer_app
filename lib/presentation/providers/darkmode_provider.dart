import 'package:flutter/material.dart';

class DarkmodeProvider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;

  void changeMode() {
    mode = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
