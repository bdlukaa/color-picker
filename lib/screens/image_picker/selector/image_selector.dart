import 'package:flutter/material.dart';

import '../../../lang/lang.dart';

import 'local_selector.dart';
import 'network_selector.dart';

class ImageSelector extends StatelessWidget {
  ImageSelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double tabBarSize = 46;
    return LayoutBuilder(builder: (context, con) {
      final lang = Language.of(context);
      return SingleChildScrollView(
        child: DefaultTabController(
          length: 2,
          child: SizedBox(
            height: con.biggest.height,
            child: Column(
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
                      borderSide: BorderSide(color: Colors.blue[800]),
                    ),
                    labelColor: Colors.black,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  height: con.biggest.height - tabBarSize,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [LocalImageSelector(), NetworkImageSelector()],
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
