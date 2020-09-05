import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_pokeapi/src/models/pokemon.dart';

class PokedexListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return FutureBuilder(
      future: rootBundle.loadString('lib/fakeData/fakeApi.json'),
      builder: (context, snapshot) {
        List<Pokemon> list = [];
        if (snapshot.hasData) {
          final jsonList =
              json.decode(snapshot.data)['pokemon'] as List<dynamic>;
          jsonList.forEach((element) {
            // print(element['weaknesses']);
            final pokemon = Pokemon.fromMap(element);
            list.add(pokemon);
          });
        }
        // for (final pokemon in jsonList) {
        //   print(pokemon);
        //   print(Pokemon.fromMap(pokemon));
        // }
        return Scaffold(
          body: Container(
            child: Stack(
              children: [
                Positioned(
                  bottom: 15,
                  right: 15,
                  child: Opacity(
                    opacity: 0.15,
                    child: Image.asset(
                      'lib/assets/pokebola.png',
                      width: mediaQuery.size.width * 0.5,
                    ),
                  ),
                ),
                if (snapshot.hasData)
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        pinned: true,
                        flexibleSpace: SafeArea(
                          child: Opacity(
                              opacity: 0.2,
                              child:
                                  Image.asset('lib/assets/pokemon-logo.png')),
                        ),
                        expandedHeight: 200,
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => ListTile(
                              title: Text('Pokemon ${list[index].name}')),
                          childCount: list.length,
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
