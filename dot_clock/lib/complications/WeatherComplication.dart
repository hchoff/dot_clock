import 'package:dot_clock/StyledText.dart';
import 'package:flutter/material.dart';

class WeatherInformation extends StatelessWidget {
  final double temperature;
  final double temperatureHigh;
  final double temperatureLow;
  final String unit;
  final String condition;

  WeatherInformation(
      {this.temperature,
      this.temperatureHigh,
      this.temperatureLow,
      this.unit,
      this.condition});

  @override
  Widget build(BuildContext context) {
    String temperatureString = temperature.round().toString() + " " + unit;
    String temperatureLowString =
        temperatureLow.round().toString() + " " + unit;
    String temperatureHighString =
        temperatureHigh.round().toString() + " " + unit;
    String iconPath = "assets/icons/" + condition + ".png";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: StyledText(temperatureString, fontSize: 60),
            ),
            Image.asset(iconPath, color: Colors.white, height: 120),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 20),
              child: Row(
                children: <Widget>[
                  Icon(Icons.arrow_upward, size: 25, color: Colors.white),
                  StyledText(temperatureHighString, fontSize: 25)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 20),
              child: Row(
                children: <Widget>[
                  Icon(Icons.arrow_downward, size: 25, color: Colors.white),
                  StyledText(temperatureLowString, fontSize: 25)
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
