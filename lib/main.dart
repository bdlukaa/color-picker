import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import './screens/root.dart';
import 'lang/lang.dart';
import 'db/database_manager.dart' as db;

import 'utils.dart' as utils;
import 'theme_manager.dart';

part 'app_builder.dart';

var _appBuilderKey = GlobalKey<AppBuilderState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  utils.preferences = await SharedPreferences.getInstance();

  await db.startDatabase();
  await db.favorites();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeManager>(
      create: (_) => ThemeManager(
        utils.preferences.getString('theme') ?? ThemeMode.system.toString(),
      ),
      builder: (context, child) {
        final theme = ThemeManager.of(context);
        return AppBuilder(
          key: _appBuilderKey,
          child: MaterialApp(
            onGenerateTitle: (_) => Language.of(null).title,
            debugShowCheckedModeBanner: false,
            themeMode: theme.mode,
            darkTheme: ThemeManager.darkTheme,
            theme: ThemeManager.lightTheme,
            builder: (_, child) => ScrollConfiguration(
              child: child,
              behavior: NoGlowBehavior(),
            ),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''), // English, no country code
              const Locale('pt', ''), // Portuguese, no country code
            ],
            home: Root(),
          ),
        );
      },
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) =>
      child;
}
