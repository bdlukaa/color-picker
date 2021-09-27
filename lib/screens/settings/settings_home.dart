import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/link.dart';

import '../../lang/lang.dart';
import '../../dialogs.dart';
import '../../theme_manager.dart';

import 'settings_tile.dart';

class SettingsHome extends StatelessWidget {
  const SettingsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Language.of(context);
    final theme = ThemeManager.of(context, false);
    return ListView(
      padding: const EdgeInsets.only(left: 25, top: 75),
      children: <Widget>[
        Text(
          lang.settings,
          textAlign: TextAlign.left,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        SettingsTitleTile(title: lang.user),
        SettingsTile(
          icon: Icons.format_color_fill,
          title: lang.initialColor,
          subColor: true,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => const InitialColorDialog(),
            );
          },
        ),
        const Divider(),
        SettingsTitleTile(title: lang.app),
        SettingsTile(
          icon: Icons.language,
          title: lang.language,
          subtitle: lang.langName,
          onTap: () => showDialog(
            context: context,
            builder: (context) => const LanguageDialog(),
          ),
        ),
        SettingsTile(
          icon: ThemeDialog.getIconData(theme.mode),
          title: lang.theme,
          subtitle: lang.fromThemeMode(theme.mode),
          onTap: () => showDialog(
            context: context,
            builder: (_) => const ThemeDialog(),
          ),
        ),
        SettingsTile(
          icon: FontAwesomeIcons.crosshairs,
          title: 'Indicator',
          onTap: () {
            // TODO: open indicator settings
          },
        ),
        const Divider(),
        SettingsTitleTile(title: lang.about),
        Link(
          uri: Uri.parse('https://github.com/bdlukaa'),
          builder: (context, followLink) => SettingsTile(
            icon: FontAwesomeIcons.at,
            title: lang.author,
            subtitle: 'bdlukaa',
            onTap: followLink,
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(spacing: 6, children: [
          Link(
            uri: Uri.parse('https://github.com/bdlukaa/color-picker'),
            builder: (context, followLink) => ActionChip(
              avatar: const Icon(Icons.source, size: 18.0),
              label: Text(lang.openSource),
              backgroundColor: Colors.teal,
              onPressed: () => followLink?.call(),
            ),
          ),
          Link(
            uri: Uri.parse('https://flutter.dev'),
            builder: (context, followLink) => ActionChip(
              avatar: const FlutterLogo(size: 18.0),
              label: Text(lang.madeWithFlutter),
              backgroundColor: Colors.blue,
              onPressed: () => followLink?.call(),
            ),
          ),
        ]),
      ],
    );
  }

  String firstUppecase(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(1).toLowerCase();
  }
}
