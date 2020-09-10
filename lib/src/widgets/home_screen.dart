import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokeapi/src/app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_pokeapi/src/app/login/bloc/login_bloc.dart';

import 'package:flutter_pokeapi/src/app/login/views/login_screen.dart';
import 'package:flutter_pokeapi/src/app/pokedex_list/views/pokedex_list_screen.dart';

class HomeScreen extends StatelessWidget {
  final AuthenticationState authenticationState;

  HomeScreen(this.authenticationState);

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = authenticationState is AuthenticationAuthenticated;
    return isLoggedIn
        ? PokedexListScreen()
        : BlocProvider(
            create: (context) => LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            ),
            child: LoginPage(),
          );
  }
}
