import 'package:flutter/material.dart';

import 'rgb_value_picker.dart';
import 'hex_value_picker.dart';
import 'hsl_value_picker.dart';
import 'hsv_value_picker.dart';
import 'xyz_value_picker.dart';
import 'lab_value_picker.dart';

double initialHeight;

class ValueHome extends StatefulWidget {
  ValueHome({Key key}) : super(key: key);

  @override
  _ValueHomeState createState() => _ValueHomeState();
}

class _ValueHomeState extends State<ValueHome>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: TabBar(
          isScrollable: true,
          tabs: <Widget>[
            Tab(text: 'RGB'),
            Tab(text: 'HEX'),
            Tab(text: 'HSL'),
            Tab(text: 'HSV'),
            // Tab(text: 'XYZ'),
            Tab(text: 'Lab'),
          ],
          indicatorSize: TabBarIndicatorSize.label,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.blue[800])),
          labelColor: Colors.black,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.black),
            child: LayoutBuilder(
              builder: (context, consts) {
                if (initialHeight == null || consts.biggest.height > initialHeight)
                    initialHeight = consts.biggest.height;
                return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    RGBValuePicker(),
                    HEXValuePicker(),
                    HSLValuePicker(),
                    HSVValuePicker(),
                    // XYZValuePicker(),
                    LABValuePicker(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
