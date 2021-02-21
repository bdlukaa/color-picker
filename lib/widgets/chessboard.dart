import 'package:flutter/material.dart';

import '../theme_manager.dart';

class ChessBoard extends StatelessWidget {
  const ChessBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) => Wrap(children: () {
        bool bright = true;
        final double squareSize = 10.0;
        final inAColumn = size.biggest.height ~/ squareSize;
        final inARow = size.biggest.width ~/ squareSize;
        final indexes = List.generate(inAColumn, (i) => inARow * (i + 1));
        return List.generate(
          inAColumn * inARow,
          (index) {
            if (!indexes.contains(index)) bright = !bright;
            return Container(
              color: () {
                if (ThemeManager.isBright(context)) {
                  return bright ? Colors.white : Colors.grey[600];
                } else {
                  return bright ? Colors.grey : Colors.grey[900];
                }
              }(),
              height: squareSize,
              width: squareSize,
            );
          },
        );
      }()),
    );
  }
}
