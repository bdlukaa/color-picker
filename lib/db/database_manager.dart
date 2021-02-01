import 'package:color_picker/screens/favorite/favorite_tile.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';
import '../screens/favorite/favorites_list.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

part 'favorite_colors.dart';

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
