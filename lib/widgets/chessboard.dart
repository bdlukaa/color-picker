import 'package:flutter/material.dart';

import '../theme_manager.dart';

class ChessBoard extends StatelessWidget {
  const ChessBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) => Wrap(
        children: () {
          bool bright = true;
          final double squareSize = 10;
          final width = size.biggest.width;
          final inARow = width ~/ squareSize;
          return List.generate(
            (size.biggest.height ~/ squareSize) * inARow,
            (index) {
              if (!List.generate(size.biggest.height ~/ squareSize,
                  (i) => inARow * (i + 1)).contains(index)) {
                bright = !bright;
              }
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
        }(),
      ),
    );
  }
}
