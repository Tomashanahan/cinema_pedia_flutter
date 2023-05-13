import 'package:flutter/material.dart';

List<Color> appThemeColors = [
  Colors.yellowAccent,
  Colors.amber,
  Colors.amberAccent,
  Colors.blueAccent,
  Colors.cyanAccent,
  Colors.deepOrangeAccent,
  Colors.greenAccent,
  Colors.pink,
];

class AppTheme {
  ThemeData appTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: appThemeColors[0],
    );
  }
}
