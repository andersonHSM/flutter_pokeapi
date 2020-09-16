import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokeapi/src/app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_pokeapi/src/app/pokemon_details/views/pokemon_details_screen.dart';
import 'package:flutter_pokeapi/src/repositories/authentication_repository/authentication_repository.dart';
import 'package:flutter_pokeapi/src/repositories/local_storage_repository/local_storage_repository.dart';
import 'package:flutter_pokeapi/src/repositories/user_repository/models/models.dart';
import 'package:flutter_pokeapi/src/repositories/user_repository/user_repository.dart';
import 'package:flutter_pokeapi/src/utils/app_routes.dart';
import 'package:flutter_pokeapi/src/widgets/home_screen.dart';
import 'package:hive/hive.dart';

class PokedexApp extends StatelessWidget {
  final Box<User> userBox;
  PokedexApp({@required this.userBox}) : assert(userBox != null);

  final isLoggedIn = false;
  Widget build(context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => HiveRepository<User>(box: userBox),
        ),
        RepositoryProvider(
          create: (context) => AuthenticationRepository(),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) {
          final userRepository = RepositoryProvider.of<UserRepository>(context);
          final authenticationRepository =
              RepositoryProvider.of<AuthenticationRepository>(context);

          return AuthenticationBloc(
            userRepository: userRepository,
            authenticationRepository: authenticationRepository,
            localUserRepository:
                RepositoryProvider.of<HiveRepository<User>>(context),
          );
        },
        child: PokedexAppView(),
      ),
    );
  }
}

class PokedexAppView extends StatelessWidget {
  const PokedexAppView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.yellow[600],
      ),
      routes: {
        AppRoutes.HOME: (ctx) => HomeScreen(),
        AppRoutes.POKEMON_DETAILS: (ctx) => PokemonDetailsScreen()
      },
    );
  }
}
