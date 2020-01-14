import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String text;
  final double fontSize;
  StyledText(this.text, {this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: fontSize, color: Colors.white, fontFamily: "Ubuntu"));
  }
}
