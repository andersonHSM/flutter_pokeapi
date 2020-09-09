import 'dart:convert';

import 'package:meta/meta.dart';

class AuthRequest {
  final String email;
  final String password;
  final bool returnSecureToken;

  AuthRequest({
    @required this.email,
    @required this.password,
    this.returnSecureToken = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'returnSecureToken': returnSecureToken,
    };
  }

  factory AuthRequest.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AuthRequest(
      email: map['email'],
      password: map['password'],
      returnSecureToken: map['returnSecureToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthRequest.fromJson(String source) =>
      AuthRequest.fromMap(json.decode(source));
}
