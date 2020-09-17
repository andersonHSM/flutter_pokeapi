import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_pokeapi/src/app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_pokeapi/src/repositories/authentication_repository/authentication_repository.dart';
import 'package:flutter_pokeapi/src/repositories/local_storage_repository/local_storage_repository.dart';
import 'package:flutter_pokeapi/src/repositories/user_repository/models/models.dart';
import 'package:flutter_pokeapi/src/repositories/user_repository/user_repository.dart';

class AuthenticationRepositoryMock extends Mock
    implements AuthenticationRepository {}

class UserRepositoryMock extends Mock implements UserRepository {}

class LocalUserRepositoryMock extends Mock implements HiveRepository<User> {}

void main() {
  AuthenticationRepository authenticationRepository;
  UserRepository userRepository;
  IORepository<User> localUserRepository;
  // ignore: close_sinks
  AuthenticationBloc authenticationBloc;

  group('Authentication Bloc', () {
    final User user = User(
      displayName: 'User',
      email: 'teste@mail.com',
      idToken: '12312312nkldasjdias897',
      localId: 'kaskjk',
    );

    SignInReturn signInReturn = SignInReturn(
      displayName: 'User',
      email: 'teste@mail.com',
      expiresIn: '3213',
      idToken: '12312312nkldasjdias897',
      localId: 'kaskjk',
      refreshToken: "askdjaksjdasd",
      registered: true,
    );

    setUp(() {
      localUserRepository = LocalUserRepositoryMock();
      userRepository = UserRepositoryMock();
      authenticationRepository = AuthenticationRepositoryMock();

      authenticationBloc = AuthenticationBloc(
        authenticationRepository: authenticationRepository,
        userRepository: userRepository,
        localUserRepository: localUserRepository,
      );
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
        'Has the correct initial State',
        build: () => authenticationBloc,
        expect: <AuthenticationState>[]);

    blocTest<AuthenticationBloc, AuthenticationState>(
        'App should login with local user information',
        build: () {
          when(localUserRepository.getItem(any)).thenReturn(user);
          return authenticationBloc;
        },
        act: (bloc) => bloc.add(
              AuthenticationStatusChanged(
                AuthenticationStatus.authenticated,
                user,
              ),
            ),
        expect: <AuthenticationState>[AuthenticationAuthenticated(user)]);

    blocTest<AuthenticationBloc, AuthenticationState>(
      'App should login with backend user information',
      build: () {
        when(userRepository.getUser(any)).thenAnswer((_) => Future.value(user));

        return authenticationBloc;
      },
      verify: (cubit) async {
        verify(userRepository.getUser(any)).called(1);
      },
      act: (bloc) => bloc.add(
        AuthenticationStatusChanged(
          AuthenticationStatus.authenticated,
          user,
        ),
      ),
      expect: <AuthenticationState>[AuthenticationAuthenticated(user)],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'App should unauthenticate when receiving error from login flow',
      build: () {
        when(userRepository.getUser(any)).thenAnswer((_) => Future.value(null));

        return authenticationBloc;
      },
      verify: (cubit) async {
        verify(userRepository.getUser(any)).called(1);
      },
      act: (bloc) => bloc.add(
        AuthenticationStatusChanged(
          AuthenticationStatus.authenticated,
          user,
        ),
      ),
      expect: <AuthenticationState>[AuthenticationUnauthenticated()],
    );
  });
}
