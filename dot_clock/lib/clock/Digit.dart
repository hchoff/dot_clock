import 'package:dot_clock/characters/digits.dart';
import 'package:dot_clock/util.dart';
import 'package:flutter/material.dart';

class Digit extends StatefulWidget {
  final List<String> number;
  Digit({this.number});

  @override
  _DigitState createState() => _DigitState();
}

class _DigitState extends State<Digit> {
  @override
  Widget build(BuildContext context) {
    List<List<int>> firstDigitList = getDigitList(int.parse(widget.number[0]));
    List<List<int>> secondDigitList = getDigitList(int.parse(widget.number[1]));

    List<Widget> firstDigit = createDots(firstDigitList, false);
    List<Widget> secondDigit = createDots(secondDigitList, false);

    return Row(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: firstDigit,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: secondDigit,
          ),
        )
      ],
    );
  }

  getDigitList(int number) {
    switch (number) {
      case 0:
        return zeroList;
      case 1:
        return oneList;
      case 2:
        return twoList;
      case 3:
        return threeList;
      case 4:
        return fourList;
      case 5:
        return fiveList;
      case 6:
        return sixList;
      case 7:
        return sevenList;
      case 8:
        return eightList;
      case 9:
        return nineList;
      default:
        return emptyList;
    }
  }
}
