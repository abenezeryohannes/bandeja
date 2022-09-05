import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

String fixture(String name) => File("assets/fixtures/$name").readAsStringSync();

Future<String> fixturesFromAsset(String name) async =>
    rootBundle.loadString('assets/fixtures/$name');
