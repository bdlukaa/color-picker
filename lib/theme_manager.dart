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
        sliderTheme: SliderThemeData(
          valueIndicatorTextStyle: TextStyle(color: Colors.white),
          showValueIndicator: ShowValueIndicator.always,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
        ),
      );

  static ThemeData get lightTheme => def(Colors.orange).copyWith(
        scaffoldBackgroundColor: Colors.orange,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          centerTitle: true,
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
        accentColor: Colors.white,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          color: Colors.grey[900],
          elevation: 0,
          centerTitle: true,
        ),
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
