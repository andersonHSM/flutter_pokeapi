import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/src/models/pokemon.dart';
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
              Positioned(
                width: 160,
                child: LayoutBuilder(
                  builder: (context, constraints) => Container(
                    width: 150,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${pokemon.name}',
                              style: TextStyle(
                                fontSize: mediaQuery.size.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
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
                  ),
                ),
                left: 15,
                top: 10,
              ),
              Positioned(
                left: 10,
                bottom: 10,
                child: Material(
                  color: Colors.transparent,
                  type: MaterialType.circle,
                  child: InkWell(
                    customBorder: CircleBorder(),
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 24,
                        )),
                    onTap: () {},
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
