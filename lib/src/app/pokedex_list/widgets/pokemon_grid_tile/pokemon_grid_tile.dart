import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokeapi/src/app/pokedex_list/bloc/pokemon_list_bloc.dart';
import 'package:flutter_pokeapi/src/app/pokedex_list/widgets/pokemon_grid_tile/pokemon_details.dart';
import 'package:flutter_pokeapi/src/app/pokemon_details/views/pokemon_details_screen.dart';
import 'package:flutter_pokeapi/src/models/pokemon.dart';
import 'package:flutter_pokeapi/src/utils/app_routes.dart';
import 'package:flutter_pokeapi/src/utils/type_to_color_mapper.dart';

class PokemonGridTile extends StatelessWidget {
  const PokemonGridTile({
    @required this.pokemon,
  }) : assert(pokemon != null);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return GridTile(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: TypeToColorMapper.colorMapper[pokemon.type[0]],
          child: Stack(
            children: [
              Positioned(
                width: mediaQuery.size.width * 0.9,
                child: Opacity(
                  opacity: 0.05,
                  child: ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.color),
                    child: Image.asset('lib/assets/pokeball-transparent.png'),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: -30,
                child: Image.network(
                  "${pokemon.img}",
                  scale: 0.9,
                ),
              ),
              PokemonDetails(pokemon: pokemon, mediaQuery: mediaQuery),
              Positioned(
                left: 10,
                bottom: 10,
                child: Material(
                  color: Colors.transparent,
                  type: MaterialType.circle,
                  child: InkWell(
                    customBorder: CircleBorder(),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 24,
                        )),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.POKEMON_DETAILS,
                          arguments: pokemon);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
