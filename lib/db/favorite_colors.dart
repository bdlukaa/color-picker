part of 'database_manager.dart';

class FavoriteColors {
  static List<Color> colors = [];

  static bool hasColor(Color color) {
    for (Color c in colors)
      if (c.red == color.red &&
          c.green == color.green &&
          c.blue == color.blue &&
          c.alpha == color.alpha) return true;
    return false;
  }
}

Future<void> favorite(Color color) async {
  await database?.insert(
    'favorites',
    {
      'alpha': color.alpha,
      'red': color.red,
      'green': color.green,
      'blue': color.blue,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  FavoriteColors.colors.add(color);
  favoritesKey.currentState?.insertItem(
    FavoriteColors.colors.indexOf(color),
    duration: itemSlideAnimationDuration,
  );
  // await Future.delayed(itemSlideAnimationDuration);
  // need to update the screen because the list if not the only thing that
  // show favorited colors
  AppBuilder.state.update();
}

const itemSlideAnimationDuration = Duration(milliseconds: 400);

Future<void> unfavorite(Color color) async {
  await database?.delete(
    'favorites',
    where: "alpha = ? and red = ? and green = ? and blue = ?",
    whereArgs: [color.alpha, color.red, color.green, color.blue],
  );
  int index = FavoriteColors.colors.indexOf(color);
  var c = FavoriteColors.colors[index];
  bool isFavorite = FavoriteColors.hasColor(color);
  favoritesKey.currentState?.removeItem(
    index,
    (context, animation) => SlideTransition(
      child: FavoriteListTile(
        color: c,
        isFavorite: isFavorite,
        animation: animation,
      ),
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
    ),
    duration: itemSlideAnimationDuration,
  );
  // await Future.delayed(itemSlideAnimationDuration);
  FavoriteColors.colors.remove(color);
  AppBuilder.state.update();
}

Future<List<Color>> favorites() async {
  final List<Map<String, dynamic>> maps =
      (await database?.query('favorites')) ?? [];
  if (maps.isNotEmpty)
    FavoriteColors.colors = List.generate(maps.length, (i) {
      var map = maps[i];
      return Color.fromARGB(
          map['alpha'], map['red'], map['green'], map['blue']);
    });
  return FavoriteColors.colors;
}
