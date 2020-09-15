import 'dart:convert';

import 'package:meta/meta.dart';

class UserUpdateRequest {
  final String idToken;
  final String displayName;
  final String photoUrl;
  final bool returnSecureToken;

  UserUpdateRequest({
    @required this.idToken,
    this.displayName,
    this.photoUrl,
    this.returnSecureToken = true,
  });

  UserUpdateRequest copyWith({
    String idToken,
    String displayName,
    String photoUrl,
    bool returnSecureToken,
  }) {
    return UserUpdateRequest(
      idToken: idToken ?? this.idToken,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      returnSecureToken: returnSecureToken ?? this.returnSecureToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idToken': idToken,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'returnSecureToken': returnSecureToken,
    };
  }

  factory UserUpdateRequest.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserUpdateRequest(
      idToken: map['idToken'],
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      returnSecureToken: map['returnSecureToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserUpdateRequest.fromJson(String source) =>
      UserUpdateRequest.fromMap(json.decode(source));
}
