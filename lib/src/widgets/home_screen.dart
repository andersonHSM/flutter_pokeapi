import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokeapi/src/app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_pokeapi/src/app/login/bloc/login_bloc.dart';

import 'package:flutter_pokeapi/src/app/login/views/login_screen.dart';
import 'package:flutter_pokeapi/src/app/pokedex_list/bloc/pokemon_list_bloc.dart';
import 'package:flutter_pokeapi/src/app/pokedex_list/views/pokedex_list_screen.dart';
import 'package:flutter_pokeapi/src/repositories/authentication_repository/authentication_repository.dart';
import 'package:flutter_pokeapi/src/repositories/local_storage_repository/local_storage_repository.dart';
import 'package:flutter_pokeapi/src/repositories/pokemon_repository/pokemon_repository.dart';
import 'package:flutter_pokeapi/src/repositories/user_repository/models/models.dart';
import 'package:flutter_pokeapi/src/repositories/user_repository/user_repository.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return RepositoryProvider(
            create: (context) => PokemonRepository(),
            child: BlocProvider(
              create: (context) => PokemonListBloc(
                  pokemonRepository:
                      RepositoryProvider.of<PokemonRepository>(context)),
              child: PokedexListScreen(),
            ),
          );
        }

        return BlocProvider(
          create: (context) => LoginBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
            localUserRepository:
                RepositoryProvider.of<HiveRepository<User>>(context),
          ),
          child: LoginPage(),
        );
      },
    );
  }
}
