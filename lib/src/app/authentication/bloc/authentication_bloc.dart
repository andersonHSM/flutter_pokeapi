import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pokeapi/src/repositories/authentication_repository/authentication_repository.dart';
import 'package:flutter_pokeapi/src/repositories/local_storage_repository/local_storage_repository.dart';
import 'package:flutter_pokeapi/src/repositories/user_repository/models/models.dart';
import 'package:flutter_pokeapi/src/repositories/user_repository/src/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final IORepository<User> _localUserRepository;

  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
    @required UserRepository userRepository,
    @required IORepository<User> localUserRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        assert(localUserRepository != null),
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        _localUserRepository = localUserRepository,
        super(AuthenticationUnkown());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      // TODO - alterar string para variável
      await _localUserRepository.removeItem('local_user');
      _authenticationRepository.logOut();
    }
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
      AuthenticationStatusChanged event) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationUnauthenticated();
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser(event.user?.idToken);

        if (user == null) {
          return AuthenticationUnauthenticated();
        }

        return AuthenticationAuthenticated(user);

      default:
        return AuthenticationUnkown();
    }
  }

  Future<User> _tryGetUser(String idToken) async {
    try {
      // TODO - alterar string para variável
      final localUser = _localUserRepository.getItem('local_user');

      if (localUser != null) {
        return localUser;
      }

      final user =
          await _userRepository.getUser(UserInfoRequest(idToken: idToken));
      return user.copyWith(idToken: idToken);
    } on Exception {
      return null;
    }
  }

  @override
  Future<void> close() {
    _authenticationRepository.dispose();
    return super.close();
  }
}
