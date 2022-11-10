import 'package:flutter/material.dart';

class BandejaThemeData {
  static ThemeData Theme() {
    return ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.light(
            secondary: Colors.blueAccent,
            background: Colors.white,
            onBackground: Colors.black));
  }
}
