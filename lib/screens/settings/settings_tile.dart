import 'package:flutter/material.dart';

import '../../utils.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    Key key,
    @required this.icon,
    @required this.title,
    this.subtitle,
    this.onTap,
    this.subColor = false,
  }) : super(key: key);

  final IconData icon;
  final String title, subtitle;
  final bool subColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, textAlign: TextAlign.left),
      subtitle: subtitle != null
          ? Text(subtitle)
          : subColor
              ? Container(height: 10, color: initialColor)
              : null,
      leading: Icon(icon),
      trailing: Icon(Icons.navigate_next),
      onTap: onTap,
    );
  }
}

class SettingsTitleTile extends StatelessWidget {
  const SettingsTitleTile({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.left,
      style: Theme.of(context)
          .textTheme
          .headline6
          .copyWith(fontWeight: FontWeight.bold),
    );
  }
}
