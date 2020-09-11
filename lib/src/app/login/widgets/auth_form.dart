import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokeapi/src/app/login/bloc/login_bloc.dart';
import 'package:flutter_pokeapi/src/app/login/utils/auth_form_type.enum.dart';
import 'package:flutter_pokeapi/src/app/login/utils/form_status.dart';

class AuthForm extends StatelessWidget {
  final AuthFormType authFormType;

  AuthForm({@required this.authFormType}) : assert(authFormType != null);

  Widget displayNameField(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.displayNameError != current.displayNameError,
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            labelText: "Your name *",
            errorText: state.displayNameError,
          ),
          onChanged: (displayName) {
            context
                .bloc<LoginBloc>()
                .add(LoginDisplayNamelChanged(displayName));
          },
        );
      },
    );
  }

  Widget emailField(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.emailError != current.emailError,
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            labelText: "E-mail *",
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
          previous.passwordError != current.passwordError,
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            labelText: "Password *",
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
          previous.passwordConfirmError != current.passwordConfirmError,
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            labelText: "Confirm Password *",
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
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == FormStatus.submissionSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final buttonText = Text(
          "Submit",
          style: TextStyle(color: textColor ?? Colors.white),
        );
        Widget buttonChild;

        if (state.status == FormStatus.submissionInProgress) {
          buttonChild = CircularProgressIndicator();
        } else if (state.status != FormStatus.invalid) {
          buttonChild = buttonText;
        }

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
                child: buttonChild,
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

    return SingleChildScrollView(
      child: Container(
        width: mediaQuerySize.width * 0.8,
        height: mediaQuerySize.height * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              if (authFormType == AuthFormType.signUp) ...[
                displayNameField(context),
                SizedBox(height: 10),
              ],
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
      ),
    );
  }
}
