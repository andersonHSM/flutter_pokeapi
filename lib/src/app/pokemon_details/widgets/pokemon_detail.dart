import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/src/app/pokemon_details/models/tab_data.dart';
import 'package:flutter_pokeapi/src/app/pokemon_details/widgets/pokemon_about.dart';
import 'package:flutter_pokeapi/src/models/pokemon.dart';

class PokemonDetail extends StatelessWidget {
  PokemonDetail({
    Key key,
    @required this.collapsedHeight,
    @required this.expandedHeight,
    @required this.pokemon,
  })  : assert(pokemon != null),
        super(key: key);

  final double collapsedHeight;
  final double expandedHeight;
  final Pokemon pokemon;

  TabBar _buildTabBar(List<TabData> tabs) {
    return TabBar(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2,
      indicatorColor: Colors.indigo,
      tabs: tabs.map((tab) => Text(tab.tabName)).toList(),
    );
  }

  Widget _buildTabBarView(List<TabData> tabs) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBarView(
          children: tabs.map((tab) => tab.tabWidget).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final List<TabData> tabs = [
      TabData(
        "About",
        PokemonAbout(
          pokemon: pokemon,
        ),
      ),
      TabData(
        "Evolutions",
        Container(
          alignment: Alignment.topCenter,
          child:
              Text("implementar os cards de evolução após gerência de estado"),
        ),
      ),
    ];

    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Container(
        child: Column(
          children: [
            _buildTabBar(tabs),
            _buildTabBarView(tabs),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        height: mediaQuery.size.height - collapsedHeight,
        padding: EdgeInsets.only(top: 10),
        width: mediaQuery.size.width,
      ),
    );
  }
}
