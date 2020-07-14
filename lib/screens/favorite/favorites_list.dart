import 'package:color_picker/lang/lang.dart';
import 'package:flutter/material.dart';
import '../../db/favorite_colors.dart';

import 'favorite_tile.dart';

final favoritesKey = GlobalKey<AnimatedListState>();

class FavoritesList extends StatefulWidget {
  const FavoritesList({Key key}) : super(key: key);

  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    Language lang = Language.of(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(right: 25, left: 130, top: 75),
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 7),
              Text(
                lang.favoriteColorsTitle,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Spacer(),
              Icon(Icons.favorite, color: Colors.white),
            ],
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOutBack,
            height: FavoriteColors.colors.isNotEmpty ? 0 : null,
            padding: FavoriteColors.colors.isNotEmpty
                ? EdgeInsets.only(top: 35)
                : EdgeInsets.only(
                    /// 23% of the screen
                    /// minus title font size (22)
                    /// minus top padding (75)
                    /// minus text font size size (16)
                    top:
                        MediaQuery.of(context).size.height / 2.3 - 22 - 75 - 16,
                  ),
            alignment: Alignment.center,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: lang.haventFavoritedAnyBefore,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  children: [
                    // TextSpan(text: 'Press '),
                    WidgetSpan(
                        child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    )),
                    TextSpan(text: lang.haventFavoritedAnyAfter),
                  ]),
            ),
          ),
          AnimatedList(
            key: favoritesKey,
            padding: EdgeInsets.only(top: 15),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            initialItemCount: FavoriteColors.colors.length,
            itemBuilder: (context, index, animation) {
              var color = FavoriteColors.colors[index];
              bool isFavorite = FavoriteColors.hasColor(color);
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.elasticOut,
                )),
                child: FavoriteListTile(
                  color: color,
                  isFavorite: isFavorite,
                  animation: animation,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
