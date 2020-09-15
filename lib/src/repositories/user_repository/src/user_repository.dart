import 'package:dio/dio.dart';

import '../models/models.dart';
import './utils.dart';

class UserRepository {
  Dio _dio;
  User _user;

  UserRepository() : _dio = Dio();

  Future<User> getUser(UserInfoRequest userInfoRequest) async {
    if (_user != null) return _user;

    final requestUrl =
        "${UserRepositoryUtils.userInfoUrl}${UserRepositoryUtils.apiKey}";

    final response =
        await _dio.post(requestUrl, data: userInfoRequest.toJson());

    final user = User.fromMap(response.data['users'][0]);

    _user = user;
    return _user;
  }

  Future<User> updateUserInfo(UserUpdateRequest userUpdateRequest) async {
    // TODO - implementar exceções
    if (userUpdateRequest == null) return null;

    final requestUrl =
        "${UserRepositoryUtils.userUpdateUrl}${UserRepositoryUtils.apiKey}";

    final response =
        await _dio.post(requestUrl, data: userUpdateRequest.toJson());

    return User.fromMap(response.data);
  }
}
