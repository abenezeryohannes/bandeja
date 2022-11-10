import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';

import '../../../../../core/data/posts/dto/post.dto.dart';
import '../../../../../core/domain/posts/entities/post.dart';
import '../../../../../core/domain/posts/entities/post.group.dart';
import '../../../../../core/dto/response.dto.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/fixtures/fixture.reader.dart';
import '../../../../../core/network/api.dart';
import '../../../../domain/core/entities/address.dart';
import '../../../../domain/core/entities/location.dart';

@singleton
class PostRemoteDataSource {
  late http.Client client;
  PostRemoteDataSource({required this.client});

  Future<List<PostModel>>? filterAds({
    int? page,
    PostGroupModel? itemGroup,
    AddressModel? address,
    required DateTime date,
    DateTime? timeOfDay,
  }) async {
    return loadLocalPostsFromJson(await fixture("posts.json"));
  }

  Future<List<PostModel>>? getWants(int? page) async {
    return loadLocalPostsFromJson(await fixture("posts.json"));
  }

  Future<List<PostModel>>? getOffers(int? page) async {
    return loadLocalPostsFromJson(await fixture("posts.json"));
  }

  Future<List<PostModel>>? getFeaturedPosts(int? page) async {
    http.Response response = await client.get(
      Api.request("posts/featured"),
      headers: Api.getHeader(GetStorage().read('token')),
    );
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<PostModel> padels = await loadPostsFromJson(responseDto.data);
      return padels;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<PostModel>>? getPosts(
      {int? page,
      int? limit,
      PostGroupModel? itemGroup,
      LocationModel? location,
      AddressModel? address,
      bool? offers}) async {
    Map<String, String> query = <String, String>{};
    query.addAll(
      {"page": "${page ?? 1}"},
    );
    query.addAll(
      {"limit": "${limit ?? 25}"},
    );
    if (location != null) {
      query.addAll(
        {"latitude": "${location.latitude}"},
      );
      query.addAll(
        {"longitude": "${location.longitude}"},
      );
    }
    if (itemGroup != null) {
      query.addAll(
        {"postGroupId": "${itemGroup.id}"},
      );
    }
    if (address != null) {
      query.addAll(
        {"addressId": "${address.id}"},
      );
    }

    http.Response response = await client.get(
      Api.getRequestWithParams("posts", query),
      headers: Api.getHeader(GetStorage().read('token')),
    );
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<PostModel> padels = await loadPostsFromJson(responseDto.data);
      return padels;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<PostModel>? getAdvert(int? page) async {
    return PostModel.fromJson(json.decode(await fixture("post.json")));
  }

  Future<List<PostModel>>? getMyPosts({int? page, int? limit}) async {
    Map<String, String> query = <String, String>{};
    query.addAll(
      {"page": "${page ?? 1}"},
    );
    query.addAll(
      {"limit": "${limit ?? 25}"},
    );

    http.Response response = await client.get(
      Api.getRequestWithParams("posts/mine", query),
      headers: Api.getHeader(GetStorage().read('token')),
    );
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<PostModel> padels = await loadPostsFromJson(responseDto.data);
      return padels;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<PostModel>> loadLocalPostsFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<PostModel>.from(l.map((model) => PostModel.fromJson(model)));
  }

  Future<List<PostModel>> loadPostsFromJson(Iterable l) async {
    return List<PostModel>.from(l.map((model) => PostModel.fromJson(model)));
  }

  Future<PostModel?> addPost({
    required List<String> imageFilePaths,
    PostDto? post,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Api.request('posts/add'));

      if (imageFilePaths.isNotEmpty) {
        File file = File(imageFilePaths[0]);
        if (!(await file.exists())) {
          throw Failure.unExpectedFailure(message: "File not found");
        }
        String fileName = file.path.split('/').last;
        for (int i = 0; i < imageFilePaths.length; i++) {
          String? memeTD =
              lookupMimeType(imageFilePaths[i], headerBytes: [0xFF, 0xD8]);

          List<String> memes =
              memeTD == null ? ['image', 'jpg'] : memeTD.split('/');

          request.files.add(http.MultipartFile(
              'files',
              File(imageFilePaths[i]).readAsBytes().asStream(),
              File(imageFilePaths[i]).lengthSync(),
              filename: imageFilePaths[i].split("/").last,
              contentType: MediaType(memes[0], memes[1])));
        }
      }

      Map<String, dynamic> jsonMap = post!.toJson();
      jsonMap.forEach((key, value) {
        if (value != null &&
            key != 'id' &&
            key != 'User' &&
            key != 'PostImages') {
          request.fields[key] = value.toString();
        }
      });

      request.headers.addAll(Api.multipartHeader(GetStorage().read('token'))!);
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      ResponseDto responseDto =
          ResponseDto.fromJson(json.decode(response.body));
      if (responseDto.success) {
        PostModel post = PostModel.fromJson(responseDto.data);
        return post;
      } else {
        throw Failure.AssignFailureType(responseDto);
      }
    } catch (e) {
      throw Failure.unExpectedFailure(message: e.toString());
    }
  }

  Future<bool?> deletePost(int id) async {
    Map<String, String> body = <String, String>{};
    body.addAll({'postId': id.toString()});
    http.Response response = await client.post(Api.request("posts/delete"),
        headers: Api.postHeader(GetStorage().read('token')), body: body);
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      return true;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }
}
