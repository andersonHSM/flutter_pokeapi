part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginTryAutoLogin extends LoginEvent {
  const LoginTryAutoLogin();

  @override
  List<Object> get props => [];
}

class LoginReset extends LoginEvent {
  const LoginReset();

  @override
  List<Object> get props => [];
}

class LoginDisplayNamelChanged extends LoginEvent {
  final String displayName;

  const LoginDisplayNamelChanged(this.displayName);

  @override
  List<Object> get props => [displayName];
}

class LoginEmailChanged extends LoginEvent {
  final String email;

  const LoginEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class LoginPasswordConfirmChanged extends LoginEvent {
  final String passwordConfirm;

  const LoginPasswordConfirmChanged(this.passwordConfirm);

  @override
  List<Object> get props => [passwordConfirm];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();

  @override
  List<Object> get props => [];
}

class SignupSubmitted extends LoginEvent {
  const SignupSubmitted();

  @override
  List<Object> get props => [];
}
