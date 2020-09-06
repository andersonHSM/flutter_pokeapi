import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_pokeapi/src/models/pokemon.dart';
import 'package:flutter_pokeapi/src/utils/type_to_color_mapper.dart';

class PokedexListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

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
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  collapsedHeight: 60,
                  toolbarHeight: 49,
                  flexibleSpace: SafeArea(
                    child: Image.asset('lib/assets/pokemon-logo.png'),
                  ),
                  expandedHeight: 200,
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
                          // print(element['weaknesses']);
                          final pokemon = Pokemon.fromMap(element);
                          list.add(pokemon);
                        },
                      );

                      return SliverPadding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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

                              return GridTile(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    color: TypeToColorMapper
                                        .colorMapper[pokemon.type[0]],
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          child: Text('${pokemon.name}'),
                                          left: 15,
                                          top: 10,
                                        ),
                                        Positioned(
                                            width: 350,
                                            child: Opacity(
                                              opacity: 0.05,
                                              child: ColorFiltered(
                                                colorFilter: ColorFilter.mode(
                                                    Colors.white,
                                                    BlendMode.color),
                                                child: Image.asset(
                                                    'lib/assets/pokeball-transparent.png'),
                                              ),
                                            )),
                                        Positioned(
                                          bottom: -10,
                                          right: -10,
                                          child: Image.network(
                                            "${pokemon.img}",
                                            scale: 0.9,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
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
    );
  }
}
