import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/src/models/pokemon.dart';

class PokemonDetails extends StatelessWidget {
  const PokemonDetails({
    Key key,
    @required this.pokemon,
    @required this.mediaQuery,
  }) : super(key: key);

  final Pokemon pokemon;
  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: 160,
      height: 120,
      child: LayoutBuilder(builder: (context, constraints) {
        final containerWidth = constraints.maxWidth * 0.2;
        final containerHigh = constraints.maxHeight * 0.8;
        return Container(
          width: containerWidth,
          height: containerHigh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${pokemon.name}',
                style: TextStyle(
                  fontSize: mediaQuery.size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ...pokemon.type.map((type) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 2.5),
                    color: Colors.white38,
                    height: 20,
                    width: 60,
                    child: Center(
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: mediaQuery.size.width * 0.03,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList()
            ],
          ),
        );
      }),
      left: 15,
      top: 10,
    );
  }
}
