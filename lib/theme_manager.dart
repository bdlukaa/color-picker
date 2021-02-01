import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utils.dart';

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

  static ThemeManager of(BuildContext context, [bool listen = true]) =>
      Provider.of<ThemeManager>(context, listen: listen);

  static bool isBright(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light;

  static ThemeData def([Color primarySwatch]) => ThemeData(
        primarySwatch: primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
        ),
        sliderTheme: SliderThemeData(
          valueIndicatorTextStyle: TextStyle(color: Colors.white),
          showValueIndicator: ShowValueIndicator.always,
        ),
      );

  static ThemeData get lightTheme => def(Colors.orange).copyWith(
        scaffoldBackgroundColor: Colors.orange,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        tabBarTheme: TabBarTheme(
          indicatorSize: TabBarIndicatorSize.label,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.blue[800]),
          ),
          labelColor: Colors.white,
        ),
      );
  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[850],
        appBarTheme: AppBarTheme(color: Colors.grey[850]),
        tabBarTheme: TabBarTheme(
          indicatorSize: TabBarIndicatorSize.label,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.white),
          ),
          labelColor: Colors.white,
        ),
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
}
