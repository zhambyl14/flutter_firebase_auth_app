import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  final Function reset;
  final String text;

  ResetButton(this.reset, this.text);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => reset(),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text("Reset"),
    );
  }
}
