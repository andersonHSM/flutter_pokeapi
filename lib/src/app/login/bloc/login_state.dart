part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final FormStatus status;
  final String email;
  final String emailError;
  final String displayName;
  final String displayNameError;
  final String password;
  final String passwordError;
  final String passwordConfirm;
  final String passwordConfirmError;

  const LoginState({
    this.status,
    this.email,
    this.emailError,
    this.displayName,
    this.displayNameError,
    this.password,
    this.passwordError,
    this.passwordConfirm,
    this.passwordConfirmError,
  });

  @override
  List<Object> get props => [
        status,
        email,
        emailError,
        displayName,
        displayNameError,
        password,
        passwordError,
        passwordConfirm,
        passwordConfirmError,
      ];

  LoginState copyWith({
    FormStatus status,
    String email,
    String emailError,
    String displayName,
    String displayNameError,
    String password,
    String passwordError,
    String passwordConfirm,
    String passwordConfirmError,
  }) {
    return LoginState(
      status: status,
      email: email ?? this.email,
      emailError: emailError,
      displayName: displayName ?? this.displayName,
      displayNameError: displayNameError,
      password: password ?? this.password,
      passwordError: passwordError,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      passwordConfirmError: passwordConfirmError,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'email': email,
      'emailError': emailError,
      'displayName': displayName,
      'displayNameError': displayNameError,
      'password': password,
      'passwordError': passwordError,
      'passwordConfirm': passwordConfirm,
      'passwordConfirmError': passwordConfirmError,
    };
  }

  factory LoginState.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return LoginState(
      status: map['status'],
      email: map['email'],
      emailError: map['emailError'],
      displayName: map['displayName'],
      displayNameError: map['displayNameError'],
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
