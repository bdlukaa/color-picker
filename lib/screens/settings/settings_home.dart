import 'package:color_picker/lang/lang.dart';
import 'package:color_picker/screens/settings/settings_tile.dart';
import 'package:color_picker/widgets/zoomed_scaffold.dart';
import 'package:flutter/material.dart';

import '../../dialogs.dart';
import '../../theme_manager.dart';

class SettingsHome extends StatefulWidget {
  SettingsHome({Key key, @required this.controller}) : super(key: key);

  final MenuController controller;

  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  @override
  Widget build(BuildContext context) {
    Language lang = Language.of(context);
    return Scaffold(
      backgroundColor: ThemeManager.isBright(context) ? Colors.white : null,
      body: Builder(
        builder: (context) {
          return ListView(
            padding: EdgeInsets.only(left: 25, right: 125, top: 75),
            children: <Widget>[
              Text(
                lang.settings,
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Divider(),
              SettingsTitleTile(title: lang.user),
              SettingsTile(
                icon: Icons.format_color_fill,
                title: lang.initialColor,
                subColor: true,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => InitialColorDialog(),
                  );
                },
              ),
              Divider(),
              SettingsTitleTile(title: lang.app),
              SettingsTile(
                icon: Icons.language,
                title: lang.language,
                subtitle: lang.langName,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => LanguageDialog(),
                  );
                },
              ),
              SettingsTile(
                icon: Icons.settings_brightness,
                title: lang.theme,
                subtitle: ThemeManager.isBright(context) ? lang.light : lang.dark,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => ThemeDialog(),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  String firstUppecase(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(1).toLowerCase();
  }
}
