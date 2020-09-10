part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final String email;
  final String emailError;
  final String password;
  final String passwordError;
  final String passwordConfirm;
  final String passwordConfirmError;

  const LoginState({
    this.email,
    this.emailError,
    this.password,
    this.passwordError,
    this.passwordConfirm,
    this.passwordConfirmError,
  });

  @override
  List<Object> get props => [
        email,
        emailError,
        password,
        passwordError,
        passwordConfirm,
        passwordConfirmError,
      ];

  LoginState copyWith({
    String email,
    String emailError,
    String password,
    String passwordError,
    String passwordConfirm,
    String passwordConfirmError,
  }) {
    return LoginState(
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      passwordConfirmError: passwordConfirmError ?? this.passwordConfirmError,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'emailError': emailError,
      'password': password,
      'passwordError': passwordError,
      'passwordConfirm': passwordConfirm,
      'passwordConfirmError': passwordConfirmError,
    };
  }

  factory LoginState.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return LoginState(
      email: map['email'],
      emailError: map['emailError'],
      password: map['password'],
      passwordError: map['passwordError'],
      passwordConfirm: map['passwordConfirm'],
      passwordConfirmError: map['passwordConfirmError'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginState.fromJson(String source) =>
      LoginState.fromMap(json.decode(source));
}
