import 'package:color_picker/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/root.dart';
import 'package:provider/provider.dart';
import 'utils.dart' as utils;

var appBuilderKey = GlobalKey<AppBuilderState>();

SharedPreferences preferences;

Color initialColor;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  preferences = await SharedPreferences.getInstance();
  String iColorMap = preferences.getString('initialColor');

  initialColor = utils.initialColor(iColorMap);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeManager>(
      builder: (context) =>
          ThemeManager(preferences.getString('theme') ?? 'ThemeMode.system'),
      child: Consumer<ThemeManager>(
        builder: (context, theme, child) {
          return AppBuilder(
            key: appBuilderKey,
            child: MaterialApp(
              title: 'Color picker',
              debugShowCheckedModeBanner: false,
              themeMode: theme.mode,
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                scaffoldBackgroundColor: Colors.grey[850],
                appBarTheme: AppBarTheme(color: Colors.grey[850]),
                tabBarTheme: TabBarTheme(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: Colors.white)),
                  labelColor: Colors.white,
                ),
                sliderTheme: SliderThemeData(
                  valueIndicatorTextStyle: TextStyle(color: Colors.white),
                  showValueIndicator: ShowValueIndicator.always,
                ),
                tooltipTheme: TooltipThemeData(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              theme: ThemeData(
                primarySwatch: Colors.orange,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                scaffoldBackgroundColor: Colors.orange,
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                sliderTheme: SliderThemeData(
                  valueIndicatorTextStyle: TextStyle(color: Colors.white),
                  showValueIndicator: ShowValueIndicator.always,
                ),
                tabBarTheme: TabBarTheme(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: Colors.blue[800])),
                  labelColor: Colors.white,
                ),
                textTheme: TextTheme(
                  headline6: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.black),
                  headline5: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black),
                ),
              ),
              builder: (context, child) {
                return ScrollConfiguration(
                  child: child,
                  behavior: NoGlowBehavior(),
                );
              },
              localizationsDelegates: [
                // ... app-specific localization delegate[s] here
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
      ),
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

class AppBuilder extends StatefulWidget {
  AppBuilder({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  AppBuilderState createState() => AppBuilderState();
}

class AppBuilderState extends State<AppBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void update() => Provider.of<ThemeManager>(context).notify();
}
