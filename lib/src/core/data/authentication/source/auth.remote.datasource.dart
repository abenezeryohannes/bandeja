import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';

import '../../../../core/dto/response.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/api.dart';
import '../../../domain/authentication/entities/user.dart';
import '../dto/user.dto.dart';

@singleton
class AuthRemoteDataSource {
  late http.Client client;
  AuthRemoteDataSource({required this.client});

  Future<UserModel> editUser({
    required UserDto userDto,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Api.request('users/edit'));

      if (userDto.localImage != null || userDto.localImage!.isNotEmpty) {
        File file = File(userDto.localImage!);
        if (!(await file.exists())) {
          throw Failure.unExpectedFailure(message: "File not found");
        }
        String? memeTD =
            lookupMimeType(userDto.localImage!, headerBytes: [0xFF, 0xD8]);

        List<String> memes =
            memeTD == null ? ['image', 'jpg'] : memeTD.split('/');

        request.files.add(http.MultipartFile(
            'avatar',
            File(userDto.localImage!).readAsBytes().asStream(),
            File(userDto.localImage!).lengthSync(),
            filename: userDto.localImage!.split("/").last,
            contentType: MediaType(memes[0], memes[1])));
      }

      Map<String, dynamic> jsonMap = userDto.toJson();
      jsonMap.forEach((key, value) {
        if (value != null &&
            key != 'id' &&
            key != 'avatar' &&
            key != 'enabled' &&
            key != 'localImage') {
          request.fields[key] = value.toString();
        }
      });

      request.headers.addAll(Api.multipartHeader("user")!);
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      ResponseDto responseDto =
          ResponseDto.fromJson(json.decode(response.body));
      if (responseDto.success) {
        UserModel user = UserModel.fromJson(responseDto.data);
        return user;
      } else {
        throw ServerFailure(message: responseDto.message);
      }
    } catch (e) {
      throw Failure.unExpectedFailure(message: e.toString());
    }
  }

  Future<UserModel> getUser({required int id}) async {
    http.Response response = await client.get(
      Api.request("user"),
      headers: Api.header("user"),
    );
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      UserModel user = UserModel.fromJson(responseDto.data);
      return user;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<UserModel> signupUser({required UserModel user}) async {
    Map<String, String> body = <String, String>{};

    Map<String, dynamic> jsonMap = user.toJson();
    jsonMap.forEach((key, value) {
      if (value != null &&
          (key == 'UID' || key == 'phoneNumber' || key == 'role')) {
        body[key] = value.toString();
      }
    });
    http.Response response =
        await client.post(Api.request("auth/signup"), body: body);
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      UserModel user = UserModel.fromJson(responseDto.data);
      return user;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<UserModel> loginUser({required UserModel user}) async {
    Map<String, String> body = <String, String>{};

    Map<String, dynamic> jsonMap = user.toJson();
    jsonMap.forEach((key, value) {
      if (value != null &&
          (key == 'UID' || key == 'phoneNumber' || key == 'role')) {
        body[key] = value.toString();
      }
    });
    http.Response response =
        await client.post(Api.request("auth/login"), body: body);
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      UserModel user = UserModel.fromJson(responseDto.data);
      return user;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }
}
