import 'package:flutter/material.dart';

class BandejaThemeData {
  static ThemeData Theme() {
    return ThemeData(
        primaryColor: const Color(0xFF2395FF),
        primaryColorDark: const Color(0xFF2395FF),
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.light(
            primary: Color(0xFF2395FF),
            secondary: Color(0xFF2395FF),
            background: Colors.white,
            onBackground: Colors.black));
  }
}
