import 'package:color_picker/screens/favorite/favorite_tile.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'favorite_colors.dart';
import '../main.dart';
import '../screens/favorite/favorites_list.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Database database;

Future<Database> startDatabase() async {
  if (!kIsWeb)
    database = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(
        await getDatabasesPath(),
        'favorites_db.db',
      ),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE favorites(alpha INTEGER, red INTEGER, green INTEGER, blue INTEGER)",
        );
      },
      version: 1,
    );
  return database;
}

Future<void> closeDatabase() async => await database.close();

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
    duration: const Duration(milliseconds: 1000),
  );
  // need to update the screen because the list if not the only thing that
  // show favorited colors
  appBuilderKey.currentState.update();
}

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
    duration: const Duration(milliseconds: 400),
  );
  FavoriteColors.colors.remove(color);
  appBuilderKey.currentState.update();
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
