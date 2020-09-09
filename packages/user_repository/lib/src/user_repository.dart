import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/models.dart';
import '../user_repository.dart';
import '../user_repository.dart';

class UserRepository {
  Dio dio;
  User _user;

  UserRepository() : dio = Dio();

  Future<User> getUser(UserInfoRequest userInfoRequest) async {
    if (_user != null) return _user;

    final requestUrl =
        "${UserRepositoryUtils.userInfoUrl}${UserRepositoryUtils.apiKey}";

    final response = await dio.post(requestUrl, data: userInfoRequest.toJson());

    final user = User.fromJson(json.decode(response.data));

    _user = user;
    return _user;
  }
}
