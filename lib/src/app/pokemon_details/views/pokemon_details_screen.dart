import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/src/app/pokemon_details/widgets/pokemon_detail.dart';

import 'package:flutter_pokeapi/src/app/pokemon_details/widgets/pokemon_detail_app_bar.dart';
import 'package:flutter_pokeapi/src/models/pokemon.dart';
import 'package:flutter_pokeapi/src/utils/type_to_color_mapper.dart';

class PokemonDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expandedHeight = 250.0;
    final collapsedHeight = 100.0;

    final Pokemon pokemon = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: TypeToColorMapper.colorMapper[pokemon.type[0]],
      body: CustomScrollView(
        slivers: [
          PokemonDetailSliverAppBar(
            floating: true,
            appBarColor: TypeToColorMapper.colorMapper[pokemon.type[0]],
            collapsedHeight: collapsedHeight,
            expandedHeight: expandedHeight,
            pokemon: pokemon,
          ),
          SliverToBoxAdapter(
            child: PokemonDetail(
                collapsedHeight: collapsedHeight,
                expandedHeight: expandedHeight,
                pokemon: pokemon),
          ),
        ],
      ),
    );
  }
}
