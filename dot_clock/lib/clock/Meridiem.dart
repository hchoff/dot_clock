import 'package:dot_clock/characters/letters.dart';
import 'package:dot_clock/util.dart';
import 'package:flutter/material.dart';

class Meridiem extends StatelessWidget {
  final bool is24H;
  Meridiem({this.is24H});

  @override
  Widget build(BuildContext context) {
    if (is24H) {
      return Expanded(
        flex: 1,
        child: Container(),
      );
    }

    List<Widget> firstDigit = createDots(letterP, true);
    List<Widget> secondDigit = createDots(letterM, true);

    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: firstDigit,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: secondDigit,
            ),
          )
        ],
      ),
    );
  }
}
