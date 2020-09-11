import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_pokeapi/src/app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_pokeapi/src/app/login/utils/form_status.dart';
import 'package:flutter_pokeapi/src/repositories/authentication_repository/authentication_repository.dart';
import 'package:flutter_pokeapi/src/repositories/local_storage_repository/local_storage_repository.dart';
import 'package:flutter_pokeapi/src/repositories/user_repository/models/models.dart';
import 'package:flutter_pokeapi/src/repositories/user_repository/user_repository.dart';
import 'package:flutter_pokeapi/src/utils/form_validations.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;
  final AuthenticationBloc _authenticationBloc;
  final IORepository<User> _localUserRepository;

  LoginBloc({
    @required AuthenticationRepository authenticationRepository,
    @required AuthenticationBloc authenticationBloc,
    @required UserRepository userRepository,
    @required IORepository<User> localUserRepository,
  })  : assert(authenticationRepository != null),
        assert(authenticationBloc != null),
        assert(userRepository != null),
        assert(localUserRepository != null),
        _authenticationRepository = authenticationRepository,
        _authenticationBloc = authenticationBloc,
        _userRepository = userRepository,
        _localUserRepository = localUserRepository,
        super(LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginReset) {
      yield LoginState();
    } else if (event is LoginTryAutoLogin) {
      yield await _mapTryAutoLogin(_authenticationBloc);
    } else if (event is LoginDisplayNamelChanged) {
      yield _mapDisplayNameChangedToState(event, state);
    } else if (event is LoginEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginPasswordConfirmChanged) {
      yield _mapPasswordConfirmChangedToState(event, state);
    } else if (event is SignupSubmitted) {
      yield* _mapSignupSubmittedToState(state, _userRepository);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(state, _authenticationBloc);
    }
  }

  Future<LoginState> _mapTryAutoLogin(
      AuthenticationBloc authenticationBloc) async {
    try {
      // TODO - alterar string para variável
      final user = _localUserRepository.getItem('local_user');

      if (user == null) {
        authenticationBloc.add(
          AuthenticationStatusChanged(
            AuthenticationStatus.unauthenticated,
          ),
        );
        return LoginState();
      }

      authenticationBloc.add(
        AuthenticationStatusChanged(
          AuthenticationStatus.authenticated,
          user,
        ),
      );
    } catch (_) {}

    return LoginState();
  }

  LoginState _mapDisplayNameChangedToState(
      LoginDisplayNamelChanged event, LoginState state) {
    final emptyFieldError =
        FormValidations.emptyField("Display name", event.displayName);

    if (emptyFieldError != null) {
      return state.copyWith(
          displayName: event.displayName, displayNameError: emptyFieldError);
    }

    return state.copyWith(
        status: FormStatus.valid,
        displayName: event.displayName,
        displayNameError: null);
  }

  LoginState _mapEmailChangedToState(
      LoginEmailChanged event, LoginState state) {
    final emptyFieldError = FormValidations.emptyField("E-mail", event.email);

    if (emptyFieldError != null) {
      return state.copyWith(email: event.email, emailError: emptyFieldError);
    }

    return state.copyWith(
        status: FormStatus.valid, email: event.email, emailError: null);
  }

  LoginState _mapPasswordChangedToState(
      LoginPasswordChanged event, LoginState state) {
    final emptyFieldError =
        FormValidations.emptyField("Password", event.password);

    if (emptyFieldError != null) {
      return state.copyWith(
          password: event.password, passwordError: emptyFieldError);
    }

    return state.copyWith(
        status: FormStatus.valid,
        password: event.password,
        passwordError: null);
  }

  LoginState _mapPasswordConfirmChangedToState(
      LoginPasswordConfirmChanged event, LoginState state) {
    final emptyFieldError = FormValidations.emptyField(
        "Password confirmation", event.passwordConfirm);

    final passwordConfirmError =
        FormValidations.passwordConfirm(state.password, event.passwordConfirm);

    if (emptyFieldError != null) {
      return state.copyWith(
          passwordConfirm: event.passwordConfirm,
          passwordConfirmError: emptyFieldError);
    } else if (passwordConfirmError != null) {
      return state.copyWith(
          passwordConfirm: event.passwordConfirm,
          passwordConfirmError: passwordConfirmError);
    }

    return state.copyWith(
      status: FormStatus.valid,
      passwordConfirm: event.passwordConfirm,
      passwordConfirmError: null,
    );
  }

  AuthRequest _getAuthRequestObject(LoginState state) {
    final stateFormJson = state.toMap();

    return AuthRequest.fromMap(stateFormJson);
  }

  Stream<LoginState> _mapSignupSubmittedToState(
      LoginState state, UserRepository userRepository) async* {
    if (state.status != FormStatus.invalid) {
      yield state.copyWith(status: FormStatus.submissionInProgress);
      final authRequest = _getAuthRequestObject(state);

      try {
        final user = await _authenticationRepository.signUp(authRequest);

        final userUpdateRequest = UserUpdateRequest(
            idToken: user.idToken, displayName: state.displayName);

        await userRepository.updateUserInfo(userUpdateRequest);

        yield state.copyWith(status: FormStatus.submissionSuccess);
      } catch (error) {
        yield state.copyWith(status: FormStatus.submissionFailure);
      }
    }
  }

  Stream<LoginState> _mapLoginSubmittedToState(
      LoginState state, AuthenticationBloc authenticationBloc) async* {
    yield state.copyWith(status: FormStatus.submissionInProgress);

    final authRequest = _getAuthRequestObject(state);

    try {
      final loginReturn = await _authenticationRepository.logIn(authRequest);

      final user = await _userRepository.getUser(
        UserInfoRequest.fromMap(loginReturn.toMap()),
      );

      // TODO - alterar string para variável
      await _localUserRepository.addItem('local_user', user);

      authenticationBloc.add(AuthenticationStatusChanged(
        AuthenticationStatus.authenticated,
        user,
      ));

      yield state.copyWith(status: FormStatus.submissionSuccess);
    } catch (error) {
      yield state.copyWith(status: FormStatus.submissionFailure);
    }
  }
}
