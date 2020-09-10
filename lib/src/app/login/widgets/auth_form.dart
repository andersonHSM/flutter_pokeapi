import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/src/app/login/utils/auth_form_type.enum.dart';

class AuthForm extends StatelessWidget {
  final AuthFormType authFormType;

  AuthForm({@required this.authFormType}) : assert(authFormType != null);

  Widget emailField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "E-mail"),
    );
  }

  Widget passwordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Password"),
    );
  }

  Widget confirmPasswordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Confirm Password"),
    );
  }

  Widget submitButton({Color buttonColor, Color textColor}) {
    return RaisedButton(
        onPressed: () {},
        child: Text(
          "Submit",
          style: TextStyle(color: textColor ?? Colors.white),
        ),
        color: buttonColor ?? Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;

    return Container(
      width: mediaQuerySize.width * 0.8,
      height: mediaQuerySize.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            emailField(),
            SizedBox(height: 10),
            passwordField(),
            SizedBox(height: 10),
            if (authFormType == AuthFormType.signUp) ...[
              confirmPasswordField(),
              SizedBox(height: 10),
            ],
            submitButton(
              buttonColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
