import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/src/app/pokemon_details/views/pokemon_details_screen.dart';
import 'package:flutter_pokeapi/src/utils/app_routes.dart';
import 'package:flutter_pokeapi/src/widgets/home_screen.dart';

void main() {
  runApp(PokedexApp());
}

class PokedexApp extends StatelessWidget {
  final isLoggedIn = false;
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.yellow[600],
      ),
      routes: {
        AppRoutes.HOME: (ctx) => HomeScreen(),
        AppRoutes.POKEMON_DETAILS: (ctx) => PokemonDetailsScreen()
      },
    );
  }
}
