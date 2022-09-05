import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingSP {
  final String firstTime = "firstTime";
  late SharedPreferences prefs;

  SettingSP({required this.prefs});

  void saveFirstTime() async {
    String string = "true";
    prefs.setString(firstTime, string);
  }

  Future<bool> getFirstTime() async {
    String? result = prefs.getString(firstTime);
    return result == null || result != "true";
  }
}
