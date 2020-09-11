import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pokeapi/src/repositories/authentication_repository/lib/authentication_repository.dart';
import 'package:flutter_pokeapi/src/repositories/user_repository/lib/models/models.dart';
import 'package:flutter_pokeapi/src/repositories/user_repository/lib/src/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
    @required UserRepository userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(AuthenticationUnkown()) {
    _authenticationStatusSubscription = _authenticationRepository.status
        .listen((status) => add(AuthenticationStatusChanged(status)));
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
      AuthenticationStatusChanged event) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationUnauthenticated();
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser(event.token);

        if (user == null) {
          return AuthenticationUnauthenticated();
        }

        return AuthenticationAuthenticated(user);

      default:
        return AuthenticationUnkown();
    }
  }

  // TODO - IMPLEMENTAR AÇÃO REAL
  Future<User> _tryGetUser(String idToken) async {
    try {
      final user =
          await _userRepository.getUser(UserInfoRequest(idToken: idToken));
      return user.copyWith(idToken: idToken);
    } on Exception {
      return null;
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }
}
