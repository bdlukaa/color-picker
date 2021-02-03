import 'package:flutter/material.dart';

import '../../lang/lang.dart';
import '../../db/database_manager.dart';
import 'favorite_tile.dart';

final favoritesKey = GlobalKey<AnimatedListState>();

class FavoritesList extends StatelessWidget {
  const FavoritesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Language.of(context);
    return Container(
      color: Colors.blueGrey,
      padding: EdgeInsets.only(right: 25, top: 75),
      child: Column(
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
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 1),
                    end: Offset(0, 0),
                  ).animate(animation),
                  child: child,
                );
              },
              child: FavoriteColors.colors.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 42),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: lang.haventFavoritedAnyBefore,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(text: lang.haventFavoritedAnyAfter),
                          ],
                        ),
                      ),
                    )
                  : AnimatedList(
                      key: favoritesKey,
                      // shrinkWrap: true,
                      initialItemCount: FavoriteColors.colors.length,
                      itemBuilder: (context, index, animation) {
                        var color = FavoriteColors.colors[index];
                        bool isFavorite = FavoriteColors.hasColor(color);
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FavoriteListTile(
                            color: color,
                            isFavorite: isFavorite,
                            animation: animation,
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
