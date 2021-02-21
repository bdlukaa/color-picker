import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../lang/lang.dart';
import '../../dialogs.dart';
import '../../theme_manager.dart';

import 'settings_tile.dart';

class SettingsHome extends StatelessWidget {
  SettingsHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Language.of(context);
    final theme = ThemeManager.of(context, false);
    return ListView(
      padding: EdgeInsets.only(left: 25, top: 75),
      children: <Widget>[
        Text(
          lang.settings,
          textAlign: TextAlign.left,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 2),
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
          icon: ThemeDialog.getIconData(theme.mode),
          title: lang.theme,
          subtitle: lang.fromThemeMode(theme.mode),
          onTap: () => showDialog(
            context: context,
            builder: (_) => ThemeDialog(),
          ),
        ),
        SettingsTile(
          icon: FontAwesomeIcons.crosshairs,
          title: 'Indicator',
          onTap: () {
            // TODO: open indicator settings
          },
        ),
        Divider(),
        SettingsTitleTile(title: lang.about),
        SettingsTile(
          icon: Icons.eco,
          title: lang.author,
          subtitle: 'bdlukaa',
          onTap: () => launch('https://github.com/bdlukaa'),
        ),
        Wrap(
          spacing: 6,
          children: [
            ActionChip(
              avatar: Icon(Icons.source),
              label: Text(lang.openSource),
              backgroundColor: Colors.teal,
              onPressed: () =>
                  launch('https://github.com/bdlukaa/color-picker'),
            ),
            ActionChip(
              avatar: FlutterLogo(size: IconTheme.of(context).size ?? 24),
              label: Text(lang.madeWithFlutter),
              backgroundColor: Colors.blue,
              onPressed: () => launch('https://flutter.dev'),
            ),
          ],
        ),
      ],
    );
  }

  String firstUppecase(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(1).toLowerCase();
  }
}
