import 'package:flutter/material.dart';

import '../../widgets/minHeight.dart';

import 'rgb_value_picker.dart';
import 'hex_value_picker.dart';
import 'hsl_value_picker.dart';
import 'hsv_value_picker.dart';
import 'lab_value_picker.dart';

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
    return MinHeight(
      minScreenHeight: 465,
      child: DefaultTabController(
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
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  RGBValuePicker(),
                  HEXValuePicker(),
                  HSLValuePicker(),
                  HSVValuePicker(),
                  // XYZValuePicker(),
                  LABValuePicker(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
