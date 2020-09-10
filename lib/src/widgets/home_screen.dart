import 'package:flutter/material.dart';

import 'package:flutter_pokeapi/src/app/login/views/login_screen.dart';
import 'package:flutter_pokeapi/src/app/pokedex_list/views/pokedex_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLoggedIn = false;

    return isLoggedIn ? PokedexListScreen() : AuthPage();
  }
}
