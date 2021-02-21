import 'package:flutter/material.dart';

import '../../lang/lang.dart';
import '../../db/database_manager.dart' as db;
import '../color_info/color_info.dart';

class FavoriteListTile extends StatelessWidget {
  FavoriteListTile({
    Key key,
    @required this.isFavorite,
    @required this.color,
    @required this.animation,
  }) : super(key: key);

  final bool isFavorite;
  final Color color;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final lang = Language.of(context);
    return Container(
      margin: EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.redAccent : Colors.grey,
            ),
            tooltip: isFavorite ? lang.unfavorite : lang.favorite,
            splashColor: Colors.transparent,
            onPressed: () async {
              // await _controller.forward();
              await (isFavorite ? db.unfavorite(color) : db.favorite(color));
            },
          ),
          Expanded(
            child: Container(height: 45, color: color),
          ),
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            tooltip: lang.seeColorInfo,
            onPressed: () =>
                showColorInfoDialog(context, lang.colorInfo, color),
          ),
        ],
      ),
    );
  }
}
