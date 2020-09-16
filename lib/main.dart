import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/src/app/app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_pokeapi/src/repositories/user_repository/models/models.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ProviderUserInfoAdapter());

  final userBox = await Hive.openBox<User>('userBox');

  runApp(PokedexApp(userBox: userBox));
}
