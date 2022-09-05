import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:app/features/authentication/data/models/user.model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../candidate/domain/entities/candidate.dart';
import '../../domain/entities/user.dart';

class UserRemoteDataSource {
  late http.Client client;

  FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: Firebase.apps.first,
      databaseURL:
          "https://sawetapps-default-rtdb.europe-west1.firebasedatabase.app/");

  UserRemoteDataSource({required this.client});

  Future<UserModel>? getUser(String user_id) async {
    DatabaseReference userRef = database.ref().child('users/${user_id}');
    final snapshot = await userRef.get();

    if (!snapshot.exists) throw NoDataException();

    Map<String, dynamic> l = json.decode(json.encode(snapshot.value));

    return UserModel.fromJson(l);
  }

  Future<User>? saveUser(UserModel user) async {
    final snapshot =
        await database.ref().child('users').orderByKey().equalTo(user.id).get();
    DatabaseReference ref;
    if (snapshot.exists) {
      ref = database.ref().child('users/${user.id}');
    } else {
      ref = database.ref().child("users").push();
      if (ref.key == null) {
        throw ServerSideException(message: Failure.FIREBASE_KEY);
      }
      user.id = ref.key!;
    }
    await ref.set(user.toJson());
    return user;
  }

  Future<User?> voteFor(
      {required Candidate candidate, required User user}) async {
    //add 1 to candidate vote and set candidate id to user vote for property

    //candidate side
    DatabaseReference canRef =
        database.ref().child('candidates/${candidate.id}');
    canRef.child("votes").set(ServerValue.increment(1));
    //user Side
    DatabaseReference userRef = database.ref().child('users/${user.id}');
    userRef.child("votedFor").set(candidate.id);
    //return the candidate;
    final snapshot = await userRef.get();
    Map<String, dynamic> l = json.decode(json.encode(snapshot.value));
    user.votedFor = l["votedFor"];
    return user;
  }

  Future<UserModel?>? getUserByPhoneNum(String identifier) async {
    DatabaseReference userRef = database.ref().child('users');

    final snapshot =
        await userRef.orderByChild('identifier').equalTo(identifier).get();

    if (!snapshot.exists) return null;

    Map<String, dynamic> map = json.decode(json.encode(snapshot.value));

    List<UserModel> users = map.values
        .where((i) => i != null)
        .map((e) => UserModel.fromJson((e)))
        .toList();

    if (users.isEmpty) return null;

    return users.first;
  }

  Future<UserModel>? getUserByUid(String uid) async {
    DatabaseReference userRef = database.ref().child('users');

    final snapshot = await userRef.orderByChild('uid').equalTo(uid).get();

    if (!snapshot.exists) return Future.value(null);

    Map<String, dynamic> l = json.decode(json.encode(snapshot.value));

    return UserModel.fromJson(l);
  }
}
