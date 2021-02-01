import 'package:flutter/material.dart';
import 'package:color/color.dart' hide Color;

import 'package:color_picker/widgets/opacity_slider.dart';

import '../../theme_manager.dart';
import '../../lang/lang.dart';

import '../../widgets/opacity_slider.dart';
import '../../widgets/color_preview.dart';

part 'cielab_color_info.dart';
part 'hex_color_info.dart';
part 'hsl_color_info.dart';
part 'hsv_color_info.dart';
part 'rgb_color_info.dart';
part 'xyz_color_info.dart';

class ColorInfo extends StatelessWidget {
  const ColorInfo({
    Key key,
    @required this.color,
    this.initial = 0,
    this.clipBehavior = Clip.antiAlias,
    this.slider,
    this.background,
  }) : super(key: key);

  final Color color;
  final Color background;
  final int initial;
  final OpacitySlider slider;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: clipBehavior,
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      child: Container(
        color: background ??
            (ThemeManager.isBright(context)
                ? Colors.grey[100]
                : Colors.grey[850]),
        child: DefaultTabController(
          length: 6,
          initialIndex: initial ?? 0,
          child: Column(
            children: <Widget>[
              Container(
                height: 46,
                child: TabBar(
                  isScrollable: true,
                  tabs: <Widget>[
                    Tab(text: 'RGB'),
                    Tab(text: 'HEX'),
                    Tab(text: 'HSL'),
                    Tab(text: 'HSV'),
                    Tab(text: 'XYZ'),
                    Tab(text: 'Lab'),
                  ],
                  // indicatorColor: Colors.blue[800],
                  // indicatorSize: TabBarIndicatorSize.label,
                  labelColor: ThemeManager.isBright(context)
                      ? Colors.black
                      : Colors.white,
                ),
              ),
              LimitedBox(
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: 80,
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: ThemeManager.isBright(context)
                        ? Colors.black
                        : Colors.white,
                  ),
                  child: TabBarView(
                    children: <Widget>[
                      RGBColorInfo(color: color),
                      HEXColorInfo(color: color),
                      HSLColorInfo(color: color),
                      HSVColorInfo(color: color),
                      XYZColorInfo(color: color),
                      CielabColorInfo(color: color),
                    ],
                  ),
                ),
              ),
              if (slider != null) slider
            ],
          ),
        ),
      ),
    );
  }
}

class ColorName extends StatelessWidget {
  const ColorName({
    Key key,
    @required this.text,
    @required this.value,
    @required this.color,
  }) : super(key: key);

  final String text;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        children: [TextSpan(text: value, style: TextStyle(color: color))],
        style: DefaultTextStyle.of(context).style,
      ),
    );
  }
}
