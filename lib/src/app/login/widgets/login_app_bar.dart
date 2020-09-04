import 'package:flutter/material.dart';

class LoginAppBar extends StatelessWidget with PreferredSizeWidget {
  const LoginAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(300),
      child: ClipPath(
        clipper: _ClipLoginBar(),
        child: Container(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 10,
              height: 10,
              child: Image(image: AssetImage('lib/assets/pokemon-logo.png')),
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.red[700], Colors.red[800]],
                begin: Alignment.bottomCenter,
                end: Alignment.topRight),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(200);
}

class _ClipLoginBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    const offsetSize = 50.0;

    path.lineTo(0, size.height - offsetSize);

    final controlPointLeft = Offset(0, size.height);
    final endPointLeft = Offset(size.width * 0.25, size.height);

    path.quadraticBezierTo(
      controlPointLeft.dx,
      controlPointLeft.dy,
      endPointLeft.dx,
      endPointLeft.dy,
    );

    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - offsetSize);

    final controlPointRight = Offset(size.width, size.height);
    final endPointRight = Offset(size.width * 0.75, size.height);

    path.quadraticBezierTo(
      controlPointRight.dx,
      controlPointRight.dy,
      endPointRight.dx,
      endPointRight.dy,
    );

    path.lineTo(size.width * 0.25, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
