import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokeapi/src/app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_pokeapi/src/app/login/bloc/login_bloc.dart';

import 'package:flutter_pokeapi/src/app/login/views/login_screen.dart';
import 'package:flutter_pokeapi/src/app/pokedex_list/views/pokedex_list_screen.dart';
import 'package:user_repository/user_repository.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return PokedexListScreen();
        }

        return BlocProvider(
          create: (context) => LoginBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          ),
          child: LoginPage(),
        );
      },
    );
  }
}
