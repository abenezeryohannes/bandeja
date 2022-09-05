import 'dart:convert';

import 'package:app/core/error/exceptions.dart';
import 'package:app/features/candidate/data/models/candidate.category.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/candidate.model.dart';

class CandidateLocalDataSource {
  late SharedPreferences sharedPreferences;
  CandidateLocalDataSource({required this.sharedPreferences});

  static const String TOP_VOTED_KEY = "TOPVOTED_KEY";
  static const String CANDIDATE_CATEGORIES_KEY = "CANDIDATE_CATEGORIES_KEY";
  static const String CANDIDATE_UNDER_CATEGORY_KEY =
      "CANDIDATE_UNDER_CATEGORY_KEY";
  static const String FEATURED_CANDIDATE_KEY = "FEATURED_CANDIDATE_KEY";

  Future<bool> addTopVotedToCache(List<CandidateModel> candidates) async {
    return await sharedPreferences.setString(
        TOP_VOTED_KEY, json.encode(candidates));
  }

  Future<bool> addFeaturedCandidateToCache(
      List<CandidateModel> candidates) async {
    return await sharedPreferences.setString(
        FEATURED_CANDIDATE_KEY, json.encode(candidates));
  }

  Future<bool> addCandidateCategoriesToCache(
      List<CandidateCategoryModel> candidateCategories) async {
    return await sharedPreferences.setString(
        CANDIDATE_CATEGORIES_KEY, json.encode(candidateCategories));
  }

  Future<bool> addCandidatesUnderCategoryToCache(
      List<CandidateModel> candidates, String categoryId) async {
    return await sharedPreferences.setString(
        CANDIDATE_UNDER_CATEGORY_KEY + categoryId, json.encode(candidates));
  }

  Future<List<CandidateModel>>? loadTopVotedFromCache() async {
    final cache = sharedPreferences.getString(TOP_VOTED_KEY);
    if (cache == null) throw CacheException();
    return loadCandidates(cache);
  }

  Future<List<CandidateModel>>? loadFeaturedCandidateFromCache() async {
    final cache = sharedPreferences.getString(FEATURED_CANDIDATE_KEY);
    if (cache == null) throw CacheException();
    return loadCandidates(cache);
  }

  Future<List<CandidateCategoryModel>>?
      loadCandidateCategoriesFromCache() async {
    final cache = sharedPreferences.getString(CANDIDATE_CATEGORIES_KEY);
    if (cache == null) throw CacheException();
    Iterable l = json.decode(cache);
    return List<CandidateCategoryModel>.from(
        l.map((model) => CandidateCategoryModel.fromJson(model)));
  }

  Future<List<CandidateModel>>? loadCandidatesUnderCategoryFromCache(
      String categoryId) async {
    final cache =
        sharedPreferences.getString(CANDIDATE_UNDER_CATEGORY_KEY + categoryId);
    if (cache == null) throw CacheException();
    return loadCandidates(cache);
  }

  Future<List<CandidateModel>> loadCandidates(String x) async {
    Iterable l = json.decode(x);
    return List<CandidateModel>.from(
        l.map((model) => CandidateModel.fromJson(model)));
  }
}
