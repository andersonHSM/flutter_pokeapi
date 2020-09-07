import 'package:flutter/material.dart';

import 'package:flutter_pokeapi/src/app/pokemon_details/widgets/pokemon_detail_app_bar.dart';
import 'package:flutter_pokeapi/src/models/pokemon.dart';
import 'package:flutter_pokeapi/src/utils/type_to_color_mapper.dart';

class PokemonDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO - ALTERAR QUANDO GERENCIAR ESTADO
    final Pokemon pokemon = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          PokemonDetailSliverAppBar(
            floating: true,
            appBarColor: TypeToColorMapper.colorMapper[pokemon.type[0]],
            collapedHight: 100,
            expandedHeight: 250,
            pokemonPhoto: Image.network(pokemon.img),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('Grid Item $index'),
                );
              },
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}
