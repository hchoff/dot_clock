import 'dart:async';
import 'dart:math';

import 'package:devicelocale/devicelocale.dart';
import 'package:dot_clock/clock/Meridiem.dart';
import 'package:dot_clock/clock/Separator.dart';
import 'package:dot_clock/complications/DateComplication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math.dart';

import 'clock/Digit.dart';

class FluidClock extends StatefulWidget {
  final ClockModel model;
  FluidClock(this.model);

  @override
  _FluidClockState createState() => _FluidClockState();
}

class _FluidClockState extends State<FluidClock>
    with SingleTickerProviderStateMixin {
  Color foregroundGradientStart;
  Color foregroundGradientEnd;
  Color backgroundGradientStart;
  Color backgroundGradientEnd;
  DateTime _now = DateTime.now();
  String _condition;
  double _temperature;
  String _temperatureUnit;
  String _locale;
  double _temperatureLow;
  double _temperatureHigh;
  bool _is24H;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    initializeDateFormatting();
    _updateTime();
    _updateModel();
    _updateLocale();
  }

  @override
  Widget build(BuildContext context) {
    final second = DateFormat("ss").format(_now).split("");
    final minute = DateFormat("mm").format(_now).split("");
    final hour24 = DateFormat("HH").format(_now).split("");
    final hour = DateFormat("hh").format(_now).split("");

    if (Theme.of(context).brightness == Brightness.light) {
      foregroundGradientEnd = Color.fromRGBO(210, 210, 210, 1);
      foregroundGradientStart = Color.fromRGBO(255, 255, 255, 1);
      backgroundGradientStart = Color.fromRGBO(109, 213, 237, 1);
      backgroundGradientEnd = Color.fromRGBO(33, 147, 176, 1);
    } else {
      foregroundGradientEnd = Color.fromRGBO(44, 62, 80, 1);
      foregroundGradientStart = Color.fromRGBO(76, 161, 175, 1);
      backgroundGradientStart = Color.fromRGBO(39, 39, 39, 1);
      backgroundGradientEnd = Color.fromRGBO(19, 19, 19, 1);
    }

    DateTime today = DateTime(_now.year, _now.month, _now.day);
    Duration diff = _now.difference(today);

    double secondDegree = 360 / 86400;

    double y = cos(radians(diff.inSeconds * secondDegree));
    double x = sin(radians(diff.inSeconds * secondDegree));

    return Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [backgroundGradientStart, backgroundGradientEnd],
                begin: Alignment(x, y),
                end: Alignment(-x, -y))),
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment(x, y),
              end: Alignment(-x, -y),
              colors: <Color>[foregroundGradientStart, foregroundGradientEnd],
            ).createShader(bounds);
          },
          child: Column(
            children: <Widget>[
              DateComplication(
                condition: _condition,
                temperature: _temperature,
                temperatureLow: _temperatureLow,
                temperatureHigh: _temperatureHigh,
                temperatureUnit: _temperatureUnit,
                time: _now,
                locale: _locale,
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Digit(number: _is24H ? hour24 : hour),
                    Separator(),
                    Digit(number: minute),
                    Separator(),
                    Digit(number: second)
                  ],
                ),
              ),
              Meridiem(is24H: _is24H),
            ],
          ),
        ));
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  void _updateModel() {
    _temperature = widget.model.temperature;
    _temperatureLow = widget.model.low;
    _temperatureHigh = widget.model.high;
    _condition = widget.model.weatherString;
    _is24H = widget.model.is24HourFormat;
    _temperatureUnit = widget.model.unitString;
  }

  void _updateLocale() async {
    String deviceLocale = await Devicelocale.currentLocale;
    String languageCode = deviceLocale.substring(0, 2);

    if (DateFormat.localeExists(languageCode))
      _locale = languageCode;
    else
      _locale = "en";
  }

  @override
  void didUpdateWidget(FluidClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }
}
