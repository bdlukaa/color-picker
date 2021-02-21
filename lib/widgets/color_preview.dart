import 'package:flutter/material.dart';
import 'package:fl_toast/fl_toast.dart';

import '../lang/lang.dart';
import '../db/database_manager.dart' as db;

class ColorPreview extends StatefulWidget {
  ColorPreview({
    Key key,
    @required this.color,
    this.size = 45,
    this.favoriteEnabled = true,
    this.onCopyToClipboard,
  }) : super(key: key);

  final Color color;
  final double size;
  final bool favoriteEnabled;
  final Future Function() onCopyToClipboard;

  @override
  _ColorPreviewState createState() => _ColorPreviewState();
}

class _ColorPreviewState extends State<ColorPreview> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    bool isFavorite =
        db.FavoriteColors.hasColor(widget.color ?? Colors.transparent);
    final lang = Language.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // if copy is enabled
        if (widget.onCopyToClipboard != null)
          IconButton(
            icon: Icon(Icons.copy),
            tooltip: lang.copyToClipboard,
            splashRadius: 24,
            onPressed: () async {
              setState(() => _loading = true);
              await widget.onCopyToClipboard();
              setState(() => _loading = false);
            },
          ),
        Container(
          height: widget.size,
          width: widget.size,
          color: widget.color ?? Colors.grey[50],
          alignment: Alignment.center,
          child: () {
            final color = widget.color ?? Colors.grey[50];
            final iconColor =
                color.computeLuminance() < 0.5 ? Colors.white : Colors.black;
            if (widget.color == null)
              return Text('?');
            else if (_loading)
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(iconColor),
                  strokeWidth: 2,
                ),
              );
            else if (widget.favoriteEnabled)
              return IconButton(
                icon: AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey<bool>(isFavorite),
                    color: iconColor,
                  ),
                ),
                splashRadius: 24,
                splashColor: Colors.transparent,
                tooltip: isFavorite ? lang.unfavorite : lang.favorite,
                onPressed: () async {
                  await (isFavorite
                      ? db.unfavorite(widget.color)
                      : db.favorite(widget.color));
                  isFavorite = !isFavorite;
                  showTextToast(
                    text: isFavorite ? lang.favorited : lang.unfavorited,
                    context: context,
                  );
                },
              );
            else
              return null;
          }(),
        ),
      ],
    );
  }
}
