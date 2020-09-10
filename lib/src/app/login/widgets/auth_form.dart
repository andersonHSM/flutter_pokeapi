import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokeapi/src/app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_pokeapi/src/app/login/bloc/login_bloc.dart';
import 'package:flutter_pokeapi/src/app/login/utils/auth_form_type.enum.dart';
import 'package:flutter_pokeapi/src/app/login/utils/form_status.dart';

class AuthForm extends StatelessWidget {
  final AuthFormType authFormType;

  AuthForm({@required this.authFormType}) : assert(authFormType != null);

  Widget emailField(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.email != current.email ||
          previous.emailError != current.emailError,
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            labelText: "E-mail",
            errorText: state.emailError,
          ),
          onChanged: (email) {
            context.bloc<LoginBloc>().add(LoginEmailChanged(email));
          },
        );
      },
    );
  }

  Widget passwordField(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.passwordError != current.passwordError,
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            labelText: "Password",
            errorText: state.passwordError,
          ),
          onChanged: (password) {
            context.bloc<LoginBloc>().add(LoginPasswordChanged(password));
          },
        );
      },
    );
  }

  Widget confirmPasswordField(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.passwordConfirm != current.passwordConfirm ||
          previous.passwordConfirmError != current.passwordConfirmError,
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            labelText: "Confirm Password",
            errorText: state.passwordConfirmError,
          ),
          onChanged: (passwordConfirm) {
            context
                .bloc<LoginBloc>()
                .add(LoginPasswordConfirmChanged(passwordConfirm));
          },
        );
      },
    );
  }

  Widget submitButton(BuildContext context,
      {Color buttonColor, Color textColor}) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          children: [
            RaisedButton(
                onPressed: state.status == FormStatus.invalid
                    ? null
                    : () {
                        if (authFormType == AuthFormType.signUp) {
                          context.bloc<LoginBloc>().add(SignupSubmitted());
                        } else {
                          context.bloc<LoginBloc>().add(LoginSubmitted());
                        }
                      },
                child: Text(
                  "Submit",
                  style: TextStyle(color: textColor ?? Colors.white),
                ),
                color: buttonColor ?? Colors.black),
            if (state.status == FormStatus.submissionFailure)
              Text('Request Failure'),
          ],
        );
      },
    );
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
            emailField(context),
            SizedBox(height: 10),
            passwordField(context),
            SizedBox(height: 10),
            if (authFormType == AuthFormType.signUp) ...[
              confirmPasswordField(context),
              SizedBox(height: 10),
            ],
            submitButton(
              context,
              buttonColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
