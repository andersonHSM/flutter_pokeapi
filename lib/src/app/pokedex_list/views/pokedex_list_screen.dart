import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokeapi/src/app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_pokeapi/src/models/pokemon.dart';
import 'package:flutter_pokeapi/src/widgets/pokemon_grid_tile.dart';

class PokedexListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final AuthenticationBloc authenticationBloc = BlocProvider.of(context);
    final AuthenticationAuthenticated authenticationState =
        authenticationBloc.state;

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
                  SliverAppBar(
                    title: Text(
                        "Welcome, ${authenticationState.user.displayName}"),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () => authenticationBloc
                            .add(AuthenticationLogoutRequested()),
                      )
                    ],
                    floating: true,
                    pinned: true,
                    snap: true,
                    collapsedHeight: mediaQuery.size.height * 0.09,
                    toolbarHeight: mediaQuery.size.height * 0.08,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            height: 120,
                            bottom: 8,
                            child: Image.asset(
                              'lib/assets/pokemon-logo.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                    expandedHeight: mediaQuery.size.height * 0.25,
                  ),
                  FutureBuilder(
                    future: rootBundle.loadString('lib/fakeData/fakeApi.json'),
                    builder: (context, snapshot) {
                      List<Pokemon> list = [];
                      if (snapshot.hasData) {
                        final jsonList = json.decode(snapshot.data)['pokemon']
                            as List<dynamic>;
                        jsonList.forEach(
                          (element) {
                            final pokemon = Pokemon.fromMap(element);
                            list.add(pokemon);
                          },
                        );

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
                                final pokemon = list.elementAt(index);

                                return PokemonGridTile(pokemon: pokemon);
                              },
                              childCount: list.length,
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return SliverToBoxAdapter(
                          child: Container(
                            child: Text('erro'),
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
