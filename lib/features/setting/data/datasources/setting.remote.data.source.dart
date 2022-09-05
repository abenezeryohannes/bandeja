import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/setting.dart';
import '../models/setting.model.dart';

class SettingRemoteDataSource {
  late http.Client client;

  FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: Firebase.apps.first,
      databaseURL:
          "https://sawetapps-default-rtdb.europe-west1.firebasedatabase.app/");

  SettingRemoteDataSource({required this.client});

  Future<SettingModel>? getSetting() async {
    DatabaseReference ref = await database.ref().child('setting');
    final snapshot = await ref.get();

    if (!snapshot.exists) throw NoDataException();

    Map<String, dynamic> map = json.decode(json.encode(snapshot.value));

    return SettingModel.fromJson(map);
  }

  Future<Setting>? saveSetting(SettingModel setting) async {
    final snapshot = await database.ref().child('setting').get();
    DatabaseReference ref;
    if (snapshot.exists) {
      ref = database.ref().child("setting");
    } else {
      ref = database.ref().child("setting").push();
      if (ref.key == null) {
        throw ServerSideException(message: Failure.FIREBASE_KEY);
      }
      setting.id = ref.key!;
    }
    await ref.set(setting.toJson());

    return setting;
  }
}
