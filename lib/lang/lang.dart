import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils.dart';
import '../main.dart';

import 'langs/en_lang.dart';
import 'langs/pt_lang.dart';

abstract class Language {
  static List<Language> get languages => [English(), Portuguese()];

  static Language of(BuildContext context) {
    Language lang;
    // String locale = preferences.getString('language') ??
    //     Localizations.localeOf(context).languageCode;
    String locale = preferences.getString('language');
    if (context == null)
      locale = window.locale.languageCode;
    else
      locale ??= Localizations.localeOf(context).languageCode;
    switch (locale) {
      case 'pt':
        lang = Portuguese();
        break;
      case 'en':
        lang = English();
        break;
      default:
        lang = English();
    }
    return lang;
  }

  static Future<void> set(BuildContext context, Language code) async {
    await preferences.setString('language', code.code);
    AppBuilder.state.update();
  }

  String get code;
  String get langName;

  String get title;

  String get wheelPicker;
  String get palettePicker;
  String get valuePicker;
  String get namedPicker;
  String get imagePicker;

  String get red;
  String get green;
  String get blue;
  String get alpha;

  String get hexCode;
  String get hex;
  String get cssHex;
  String get clear;
  String get hexCodeMustNotBeEmpty;
  String get hexCodeLengthMustBeSix;
  String get hexCodeLimitedChars;
  String get hexCodeOpacity;

  String get hue;
  String get saturation;
  String get lightness;
  String get value;

  String get opacity;

  String get localImage;
  String get networkImage;
  String get selectPhoto;

  String get favoriteColorsTitle;
  String get haventFavoritedAnyBefore;
  String get haventFavoritedAnyAfter;
  String get favorite;
  String get unfavorite;
  String get favorited;
  String get unfavorited;

  String get copyToClipboard;
  Widget copiedToClipboard(String text);

  String supportedPlatforms(List<TargetPlatform> platforms);

  String get seeColorInfo;
  String get colorInfo;
  String colorWithOpacity(String name, int opacity);

  String get settings;
  String get user;
  String get app;
  String get initialColor;
  String get language;

  String get open;
  String get close;

  String get about;
  String get author;
  String get openSource;
  String get madeWithFlutter;

  String get theme;
  String get dark;
  String get light;
  String get system;

  String fromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return light;
      case ThemeMode.dark:
        return dark;
      case ThemeMode.system:
      default:
        return system;
    }
  }

  String minHeight(int height);

  String get update;
  String get initialColorUpdated;

  String get url;
  String get urlMustNotBeEmpty;
  String get search;

  String get redColor;
  String get pink;
  String get purple;
  String get deepPurple;
  String get indigo;
  String get blueColor;
  String get lightBlue;
  String get cyan;
  String get teal;
  String get grey;
  String get blueGrey;
  String get greenColor;
  String get lightGreen;
  String get lime;
  String get yellow;
  String get amber;
  String get orange;
  String get deepOrange;
  String get brown;
}
