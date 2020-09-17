import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_pokeapi/src/app/pokedex_list/bloc/pokemon_list_bloc.dart';
import 'package:flutter_pokeapi/src/models/pokemon.dart';
import 'package:flutter_pokeapi/src/repositories/pokemon_repository/pokemon_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

final pokemonJson = [
  {
    "id": 1,
    "num": "001",
    "name": "Bulbasaur",
    "img": "http://www.serebii.net/pokemongo/pokemon/001.png",
    "type": ["Grass", "Poison"],
    "height": "0.71 m",
    "weight": "6.9 kg",
    "candy": "Bulbasaur Candy",
    "candy_count": 25,
    "egg": "2 km",
    "spawn_chance": 0.69,
    "avg_spawns": 69,
    "spawn_time": "20:00",
    "multipliers": [1.58],
    "weaknesses": ["Fire", "Ice", "Flying", "Psychic"],
    "next_evolution": [
      {"num": "002", "name": "Ivysaur"},
      {"num": "003", "name": "Venusaur"}
    ]
  },
  {
    "id": 2,
    "num": "002",
    "name": "Ivysaur",
    "img": "http://www.serebii.net/pokemongo/pokemon/002.png",
    "type": ["Grass", "Poison"],
    "height": "0.99 m",
    "weight": "13.0 kg",
    "candy": "Bulbasaur Candy",
    "candy_count": 100,
    "egg": "Not in Eggs",
    "spawn_chance": 0.042,
    "avg_spawns": 4.2,
    "spawn_time": "07:00",
    "multipliers": [1.2, 1.6],
    "weaknesses": ["Fire", "Ice", "Flying", "Psychic"],
    "prev_evolution": [
      {"num": "001", "name": "Bulbasaur"}
    ],
    "next_evolution": [
      {"num": "003", "name": "Venusaur"}
    ]
  }
];

class PokemonRepositoryMock extends Mock implements PokemonRepository {}

void main() {
  group(
    'PokemonListBloc',
    () {
      PokemonRepository pokemonRepository;
      PokemonListBloc pokemonListBloc;

      List<Pokemon> pokemons = [];

      setUp(
        () {
          pokemonRepository = PokemonRepositoryMock();

          pokemonListBloc = PokemonListBloc(
            pokemonRepository: pokemonRepository,
          );
        },
      );

      blocTest(
        'Should have correct initial state',
        build: () => pokemonListBloc,
        expect: <PokemonListState>[],
      );

      blocTest(
        'Should load correctly the list and emit corresponding states',
        build: () {
          List.from(pokemonJson).forEach((element) {
            pokemons.add(Pokemon.fromMap(element));
          });

          when(pokemonRepository.getPokemons()).thenAnswer(
            (_) => Future.value(pokemons),
          );

          return pokemonListBloc;
        },
        act: (PokemonListBloc bloc) => bloc.add(LoadPokemonListEvent()),
        expect: <PokemonListState>[
          PokemonListLoading(),
          PokemonListLoadSuccess(pokemons)
        ],
      );

      blocTest(
        'Should emit error state as the loading fails',
        build: () {
          when(pokemonRepository.getPokemons()).thenThrow(
            Exception('failed'),
          );

          return pokemonListBloc;
        },
        act: (PokemonListBloc bloc) => bloc.add(LoadPokemonListEvent()),
        expect: <PokemonListState>[
          PokemonListLoading(),
          PokemonListLoadError(),
        ],
      );
    },
  );
}
