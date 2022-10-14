import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/dto/response.dto.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api.dart';
import '../../../../domain/posts/entities/post.group.dart';

@singleton
class PostGroupRemoteDataSource {
  late http.Client client;
  PostGroupRemoteDataSource({required this.client});

  Future<PostGroupModel>? getPostGroup(int id) async {
    return PostGroupModel();
  }

  Future<List<PostGroupModel>>? getPostGroups(int? page) async {
    Response response = await client.get(
      Api.request("postGroups"),
      headers: Api.header("user"),
    );
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<PostGroupModel>? posts =
          await loadPostGroupsFromJson(responseDto.data);
      return posts;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<List<PostGroupModel>> loadLocalPostGroupsFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<PostGroupModel>.from(
        l.map((model) => PostGroupModel.fromJson(model)));
  }

  Future<List<PostGroupModel>> loadPostGroupsFromJson(Iterable l) async {
    return List<PostGroupModel>.from(
        l.map((model) => PostGroupModel.fromJson(model)));
  }
}
