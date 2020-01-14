import 'package:dot_clock/util.dart';
import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> separator = createDots(separatorList, false);

    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: separator,
      ),
    );
  }

  final List<List<int>> separatorList = [
    [0],
    [0],
    [1],
    [0],
    [1],
    [0],
    [0],
  ];
}
