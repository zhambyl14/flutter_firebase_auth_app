import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final Size size;

  MyTitle(this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.10,
      padding: EdgeInsets.all(5.0),
      child: Text(
        "Jigsaw Puzzle",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size.height * 0.050,
          color: const Color.fromARGB(255, 0, 0, 0),
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
