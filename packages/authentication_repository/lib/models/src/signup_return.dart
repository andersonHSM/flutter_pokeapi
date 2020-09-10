import 'dart:convert';

class SignupReturn {
  final String idToken;
  final String email;
  final String refreshToken;
  final String expiresIn;
  final String localId;

  SignupReturn(
      {this.idToken,
      this.email,
      this.refreshToken,
      this.expiresIn,
      this.localId});

  Map<String, dynamic> toMap() {
    return {
      'idToken': idToken,
      'email': email,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
      'localId': localId,
    };
  }

  factory SignupReturn.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SignupReturn(
      idToken: map['idToken'],
      email: map['email'],
      refreshToken: map['refreshToken'],
      expiresIn: map['expiresIn'],
      localId: map['localId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupReturn.fromJson(String source) =>
      SignupReturn.fromMap(json.decode(source));

  SignupReturn copyWith({
    String idToken,
    String email,
    String refreshToken,
    String expiresIn,
    String localId,
  }) {
    return SignupReturn(
      idToken: idToken ?? this.idToken,
      email: email ?? this.email,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
      localId: localId ?? this.localId,
    );
  }
}
