import 'package:color_picker/lang/lang.dart';
import 'package:flutter/material.dart';

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
  final Function onCopyToClipboard;

  @override
  _ColorPreviewState createState() => _ColorPreviewState();
}

class _ColorPreviewState extends State<ColorPreview> {
  @override
  Widget build(BuildContext context) {
    final isFavorite =
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
            onPressed: widget.onCopyToClipboard,
          ),
        Container(
          height: widget.size,
          width: widget.size,
          color: widget.color ?? Colors.grey[50],
          alignment: Alignment.center,
          child: widget.color == null
              ? Text('?')
              : widget.favoriteEnabled
                  ? IconButton(
                      icon: AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          key: ValueKey<bool>(isFavorite),
                          color: Colors.redAccent,
                        ),
                      ),
                      tooltip: isFavorite ? lang.unfavorite : lang.favorite,
                      splashColor: Colors.transparent,
                      onPressed: () async {
                        await (isFavorite
                            ? db.unfavorite(widget.color)
                            : db.favorite(widget.color));
                        setState(() {});
                      },
                    )
                  : null,
        ),
      ],
    );
  }
}
