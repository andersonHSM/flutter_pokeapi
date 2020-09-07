import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/src/app/pokemon_details/models/tab_data.dart';

class PokemonDetail extends StatelessWidget {
  PokemonDetail({
    Key key,
    @required this.expandedHeight,
  }) : super(key: key);

  final double expandedHeight;

  final List<TabData> _tabs = [
    TabData(
      "About",
      Container(
        alignment: Alignment.topCenter,
        child: Text("Under development"),
      ),
    ),
    TabData(
      "Base Stats",
      Container(
        alignment: Alignment.topCenter,
        child: Text("Under development"),
      ),
    ),
    TabData(
      "Evolution",
      Container(
        alignment: Alignment.topCenter,
        child: Text("Under development"),
      ),
    ),
    TabData(
      "Moves",
      Container(
        alignment: Alignment.topCenter,
        child: Text("Under development"),
      ),
    ),
  ];

  TabBar _buildTabBar() {
    return TabBar(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2,
      indicatorColor: Colors.indigo,
      tabs: _tabs.map((tab) => Text(tab.tabName)).toList(),
    );
  }

  Widget _buildTabBarView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBarView(
          children: _tabs.map((tab) => tab.tabWidget).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Container(
        child: Column(
          children: [
            _buildTabBar(),
            _buildTabBarView(),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        height: mediaQuery.size.height - expandedHeight,
        padding: EdgeInsets.only(top: 10),
        width: mediaQuery.size.width,
      ),
    );
  }
}
