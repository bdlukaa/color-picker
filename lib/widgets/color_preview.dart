import 'package:color_picker/lang/lang.dart';
import 'package:flutter/material.dart';
import '../db/database_manager.dart' as db;
import '../db/favorite_colors.dart';

class ColorPreview extends StatefulWidget {
  ColorPreview({
    Key key,
    @required this.color,
    this.size = 45,
    this.favoriteEnabled = true,
  }) : super(key: key);

  final Color color;
  final double size;
  final bool favoriteEnabled;

  @override
  _ColorPreviewState createState() => _ColorPreviewState();
}

class _ColorPreviewState extends State<ColorPreview> {
  @override
  Widget build(BuildContext context) {
    bool isFavorite = FavoriteColors.hasColor(widget.color ?? Colors.transparent);
    Language lang = Language.of(context);
    return Container(
      // constraints: BoxConstraints.expand(height: widget.size),
      height: widget.size,
      width: widget.size,
      color: widget.color ?? Colors.grey[50],
      child: widget.color == null
          ? Center(child: Text('?'))
          : widget.favoriteEnabled
              ? IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.redAccent : Colors.grey,
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
    );
  }
}
