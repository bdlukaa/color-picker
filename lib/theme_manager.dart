import 'package:flutter/material.dart';

import 'main.dart';

class ThemeManager extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;
  set mode(ThemeMode mode) {
    if (_mode != mode) {
      _mode = mode;
      notifyListeners();
      preferences.setString('theme', mode.toString());
    }
  }

  void notify() => notifyListeners();

  ThemeManager(String theme) {
    if (theme == 'ThemeMode.system') _mode = ThemeMode.system;
    if (theme == 'ThemeMode.dark') _mode = ThemeMode.dark;
    if (theme == 'ThemeMode.light') _mode = ThemeMode.light;
  }
  static bool isBright(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light;
}
