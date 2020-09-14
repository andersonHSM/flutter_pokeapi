import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokeapi/src/app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_pokeapi/src/app/pokedex_list/bloc/pokemon_list_bloc.dart';
import 'package:flutter_pokeapi/src/app/pokedex_list/widgets/pokemon_list_app_bar.dart';
import 'package:flutter_pokeapi/src/app/pokedex_list/widgets/pokemon_grid_tile/pokemon_grid_tile.dart';

class PokedexListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final AuthenticationBloc authenticationBloc = BlocProvider.of(context);
    final AuthenticationAuthenticated authenticationState =
        authenticationBloc.state;

    final mediaQuery = MediaQuery.of(context);

    BlocProvider.of<PokemonListBloc>(context).add(LoadPokemonListEvent());

    return Scaffold(
      body: Container(
        child: SafeArea(
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
              CustomScrollView(
                slivers: [
                  PokemonListAppBar(
                      authenticationState: authenticationState,
                      authenticationBloc: authenticationBloc,
                      mediaQuery: mediaQuery),
                  BlocBuilder<PokemonListBloc, PokemonListState>(
                    builder: (context, state) {
                      if (state is PokemonListLoadError) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text('Error while loading pokemons'),
                          ),
                        );
                      } else if (state is PokemonListLoadSuccess) {
                        return SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          sliver: SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.95,
                                    maxCrossAxisExtent:
                                        mediaQuery.size.height * 0.5),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final pokemon =
                                    state.pokemonList.elementAt(index);

                                return PokemonGridTile(pokemon: pokemon);
                              },
                              childCount: state.pokemonList.length,
                            ),
                          ),
                        );
                      } else {
                        return SliverToBoxAdapter(
                          child: Container(
                            width: mediaQuery.size.width,
                            height: mediaQuery.size.height,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
