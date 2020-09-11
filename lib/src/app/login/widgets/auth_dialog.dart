import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokeapi/src/app/login/bloc/login_bloc.dart';
import 'package:flutter_pokeapi/src/app/login/utils/auth_form_type.enum.dart';
import 'package:flutter_pokeapi/src/app/login/widgets/auth_form.dart';

class AuthDialog extends StatelessWidget {
  void _showFormDialog(BuildContext context, AuthFormType authFormType) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<LoginBloc>(context);

    showDialog(
        context: context,
        builder: (_) {
          final dialog = Dialog(
            child: AuthForm(
              authFormType: authFormType,
            ),
          );

          return BlocProvider.value(
            value: bloc,
            child: dialog,
          );
        }).then((_) => bloc.add(LoginReset()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () => _showFormDialog(context, AuthFormType.signIn),
              child: Text('Login'),
            ),
            SizedBox(height: 5),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: () => _showFormDialog(context, AuthFormType.signUp),
              child: Text('Cadastro'),
            ),
          ],
        ),
      ),
    );
  }
}
