import 'package:color_picker/lang/lang.dart';
import 'package:flutter/material.dart';

class English extends Language {
  String get code => 'en';
  String get langName => 'English';

  String get title => 'Color picker';

  String get wheelPicker => 'Wheel';
  String get palettePicker => 'Palette';
  String get valuePicker => 'Value';
  String get namedPicker => 'Named';
  String get imagePicker => 'Image';

  String get red => 'Red';
  String get green => 'Green';
  String get blue => 'Blue';
  String get alpha => 'Alpha';

  String get hexCode => 'Hexadecimal code';
  String get hex => 'Hexadecimal';
  String get cssHex => 'CSS Hexadecimal';
  String get clear => 'Clear';
  String get hexCodeMustNotBeEmpty => 'Hex code must not be empty';
  String get hexCodeLengthMustBeSix => 'Hex code length must be 6';
  String get hexCodeLimitedChars =>
      'Hex code must only have 0-9 and A-F characters';
  String get hexCodeOpacity =>
      'Tip: hex opacity code is computed by the slider below';

  String get hue => 'Hue';
  String get saturation => 'Saturation';
  String get lightness => 'Lightness';
  String get value => 'Value';

  String get opacity => 'Opacity';

  String get localImage => 'Local image';
  String get networkImage => 'Network image';
  String get selectPhoto => 'Select photo';

  String get favoriteColorsTitle => 'Favorite colors';
  String get haventFavoritedAnyBefore =>
      'You haven\'t favorited any color yet!\nPress ';
  String get haventFavoritedAnyAfter =>
      ' in a color preview to favorite a color';
  String get favorite => 'Favorite';
  String get unfavorite => 'Unfavorite';
  String get favorited => 'Favorited';
  String get unfavorited => 'Unfavorited';

  String get copyToClipboard => 'Copy to clipboard';
  Widget copiedToClipboard(String text) {
    return RichText(
      text: TextSpan(
        text: 'Copied ',
        children: [
          TextSpan(text: text, style: TextStyle(color: Colors.blue)),
          TextSpan(text: ' to clipboard'),
        ],
      ),
    );
  }

  String supportedPlatforms(List<TargetPlatform> platforms) {
    String text = 'This feature is not avaiable on your OS';
    return text;
  }

  String get seeColorInfo => 'See color info';
  String get colorInfo => 'Color info';
  String colorWithOpacity(String name, int opacity) =>
      '$name with $opacity% of opacity';

  String get settings => 'Settings';
  String get user => 'User';
  String get app => 'App';
  String get initialColor => 'Initial color';
  String get language => 'Language';

  String get open => 'Open';
  String get close => 'Close';

  String get about => 'About';
  String get author => 'Author';
  String get openSource => 'Open source';
  String get madeWithFlutter => 'Made with Flutter 💙';

  String get theme => 'Theme';
  String get dark => 'Dark';
  String get light => 'Light';
  String get system => 'System (default)';

  String minHeight(int height) =>
      'This is only avaiable on devices with a screen higher than $height pixels';

  String get update => 'Update';
  String get initialColorUpdated => 'Initial color updated';

  String get url => 'Url';
  String get urlMustNotBeEmpty => 'Url must not be empty';
  String get search => 'Search';

  String get redColor => 'Red';
  String get pink => 'Pink';
  String get purple => 'Purple';
  String get deepPurple => 'Deep purple';
  String get indigo => 'Indigo';
  String get blueColor => 'Blue';
  String get lightBlue => 'Light blue';
  String get cyan => 'Cyan';
  String get teal => 'Teal';
  String get grey => 'Grey';
  String get blueGrey => 'Blue grey';
  String get greenColor => 'Green';
  String get lightGreen => 'Light green';
  String get lime => 'Lime';
  String get yellow => 'Yellow';
  String get amber => 'Amber';
  String get orange => 'Orange';
  String get deepOrange => 'Deep orange';
  String get brown => 'Brown';
}
