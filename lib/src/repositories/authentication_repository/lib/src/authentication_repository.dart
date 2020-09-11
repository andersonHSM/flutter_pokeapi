import 'dart:async';

import 'package:dio/dio.dart';

import '../authentication_repository.dart';
import 'utils.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  Dio dio;
  final _controller = StreamController<AuthenticationStatus>();

  AuthenticationRepository() : dio = Dio();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<SignupReturn> signUp(AuthRequest authRequest) async {
    if (authRequest.email == null ||
        authRequest.password == null ||
        authRequest.returnSecureToken != true) {
      return null;
    }

    final signUpUrl =
        "${AuthenticationRepositoryUtils.signUpUrl}${AuthenticationRepositoryUtils.apiKey}";

    final Response apiResponse =
        await dio.post(signUpUrl, data: authRequest.toJson());

    final signUpReturn = SignupReturn.fromMap(apiResponse.data);

    _controller.add(AuthenticationStatus.authenticated);

    return signUpReturn;
  }

  Future<SignInReturn> logIn(AuthRequest authRequest) async {
    if (authRequest.email == null ||
        authRequest.password == null ||
        authRequest.returnSecureToken != true) {
      return null;
    }

    final signInUrl =
        "${AuthenticationRepositoryUtils.signInUrl}${AuthenticationRepositoryUtils.apiKey}";

    final Response apiReponse =
        await dio.post(signInUrl, data: authRequest.toJson());

    final signInReturn = SignInReturn.fromMap(apiReponse.data);

    return signInReturn;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
