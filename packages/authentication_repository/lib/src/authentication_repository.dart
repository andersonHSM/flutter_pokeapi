import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../authentication_repository.dart';
import 'utils.dart';
import 'package:authentication_repository/models/models.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  Dio dio;
  final _controller = StreamController<AuthenticationStatus>();

  AuthenticationRepository() : dio = Dio();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<SignInReturn> logIn(AuthRequest authRequest) async {
    assert(authRequest.email != null);
    assert(authRequest.password != null);
    assert(authRequest.returnSecureToken == true);

    final signInUrl =
        "${AuthenticationRepositoryUtils.signInUrl}${AuthenticationRepositoryUtils.apiKey}";

    final Response apiReponse =
        await dio.post(signInUrl, data: authRequest.toJson());

    final signInReturn = SignInReturn.fromMap(json.decode(apiReponse.data));

    _controller.add(AuthenticationStatus.authenticated);
    return signInReturn;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
