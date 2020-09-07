import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/src/app/pokemon_details/models/tab_data.dart';
import 'package:flutter_pokeapi/src/app/pokemon_details/widgets/pokemon_detail.dart';

import 'package:flutter_pokeapi/src/app/pokemon_details/widgets/pokemon_detail_app_bar.dart';
import 'package:flutter_pokeapi/src/models/pokemon.dart';
import 'package:flutter_pokeapi/src/utils/type_to_color_mapper.dart';

class PokemonDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expandedHeight = 250.0;

    // TODO - ALTERAR QUANDO GERENCIAR ESTADO
    final Pokemon pokemon = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: TypeToColorMapper.colorMapper[pokemon.type[0]],
      body: CustomScrollView(
        slivers: [
          PokemonDetailSliverAppBar(
            floating: true,
            appBarColor: TypeToColorMapper.colorMapper[pokemon.type[0]],
            collapedHight: 100,
            expandedHeight: expandedHeight,
            pokemonPhoto: _PokemonPhoto(pokemon: pokemon),
          ),
          SliverToBoxAdapter(
            child: PokemonDetail(expandedHeight: expandedHeight),
          ),
        ],
      ),
    );
  }
}

// TODO - separar em arquivo próprio
class _PokemonPhoto extends StatelessWidget {
  const _PokemonPhoto({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      pokemon.img,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        return CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes
              : null,
        );
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          child: child,
          opacity: frame == null ? 0 : 1,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'lib/assets/pokeball-transparent.png',
          scale: 4,
        );
      },
    );
  }
}
