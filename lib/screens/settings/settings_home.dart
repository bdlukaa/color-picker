import 'package:color_picker/lang/lang.dart';
import 'package:color_picker/screens/settings/settings_tile.dart';
import 'package:flutter/material.dart';

import '../../dialogs.dart';
import '../../theme_manager.dart';

class SettingsHome extends StatelessWidget {
  SettingsHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Language.of(context);
    return Scaffold(
      backgroundColor: ThemeManager.isBright(context) ? Colors.white : null,
      body: Builder(
        builder: (context) {
          return ListView(
            padding: EdgeInsets.only(left: 25, top: 75),
            children: <Widget>[
              Row(
                children: [
                  Text(
                    lang.settings,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(Icons.settings),
                ],
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
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => LanguageDialog(),
                ),
              ),
              SettingsTile(
                icon: Icons.settings_brightness,
                title: lang.theme,
                subtitle: lang.fromThemeMode(
                  ThemeManager.of(context, false).mode,
                ),
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => ThemeDialog(),
                ),
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
