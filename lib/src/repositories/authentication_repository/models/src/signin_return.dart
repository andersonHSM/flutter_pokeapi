import 'dart:convert';

class SignInReturn {
  String localId;
  String email;
  String displayName;
  String idToken;
  bool registered;
  String refreshToken;
  String expiresIn;

  SignInReturn(
      {this.localId,
      this.email,
      this.displayName,
      this.idToken,
      this.registered,
      this.refreshToken,
      this.expiresIn});

  Map<String, dynamic> toMap() {
    return {
      'localId': localId,
      'email': email,
      'displayName': displayName,
      'idToken': idToken,
      'registered': registered,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
    };
  }

  factory SignInReturn.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SignInReturn(
      localId: map['localId'],
      email: map['email'],
      displayName: map['displayName'],
      idToken: map['idToken'],
      registered: map['registered'],
      refreshToken: map['refreshToken'],
      expiresIn: map['expiresIn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInReturn.fromJson(String source) =>
      SignInReturn.fromMap(json.decode(source));
}
