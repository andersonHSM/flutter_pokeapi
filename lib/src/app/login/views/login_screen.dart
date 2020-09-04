import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/src/app/login/widgets/login_app_bar.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(appBar: LoginAppBar(), body: LoginForm()));
  }
}

// TODO - refatorar
class LoginForm extends StatelessWidget {
  void _showFormDialog(BuildContext context, Size mediaQuerySize) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: mediaQuerySize.width * 0.8,
            height: mediaQuerySize.height * 0.6,
            child: Center(child: Text('oi')),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;
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
              onPressed: () => _showFormDialog(context, mediaQuerySize),
              child: Text('Login'),
            ),
            SizedBox(height: 5),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: () => _showFormDialog(context, mediaQuerySize),
              child: Text('Cadastro'),
            ),
          ],
        ),
      ),
    );
  }
}
