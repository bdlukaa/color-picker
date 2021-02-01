import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'lang/lang.dart';
import 'widgets/button.dart';
import 'widgets/opacity_slider.dart';
import 'screens/color_info/color_info.dart';

import 'utils.dart';
import 'main.dart';
import 'theme_manager.dart';

showColorInfoDialog(
  BuildContext context,
  String title,
  Color color,
) =>
    showDialog(
      context: context,
      child: SimpleDialog(
        title: Center(child: Text(title)),
        contentPadding: EdgeInsets.only(top: 20),
        children: <Widget>[
          ColorInfo(
            color: color,
            // clipBehavior: Clip.none,
            background: Colors.transparent,
          )
        ],
      ),
    );

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeManager.of(context);
    final lang = Language.of(context);
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Center(
        child: Text(
          lang.theme,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      children: <Widget>[
        CheckboxListTile(
          value: theme.mode == ThemeMode.light,
          onChanged: (mode) {
            theme.mode = ThemeMode.light;
          },
          title: Text(lang.light),
        ),
        CheckboxListTile(
          value: theme.mode == ThemeMode.dark,
          onChanged: (mode) {
            theme.mode = ThemeMode.dark;
          },
          title: Text(lang.dark),
        ),
        CheckboxListTile(
          value: theme.mode == ThemeMode.system,
          onChanged: (mode) {
            theme.mode = ThemeMode.system;
          },
          title: Text(lang.system),
        ),
      ],
    );
  }
}

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({Key key}) : super(key: key);

  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  @override
  Widget build(BuildContext context) {
    Language lang = Language.of(context);
    Language.languages.sort((a, b) => a.code == lang.code ? 1 : -1);
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Center(
        child: Text(
          lang.language,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      children: List<Widget>.generate(Language.languages.length, (index) {
        Language l = Language.languages[index];
        return CheckboxListTile(
          value: Language.of(context).code == l.code,
          onChanged: (mode) async {
            await Language.set(context, l);
          },
          title: Text(l.langName),
        );
      }),
    );
  }
}

class InitialColorDialog extends StatelessWidget {
  const InitialColorDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Language.of(context);
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Center(
        child: Text(
          lang.initialColor,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      contentPadding: EdgeInsets.only(top: 20),
      children: <Widget>[RGBIntialColorChanger()],
    );
  }
}

class RGBIntialColorChanger extends StatefulWidget {
  RGBIntialColorChanger({Key key}) : super(key: key);

  @override
  _RGBIntialColorChangerState createState() => _RGBIntialColorChangerState();
}

class _RGBIntialColorChangerState extends State<RGBIntialColorChanger>
    with AutomaticKeepAliveClientMixin {
  double opacity = 1;
  int red, green, blue;

  Color color = initialColor;

  @override
  void initState() {
    super.initState();
    red = initialColor.red;
    green = initialColor.green;
    blue = initialColor.blue;
    opacity = initialColor.opacity;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Language lang = Language.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Field(
              value: red.toDouble(),
              onChanged: (value) => setState(() => red = value.toInt()),
              color: Colors.redAccent,
              label: lang.red,
            ),
            Field(
              value: green.toDouble(),
              onChanged: (value) => setState(() => green = value.toInt()),
              color: Colors.green,
              label: lang.green,
            ),
            Field(
              value: blue.toDouble(),
              onChanged: (value) => setState(() => blue = value.toInt()),
              color: Colors.blue,
              label: lang.blue,
            ),
          ],
        ),
        ColorInfo(
          clipBehavior: Clip.none,
          background: Colors.transparent,
          color: Color.fromARGB(
            255,
            red,
            green,
            blue,
          ).withOpacity(opacity),
          slider: OpacitySlider(
            onChanged: (value) => setState(() => opacity = value),
            value: opacity,
          ),
        ),
        Button(
          color: Colors.green,
          splashColor: Colors.lightGreenAccent,
          padding: EdgeInsets.all(10),
          text: Text(lang.update, style: TextStyle(color: Colors.white)),
          shadowEnabled: false,
          radius: BorderRadius.circular(25),
          onTap: () async {
            showToast(lang.initialColorUpdated, context: context);
            Navigator.pop(context);
            await preferences.setString(
              'initialColor',
              Color.fromARGB(
                255,
                red,
                green,
                blue,
              ).withOpacity(opacity).encoded,
            );
            AppBuilder.state.update();
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Field extends StatelessWidget {
  const Field({
    Key key,
    @required this.color,
    @required this.label,
    @required this.value,
    @required this.onChanged,
  }) : super(key: key);

  final Color color;
  final String label;
  final double value;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Slider(
            value: value,
            onChanged: onChanged,
            max: 255,
            min: 0,
            label: label,
            activeColor: color,
            inactiveColor: color.withOpacity(0.2),
          ),
        ),
        Text(
          value.toInt().toString(),
          style: DefaultTextStyle.of(context).style,
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
