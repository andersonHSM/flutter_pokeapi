import 'dart:ui';

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: ClipPath(
            clipper: _ClipLoginBar(),
            child: Container(
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoginForm(),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blueGrey, Colors.black26],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topRight),
              ),
            ),
          ),
        ),
        preferredSize: Size(double.infinity, 300),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'E-mail *',
            labelStyle: TextStyle(color: Colors.black),
            focusColor: Colors.black,
            hoverColor: Colors.black,
          ),
        ),
      ],
    );
  }
}

class _ClipLoginBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    const offsetSize = 50.0;

    path.lineTo(0, size.height - offsetSize);

    final controlPointLeft = Offset(offsetSize, size.height);
    final endPointLeft = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(
      controlPointLeft.dx,
      controlPointLeft.dy,
      endPointLeft.dx,
      endPointLeft.dy,
    );

    path.close();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - offsetSize);

    final controlPointRight = Offset(size.width, size.height);
    final endPointRight = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(
      controlPointRight.dx,
      controlPointRight.dy,
      endPointRight.dx,
      endPointRight.dy,
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
