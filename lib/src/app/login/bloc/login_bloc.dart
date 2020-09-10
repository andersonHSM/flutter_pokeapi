import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_pokeapi/src/app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_pokeapi/src/app/login/utils/form_status.dart';
import 'package:flutter_pokeapi/src/utils/form_validations.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;
  final AuthenticationBloc _authenticationBloc;

  LoginBloc({
    @required AuthenticationRepository authenticationRepository,
    @required AuthenticationBloc authenticationBloc,
  })  : assert(authenticationRepository != null),
        assert(authenticationBloc != null),
        _authenticationRepository = authenticationRepository,
        _authenticationBloc = authenticationBloc,
        super(LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginPasswordConfirmChanged) {
      yield _mapPasswordConfirmChangedToState(event, state);
    } else if (event is SignupSubmitted) {
      yield* _mapSignupSubmittedToState(state);
    } else if (event is LoginSubmitted) {
      print(_authenticationBloc);
      yield* _mapLoginSubmittedToState(state, _authenticationBloc);
    }
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

  Stream<LoginState> _mapSignupSubmittedToState(LoginState state) async* {
    if (state.status == FormStatus.valid) {
      yield state.copyWith(status: FormStatus.submissionInProgress);
      final authRequest = _getAuthRequestObject(state);

      try {
        await _authenticationRepository.signUp(authRequest);

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
      final user = await _authenticationRepository.logIn(authRequest);
      authenticationBloc.add(AuthenticationStatusChanged(
        AuthenticationStatus.authenticated,
        user.idToken,
      ));

      yield state.copyWith(status: FormStatus.submissionSuccess);
    } catch (error) {
      print(error);
      yield state.copyWith(status: FormStatus.submissionFailure);
    }
  }
}
