import 'package:color_picker/screens/color_info/rgb_color_info.dart';
import 'package:color_picker/screens/color_info/xyz_color_info.dart';
import 'package:color_picker/widgets/opacity_slider.dart';
import 'package:flutter/material.dart';

import '../../theme_manager.dart';
import 'cielab_color_info.dart';
import 'hex_color_info.dart';
import 'hsl_color_info.dart';
import 'hsv_color_info.dart';

class ColorInfo extends StatelessWidget {
  const ColorInfo({
    Key key,
    @required this.color,
    this.initial = 0,
    this.clip = true,
    this.slider,
    this.background,
  }) : super(key: key);

  final Color color;
  final Color background;
  final int initial;
  final OpacitySlider slider;
  final bool clip;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: !(clip ?? true)
          ? BorderRadius.zero
          : BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
      child: Container(
        color: background != null
            ? background
            : ThemeManager.isBright(context)
                ? Colors.grey[100]
                : Colors.grey[850],
        width: MediaQuery.of(context).size.width,
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
              slider ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}
