part of 'pokemon_list_bloc.dart';

abstract class PokemonListState extends Equatable {
  const PokemonListState();

  @override
  List<Object> get props => [];
}

class PokemonListInitial extends PokemonListState {}

class PokemonListLoading extends PokemonListState {}

class PokemonListLoaded extends PokemonListState {
  final List<Pokemon> pokemonList;

  const PokemonListLoaded(List<Pokemon> pokemonList)
      : assert(pokemonList != null),
        this.pokemonList = pokemonList;

  @override
  List<Object> get props => [];

  PokemonListLoaded copyWith({
    List<Pokemon> pokemonList,
  }) {
    return PokemonListLoaded(
      pokemonList ?? this.pokemonList,
    );
  }
}

class PokemonListLoadError extends PokemonListState {}
