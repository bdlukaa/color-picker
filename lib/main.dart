import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_manager/window_manager.dart';

import './screens/root.dart';
import 'lang/lang.dart';
import 'db/database_manager.dart' as db;

import 'utils.dart' as utils;
import 'theme_manager.dart';

part 'app_builder.dart';

var _appBuilderKey = GlobalKey<AppBuilderState>();

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  utils.preferences = await SharedPreferences.getInstance();

  await db.startDatabase();
  await db.favorites();

  if (kIsWeb) setPathUrlStrategy();

  if (isDesktop) {
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle('hidden',
          windowButtonVisibility: false);
      await windowManager.setSize(const Size(755, 545));
      await windowManager.setMinimumSize(const Size(755, 545));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
            builder: (_, child) {
              child = ScrollConfiguration(
                child: ClipRect(child: child!),
                behavior: NoGlowBehavior(),
              );
              if (isDesktop) {
                return Scaffold(
                  body: Column(children: [
                    DragToMoveArea(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [Spacer(), WindowButtons()],
                      ),
                    ),
                    Expanded(
                      child: child,
                    ),
                  ]),
                );
              }
              return child;
            },
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
              Locale('pt', ''), // Portuguese, no country code
            ],
            home: const Root(),
          ),
        );
      },
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) =>
      child;
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      width: 138,
      height: 39,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
