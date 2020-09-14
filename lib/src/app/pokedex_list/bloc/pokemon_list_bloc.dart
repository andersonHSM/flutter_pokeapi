import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pokeapi/src/models/pokemon.dart';
import 'package:flutter_pokeapi/src/repositories/pokemon_repository/pokemon_repository.dart';

part 'pokemon_list_event.dart';
part 'pokemon_list_state.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final PokemonRepository _pokemonRepository;

  PokemonListBloc({@required PokemonRepository pokemonRepository})
      : assert(pokemonRepository != null),
        _pokemonRepository = pokemonRepository,
        super(PokemonListInitial());

  @override
  Stream<PokemonListState> mapEventToState(
    PokemonListEvent event,
  ) async* {
    if (event is LoadPokemonListEvent) {
      yield* _mapLoadPokemonListToState(event, _pokemonRepository);
    }
  }

  Stream<PokemonListState> _mapLoadPokemonListToState(
      LoadPokemonListEvent event, PokemonRepository pokemonRepository) async* {
    yield PokemonListLoading();

    try {
      final pokemonList = await pokemonRepository.getPokemons();

      yield PokemonListLoadSuccess(pokemonList);
    } catch (_) {
      print(_);
      yield PokemonListLoadError();
    }
  }
}
