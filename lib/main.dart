import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/src/app/login/views/login_screen.dart';

void main() {
  runApp(PokedexApp());
}

class PokedexApp extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.blue[900],
      ),
      routes: {'/': (ctx) => LoginPage()},
    );
  }
}
