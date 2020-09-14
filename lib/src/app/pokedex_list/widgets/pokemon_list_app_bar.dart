import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/src/app/authentication/bloc/authentication_bloc.dart';

class PokemonListAppBar extends StatelessWidget {
  const PokemonListAppBar({
    Key key,
    @required this.authenticationState,
    @required this.authenticationBloc,
    @required this.mediaQuery,
  }) : super(key: key);

  final AuthenticationAuthenticated authenticationState;
  final AuthenticationBloc authenticationBloc;
  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text("Welcome, ${authenticationState.user.displayName}"),
      actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () =>
              authenticationBloc.add(AuthenticationLogoutRequested()),
        )
      ],
      floating: true,
      pinned: true,
      snap: true,
      collapsedHeight: mediaQuery.size.height * 0.09,
      toolbarHeight: mediaQuery.size.height * 0.08,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              height: 120,
              bottom: 8,
              child: Image.asset(
                'lib/assets/pokemon-logo.png',
              ),
            ),
          ],
        ),
      ),
      expandedHeight: mediaQuery.size.height * 0.25,
    );
  }
}
