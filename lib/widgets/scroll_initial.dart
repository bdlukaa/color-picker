import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScrollInitial extends StatelessWidget {
  ScrollInitial({
    Key key,
    @required this.child,
    this.initialHeight,
  }) : super(key: key);

  double initialHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, consts) {
        if (initialHeight == null || consts.biggest.height > initialHeight)
          initialHeight = consts.biggest.height;
        // print(initialHeight);
        // print(consts.biggest.height);
        // print(consts.biggest.longestSide);
        return SingleChildScrollView(
          child: LimitedBox(
            maxHeight: consts.biggest.longestSide +
                (MediaQuery.of(context).orientation == Orientation.landscape
                    ? consts.biggest.height
                    : 0),
            // minHeight: consts.biggest.height,
            child: child,
          ),
        );
      },
    );
  }
}
