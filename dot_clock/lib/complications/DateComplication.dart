import 'package:dot_clock/StyledText.dart';
import 'package:dot_clock/complications/WeatherComplication.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateComplication extends StatelessWidget {
  final String condition;
  final double temperature;
  final String temperatureUnit;
  final double temperatureHigh;
  final double temperatureLow;
  final String locale;
  final DateTime time;

  DateComplication(
      {this.condition,
      this.temperature,
      this.temperatureHigh,
      this.temperatureLow,
      this.temperatureUnit,
      this.time,
      this.locale});

  @override
  Widget build(BuildContext context) {
    String date = "";
    String day = "";

    if (locale != null) {
      date = DateFormat.MMMMd(locale).format(time);
      day = DateFormat.EEEE(locale).format(time);
    }

    return Expanded(
      flex: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StyledText(date, fontSize: 60),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: StyledText(day, fontSize: 40),
              ),
            ],
          ),
          WeatherInformation(
            temperature: temperature,
            condition: condition,
            unit: temperatureUnit,
            temperatureLow: temperatureLow,
            temperatureHigh: temperatureHigh,
          )
        ],
      ),
    );
  }
}
