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
        return SingleChildScrollView(
          child: LimitedBox(
            maxHeight: initialHeight,
            child: child,
          ),
        );
      },
    );
  }
}
