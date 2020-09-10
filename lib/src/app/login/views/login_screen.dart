import 'package:flutter/material.dart';

import 'package:flutter_pokeapi/src/app/login/widgets/auth_dialog.dart';
import 'package:flutter_pokeapi/src/app/login/widgets/login_app_bar.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(appBar: LoginAppBar(), body: AuthDialog()));
  }
}
