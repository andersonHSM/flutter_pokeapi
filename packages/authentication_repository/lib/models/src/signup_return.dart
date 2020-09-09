class LoginReturn {
  final String idToken;
  final String email;
  final String refreshToken;
  final String expiresIn;
  final String localId;

  LoginReturn(
      {this.idToken,
      this.email,
      this.refreshToken,
      this.expiresIn,
      this.localId});
}
