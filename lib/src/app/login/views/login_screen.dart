import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokeapi/src/app/login/bloc/login_bloc.dart';

import 'package:flutter_pokeapi/src/app/login/widgets/auth_dialog.dart';
import 'package:flutter_pokeapi/src/app/login/widgets/login_app_bar.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    

    BlocProvider.of<LoginBloc>(context).add(LoginTryAutoLogin());

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(appBar: LoginAppBar(), body: AuthDialog()));
  }
}
