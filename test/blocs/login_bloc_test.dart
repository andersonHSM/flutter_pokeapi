import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_pokeapi/src/app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_pokeapi/src/app/login/bloc/login_bloc.dart';
import 'package:flutter_pokeapi/src/repositories/authentication_repository/authentication_repository.dart';
import 'package:flutter_pokeapi/src/repositories/local_storage_repository/local_storage_repository.dart';
import 'package:flutter_pokeapi/src/repositories/user_repository/models/models.dart';
import 'package:flutter_pokeapi/src/repositories/user_repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class AuthenticationRepositoryMock extends Mock
    implements AuthenticationRepository {}

class UserRepositoryMock extends Mock implements UserRepository {}

class LocalUserRepositoryMock extends Mock implements HiveRepository<User> {}

class AuthenticationBlocMock extends MockBloc<AuthenticationBloc>
    implements AuthenticationBloc {}

void main() {
  AuthenticationRepository authenticationRepository;
  UserRepository userRepository;
  IORepository<User> localUserRepository;
  // ignore: close_sinks
  AuthenticationBloc authenticationBloc;
  LoginBloc loginBloc;

  group('LoginBloc', () {
    setUp(() {
      authenticationRepository = AuthenticationRepositoryMock();
      userRepository = UserRepositoryMock();
      localUserRepository = LocalUserRepositoryMock();
      authenticationBloc = AuthenticationBlocMock();

      loginBloc = LoginBloc(
          authenticationRepository: authenticationRepository,
          authenticationBloc: authenticationBloc,
          userRepository: userRepository,
          localUserRepository: localUserRepository);
    });

    blocTest(
      'Should not have intial state change',
      build: () {
        return loginBloc;
      },
      expect: [],
    );

    blocTest<LoginBloc, LoginState>(
      'Should dispatch event and return LoginState',
      build: () {
        return loginBloc;
      },
      act: (LoginBloc bloc) {
        bloc.add(LoginDisplayNamelChanged('Anderson'));
      },
      expect: [isA<LoginState>()],
    );

    blocTest<LoginBloc, LoginState>(
      'Should dispatch event and return LoginState',
      build: () {
        return loginBloc;
      },
      act: (LoginBloc bloc) {
        bloc.add(LoginDisplayNamelChanged('Anderson'));
      },
      expect: [isA<LoginState>()],
    );

    blocTest<LoginBloc, LoginState>(
      'Should dispatch authentication repository login',
      build: () {
        when(authenticationRepository.logIn(any)).thenAnswer(
            (_) => Future.value(SignInReturn(displayName: 'Anderson')));

        when(userRepository.getUser(any))
            .thenAnswer((_) => Future.value(User(displayName: 'Anderson 2')));
        return loginBloc;
      },
      act: (LoginBloc bloc) {
        bloc.add(LoginSubmitted());
      },
      verify: (bloc) async {
        verify(await authenticationRepository.logIn(any)).called(1);
        verify(await userRepository.getUser(any)).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'Should dispatch authentication repository signup',
      build: () {
        when(authenticationRepository.signUp(any))
            .thenAnswer((_) => Future.value(SignupReturn(idToken: '12345')));

        when(userRepository.updateUserInfo(any))
            .thenAnswer((_) => Future.value(User(displayName: 'Anderson 2')));
        return loginBloc;
      },
      act: (LoginBloc bloc) => bloc.add(SignupSubmitted()),
      verify: (bloc) async {
        verify(await authenticationRepository.signUp(any)).called(1);
        verify(await userRepository.updateUserInfo(any)).called(1);
      },
    );
  });
}
