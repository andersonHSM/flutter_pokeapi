import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/src/app/login/views/login_screen.dart';
import 'package:flutter_pokeapi/src/app/pokedex_list/views/pokedex_list_screen.dart';

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
        '/': (ctx) => isLoggedIn ? PokedexListScreen() : LoginPage(),
      },
    );
  }
}
