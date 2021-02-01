import 'package:flutter/material.dart';

import '../lang/lang.dart';

class MinHeight extends StatelessWidget {
  const MinHeight({
    Key key,
    @required this.minScreenHeight,
    @required this.child,
  }) : super(key: key);

  final double minScreenHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, consts) {
      /// 456 = min required height
      /// 64 = app bar height
      double requiredHeight = minScreenHeight - 64;
      if (consts.biggest.height <= requiredHeight) {
        final lang = Language.of(context);
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
          child: Text(
            lang.minHeight(minScreenHeight.toInt()),
            textAlign: TextAlign.center,
          ),
        );
      }
      return child;
    });
  }
}
