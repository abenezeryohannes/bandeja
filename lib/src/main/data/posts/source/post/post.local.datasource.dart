import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/fixtures/fixture.reader.dart';
import '../../../../domain/posts/entities/post.dart';

@singleton
class PostLocalDataSource {
  late SharedPreferences cache;
  PostLocalDataSource({required this.cache});

  static const String featuredPostsKey = "featuredPostsKey";
  static const String wantsKey = "wantsKey";
  static const String offersKey = "offersKey";
  static const String postsKey = "postsKey";
  static const String myPostKey = "myPostKey";

  Future<List<PostModel>>? loadWants(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(wantsKey);
    if (data == null) throw CacheFailure();
    return loadItemsFromJson(await fixture("posts.json"));
  }

  Future<List<PostModel>>? loadPosts(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(postsKey);
    if (data == null) throw CacheFailure();
    return loadItemsFromJson(await fixture("posts.json"));
  }

  Future<List<PostModel>>? loadOffers(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(offersKey);
    if (data == null) throw CacheFailure();
    return loadItemsFromJson(await fixture("posts.json"));
  }

  Future<List<PostModel>>? loadFeaturedPosts(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(featuredPostsKey);
    if (data == null) throw CacheFailure();
    return loadItemsFromJson(await fixture("posts.json"));
  }

  ///

  saveFeaturedPosts(int? page, List<PostModel> items) async {
    if (page != null && page > 1) return false;
    return await cache.setString(featuredPostsKey, json.encode(items));
  }

  saveWants(int? page, List<PostModel> items) async {
    if (page != null && page > 1) return false;
    return await cache.setString(wantsKey, json.encode(items));
  }

  saveOffers(int? page, List<PostModel> items) async {
    if (page != null && page > 1) return false;
    return await cache.setString(offersKey, json.encode(items));
  }

  savePosts(int? page, List<PostModel> items) async {
    if (page != null && page > 1) return false;
    return await cache.setString(postsKey, json.encode(items));
  }

  Future<List<PostModel>>? loadMyPosts(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(myPostKey);
    if (data == null) throw CacheFailure();
    return await loadItemsFromJson(await fixture("posts.json"));
  }

  Future<bool> saveMyPosts(int? page, List<PostModel> items) async {
    if (page != null && page > 1) return false;
    return await cache.setString(myPostKey, json.encode(items));
  }

  Future<List<PostModel>> loadItemsFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<PostModel>.from(l.map((model) => PostModel.fromJson(model)));
  }
}
