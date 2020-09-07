import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/src/app/login/views/login_screen.dart';
import 'package:flutter_pokeapi/src/app/pokedex_list/views/pokedex_list_screen.dart';
import 'package:flutter_pokeapi/src/app/pokemon_details/views/pokemon_details_screen.dart';
import 'package:flutter_pokeapi/src/utils/app_routes.dart';

void main() {
  runApp(PokedexApp());
}

class PokedexApp extends StatelessWidget {
  final isLoggedIn = true;
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.yellow[600],
      ),
      routes: {
        AppRoutes.HOME: (ctx) => isLoggedIn ? PokedexListScreen() : LoginPage(),
        AppRoutes.POKEMON_DETAILS: (ctx) => PokemonDetailsScreen()
      },
    );
  }
}
