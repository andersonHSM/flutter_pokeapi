import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String localId;
  final String email;
  final bool emailVerified;
  final String displayName;
  final List<ProviderUserInfo> providerUserInfo;
  final String photoUrl;

  User({
    this.localId,
    this.email,
    this.emailVerified,
    this.displayName,
    this.providerUserInfo,
    this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'localId': localId,
      'email': email,
      'emailVerified': emailVerified,
      'displayName': displayName,
      'providerUserInfo': providerUserInfo?.map((x) => x?.toMap())?.toList(),
      'photoUrl': photoUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      localId: map['localId'],
      email: map['email'],
      emailVerified: map['emailVerified'],
      displayName: map['displayName'],
      providerUserInfo: List<ProviderUserInfo>.from(
          map['providerUserInfo']?.map((x) => ProviderUserInfo.fromMap(x))),
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String localId,
    String email,
    bool emailVerified,
    String displayName,
    List<ProviderUserInfo> providerUserInfo,
    String photoUrl,
  }) {
    return User(
      localId: localId ?? this.localId,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      displayName: displayName ?? this.displayName,
      providerUserInfo: providerUserInfo ?? this.providerUserInfo,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  List<Object> get props =>
      [localId, email, emailVerified, displayName, providerUserInfo, photoUrl];
}

class ProviderUserInfo extends Equatable {
  final String providerId;
  final String displayName;
  final String photoUrl;
  final String federatedId;
  final String email;
  final String rawId;
  final String screenName;

  ProviderUserInfo(
      {this.providerId,
      this.displayName,
      this.photoUrl,
      this.federatedId,
      this.email,
      this.rawId,
      this.screenName});

  Map<String, dynamic> toMap() {
    return {
      'providerId': providerId,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'federatedId': federatedId,
      'email': email,
      'rawId': rawId,
      'screenName': screenName,
    };
  }

  factory ProviderUserInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProviderUserInfo(
      providerId: map['providerId'],
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      federatedId: map['federatedId'],
      email: map['email'],
      rawId: map['rawId'],
      screenName: map['screenName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProviderUserInfo.fromJson(String source) =>
      ProviderUserInfo.fromMap(json.decode(source));

  ProviderUserInfo copyWith({
    String providerId,
    String displayName,
    String photoUrl,
    String federatedId,
    String email,
    String rawId,
    String screenName,
  }) {
    return ProviderUserInfo(
      providerId: providerId ?? this.providerId,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      federatedId: federatedId ?? this.federatedId,
      email: email ?? this.email,
      rawId: rawId ?? this.rawId,
      screenName: screenName ?? this.screenName,
    );
  }

  @override
  List<Object> get props => [
        providerId,
        displayName,
        photoUrl,
        federatedId,
        email,
        rawId,
        screenName
      ];
}
