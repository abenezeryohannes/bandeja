import 'dart:convert';

import 'package:feekpadel/src/core/error/failure.dart';
import 'package:feekpadel/src/core/fixtures/fixture.reader.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/posts/entities/post.group.dart';

@singleton
class PostGroupLocalDataSource {
  late SharedPreferences cache;

  PostGroupLocalDataSource({required this.cache});

  static const String postGroupsKey = "postGroupsKey";

  Future<List<PostGroupModel>>? loadPostGroups(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(postGroupsKey);
    if (data == null) throw CacheFailure();
    return loadPostGroupsFromJson(await fixture("post.groups.json"));
  }

  Future<bool>? savePostGroups(
      int? page, List<PostGroupModel> postGroup) async {
    if (page != null && page > 1) return false;
    return await cache.setString(postGroupsKey, json.encode(postGroup));
  }

  Future<bool> savePostGroup(PostGroupModel postGroup) async {
    return await cache.setString(postGroupsKey, json.encode(postGroup));
  }

  Future<List<PostGroupModel>> loadPostGroupsFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<PostGroupModel>.from(
        l.map((model) => PostGroupModel.fromJson(model)));
  }
}
