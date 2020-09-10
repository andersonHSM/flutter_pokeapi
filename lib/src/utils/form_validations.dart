class FormValidations {
  static String emptyField(String fieldName, String value) {
    if (value.trim().length == 0) {
      return "$fieldName must not be empty!";
    }

    return null;
  }

  static String passwordConfirm(String password, String passwordConfirm) {
    if (password != passwordConfirm) {
      return "Password confirmation must match your password";
    }

    return null;
  }
}
