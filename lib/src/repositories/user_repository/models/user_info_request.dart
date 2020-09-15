import 'dart:convert';

import 'package:meta/meta.dart';

class UserInfoRequest {
  final String idToken;

  UserInfoRequest({
    @required this.idToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'idToken': idToken,
    };
  }

  factory UserInfoRequest.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserInfoRequest(
      idToken: map['idToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfoRequest.fromJson(String source) =>
      UserInfoRequest.fromMap(json.decode(source));

  UserInfoRequest copyWith({
    String idToken,
  }) {
    return UserInfoRequest(
      idToken: idToken ?? this.idToken,
    );
  }
}
