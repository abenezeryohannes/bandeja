import 'dart:collection';
import 'dart:convert';

import 'package:dartz/dartz_unsafe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/core/error/exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:app/features/candidate/data/models/candidate.category.model.dart';
import '../../domain/entities/candidate.dart';
import '../models/candidate.model.dart';
import 'package:firebase_database/firebase_database.dart';

class CandidateRemoteDataSource {
  late http.Client client;

  FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: Firebase.apps.first,
      databaseURL:
          "https://sawetapps-default-rtdb.europe-west1.firebasedatabase.app/");

  CandidateRemoteDataSource({required this.client});

  Future<List<CandidateModel>>? getTopVoted() async {
    final snapshot =
        await database.ref().child('candidates').orderByChild("votes").get();
    if (!snapshot.exists) {
      throw NoDataException();
    }
    Iterable l = [];
    if (snapshot.value.runtimeType == List<Object?>) {
      l = json.decode(json.encode(snapshot.value));
    } else if (snapshot.value != null) {
      Map<String?, Object?> map = json.decode(json.encode(snapshot.value));
      l = map.values;
    }

    return l
        .where((i) => i != null)
        .map((e) => CandidateModel.fromJson((e)))
        .toList();
  }

  Future<List<CandidateModel>>? getFeatured() async {
    final snapshot = await database
        .ref()
        .child('candidates')
        .orderByChild('featured')
        .equalTo(true)
        .get();
    if (!snapshot.exists) {
      throw NoDataException();
    }
    Iterable l = [];
    if (snapshot.value.runtimeType == List<Object?>) {
      l = json.decode(json.encode(snapshot.value));
    } else if (snapshot.value != null) {
      Map<String?, Object?> map = json.decode(json.encode(snapshot.value));
      l = map.values;
    }
    return l
        .where((i) => i != null)
        .map((e) => CandidateModel.fromJson((e)))
        .toList();
  }

  Future<List<CandidateCategoryModel>>? getCategories() async {
    final snapshot = await database.ref().child('candidateCategories').get();
    if (!snapshot.exists) {
      throw NoDataException();
    }
    Iterable l = [];
    if (snapshot.value.runtimeType == List<Object?>) {
      l = json.decode(json.encode(snapshot.value));
    } else if (snapshot.value != null) {
      Map<String?, Object?> map = json.decode(json.encode(snapshot.value));
      l = map.values;
    }
    return l
        .where((i) => i != null)
        .map((e) => CandidateCategoryModel.fromJson((e)))
        .toList();
  }

  Future<List<CandidateModel>>? getCandidatesUnderCategory(
      String categoryId) async {
    final snapshot = await database
        .ref()
        .child('candidates')
        .orderByChild("categoryId")
        .equalTo(categoryId)
        .get();
    if (!snapshot.exists) {
      throw NoDataException();
    }
    Iterable l = [];
    if (snapshot.value.runtimeType == List<Object?>) {
      l = json.decode(json.encode(snapshot.value));
    } else if (snapshot.value != null) {
      Map<String?, Object?> map = json.decode(json.encode(snapshot.value));
      l = map.values;
    }
    List<CandidateModel> candidates = l
        .where((i) => i != null)
        .map((e) => CandidateModel.fromJson((e)))
        .toList();
    candidates.sort((a, b) => b.votes.compareTo(a.votes));
    return candidates;
  }

  Future<void>? saveCandidate(CandidateModel candidate) async {
    DatabaseReference newRef = database.ref().child("candidates").push();
    String? newKey = newRef.key;
    if (newKey == null) throw ServerSideException(message: "ID not returned!");
    candidate.id = newKey;
    return await newRef.set(candidate.toJson());
  }

  Future<Candidate>? getCandidate(String id) async {
    final snapshot = await database.ref().child('candidates/$id').get();
    if (!snapshot.exists) throw NoDataException();
    Map<String, dynamic> l = json.decode(json.encode(snapshot.value));
    return CandidateModel.fromJson(l);
  }
}
