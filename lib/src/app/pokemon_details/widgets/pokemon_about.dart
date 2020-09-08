import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/src/models/pokemon.dart';

class PokemonAbout extends StatelessWidget {
  final Pokemon pokemon;

  PokemonAbout({@required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final rowSizedBoxHeight = 10.0;

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Type"),
                Text(pokemon.type[0]),
              ],
            ),
            SizedBox(
              height: rowSizedBoxHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Height"),
                Text(pokemon.height),
              ],
            ),
            SizedBox(
              height: rowSizedBoxHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Weight"),
                Text(pokemon.weight),
              ],
            ),
            SizedBox(
              height: rowSizedBoxHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Candy"),
                Text(pokemon.candy),
              ],
            ),
            SizedBox(
              height: rowSizedBoxHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Candy Count"),
                Text(
                  pokemon.candyCount?.toStringAsFixed(2) ?? 'N/A',
                ),
              ],
            ),
            SizedBox(
              height: rowSizedBoxHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Spawn Change"),
                Text(
                  "${(double.tryParse(pokemon.spawnChance) * 100).toStringAsFixed(2)} %",
                ),
              ],
            ),
            SizedBox(
              height: rowSizedBoxHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Avarage Change"),
                Text(pokemon.avgSpawns),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
