import 'package:dio/dio.dart';

import '../models/models.dart';
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

    final user = User.fromMap(response.data['users'][0]);

    _user = user;
    return _user;
  }

  Future<void> updateUserInfo(UserUpdateRequest userUpdateRequest) async {
    // TODO - implementar exceções
    if (userUpdateRequest == null) return null;

    final requestUrl =
        "${UserRepositoryUtils.userUpdateUrl}${UserRepositoryUtils.apiKey}";

    await dio.post(requestUrl, data: userUpdateRequest.toJson());
  }
}
