import 'package:color_picker/screens/favorite/favorite_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../main.dart';
import '../screens/favorite/favorites_list.dart';

part 'favorite_colors.dart';

Box get favoritesBox => Hive.box('favorites');

Future<Box> startDatabase() async {
  await Hive.initFlutter();
  final box = await Hive.openBox('favorites');
  return box;
}

// Future<void> closeDatabase() async => await Hive.close?.close();
