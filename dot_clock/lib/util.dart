import 'package:dot_clock/clock/Dot.dart';
import 'package:flutter/material.dart';

List<Widget> createDots(List<List<int>> list, bool isLetter) {
  List<Widget> cols = List();
  for (int y = 0; y < list.length; y++) {
    List<Widget> rows = List();
    for (int x = 0; x < list[0].length; x++) {
      var box;

      if (list[y][x] == 1) {
        box = getNeighbours(y, x, list);
      }
      rows.add(Dot(opacity: list[y][x], j: x, border: box, isLetter: isLetter));
    }
    cols.add(Row(mainAxisSize: MainAxisSize.min, children: rows));
  }

  return cols;
}

getNeighbours(int y, int x, List<List<int>> list) {
  int top;
  int left;
  int right;
  int bottom;

  try {
    top = list[y - 1][x];
  } on RangeError {
    top = 0;
  }

  try {
    left = list[y][x - 1];
  } on RangeError {
    left = 0;
  }

  try {
    right = list[y][x + 1];
  } on RangeError {
    right = 0;
  }

  try {
    bottom = list[y + 1][x];
  } on RangeError {
    bottom = 0;
  }

  List<int> borders = [top, left, right, bottom];

  return borders;
}
