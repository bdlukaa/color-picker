import 'package:color_picker/lang/lang.dart';
import 'package:flutter/material.dart';

import 'local_selector.dart';
import 'network_selector.dart';

class ImageSelector extends StatefulWidget {
  ImageSelector({
    Key key,
  }) : super(key: key);


  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  @override
  Widget build(BuildContext context) {
    double tabBarSize = 46;
    return LayoutBuilder(builder: (context, con) {
      Language lang = Language.of(context);
      return SingleChildScrollView(
        child: DefaultTabController(
          length: 2,
          child: SizedBox(
            height: con.biggest.height,
            child: Column(
              // avoid keyboard bottom overflow
              // physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                LimitedBox(
                  maxHeight: tabBarSize,
                  child: TabBar(
                    tabs: <Widget>[
                      Tab(text: lang.localImage),
                      Tab(text: lang.networkImage),
                    ],
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(color: Colors.blue[800])),
                    labelColor: Colors.black,
                  ),
                ),
                SizedBox(
                  height: con.biggest.height - tabBarSize,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      LocalImageSelector(),
                      NetworkImageSelector(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
