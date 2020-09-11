// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      idToken: fields[1] as String,
      localId: fields[2] as String,
      email: fields[3] as String,
      emailVerified: fields[4] as bool,
      displayName: fields[5] as String,
      providerUserInfo: (fields[6] as List)?.cast<ProviderUserInfo>(),
      photoUrl: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.idToken)
      ..writeByte(2)
      ..write(obj.localId)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.emailVerified)
      ..writeByte(5)
      ..write(obj.displayName)
      ..writeByte(6)
      ..write(obj.providerUserInfo)
      ..writeByte(7)
      ..write(obj.photoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProviderUserInfoAdapter extends TypeAdapter<ProviderUserInfo> {
  @override
  final int typeId = 1;

  @override
  ProviderUserInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProviderUserInfo(
      providerId: fields[1] as String,
      displayName: fields[2] as String,
      photoUrl: fields[3] as String,
      federatedId: fields[4] as String,
      email: fields[5] as String,
      rawId: fields[6] as String,
      screenName: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProviderUserInfo obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.providerId)
      ..writeByte(2)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.photoUrl)
      ..writeByte(4)
      ..write(obj.federatedId)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.rawId)
      ..writeByte(7)
      ..write(obj.screenName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProviderUserInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
