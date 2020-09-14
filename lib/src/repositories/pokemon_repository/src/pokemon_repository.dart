import 'package:dio/dio.dart';
import 'package:flutter_pokeapi/src/models/pokemon.dart';

class PokemonRepository {
  final String _url =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

  final Dio _dio;

  PokemonRepository() : _dio = Dio();

  Future<List<Pokemon>> getPokemons() async {
    final response = await _dio.get(_url);

    print(response.data["pokemon"]);

    final List<Pokemon> pokemons = [];

    List.from(response.data['pokemon']).forEach((element) {
      pokemons.add(Pokemon.fromMap(element));
    });
    print(pokemons);

    return pokemons;
  }
}
