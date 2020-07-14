import 'package:flutter/material.dart';

import '../main.dart';
import 'langs/en_lang.dart';
import 'langs/pt_lang.dart';

abstract class Language {

  static List<Language> get languages => [
    English(), Portuguese(),
  ];

  static Language of(BuildContext context) {
    Language lang;
    String locale = preferences.getString('language') ??
        Localizations.localeOf(context).languageCode;
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
    appBuilderKey.currentState.update();
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

  String get seeColorInfo;
  String get colorInfo;

  String get settings;
  String get user;
  String get app;
  String get initialColor;
  String get language;

  String get theme;
  String get dark;
  String get light;
  String get system;

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
