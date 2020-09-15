import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends Equatable {
  @HiveField(1)
  final String idToken;
  @HiveField(2)
  final String localId;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final bool emailVerified;
  @HiveField(5)
  final String displayName;
  @HiveField(6)
  final List<ProviderUserInfo> providerUserInfo;
  @HiveField(7)
  final String photoUrl;

  User({
    this.idToken,
    this.localId,
    this.email,
    this.emailVerified,
    this.displayName,
    this.providerUserInfo,
    this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'idToken': idToken,
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
      idToken: map['idToken'],
      localId: map['localId'],
      email: map['email'],
      emailVerified: map['emailVerified'],
      displayName: map['displayName'],
      providerUserInfo: List<ProviderUserInfo>.from(
        map['providerUserInfo']?.map(
              (x) => ProviderUserInfo.fromMap(x),
            ) ??
            null,
      ),
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String idToken,
    String localId,
    String email,
    bool emailVerified,
    String displayName,
    List<ProviderUserInfo> providerUserInfo,
    String photoUrl,
  }) {
    return User(
      idToken: idToken ?? this.idToken,
      localId: localId ?? this.localId,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      displayName: displayName ?? this.displayName,
      providerUserInfo: providerUserInfo ?? this.providerUserInfo,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  List<Object> get props => [
        idToken,
        localId,
        email,
        emailVerified,
        displayName,
        providerUserInfo,
        photoUrl
      ];
}

@HiveType(typeId: 1)
class ProviderUserInfo extends Equatable {
  @HiveField(1)
  final String providerId;
  @HiveField(2)
  final String displayName;
  @HiveField(3)
  final String photoUrl;
  @HiveField(4)
  final String federatedId;
  @HiveField(5)
  final String email;
  @HiveField(6)
  final String rawId;
  @HiveField(7)
  final String screenName;

  ProviderUserInfo({
    this.providerId,
    this.displayName,
    this.photoUrl,
    this.federatedId,
    this.email,
    this.rawId,
    this.screenName,
  });

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
