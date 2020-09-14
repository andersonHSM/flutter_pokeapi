part of 'pokemon_list_bloc.dart';

abstract class PokemonListEvent extends Equatable {
  const PokemonListEvent();

  @override
  List<Object> get props => [];
}

class LoadPokemonListEvent extends PokemonListEvent {
  const LoadPokemonListEvent();

  @override
  List<Object> get props => [];
}

class PokemonListLoadedEvent extends PokemonListEvent {
  final List<Pokemon> pokemonList;

  const PokemonListLoadedEvent(this.pokemonList);

  @override
  List<Object> get props => [pokemonList];
}
