import 'dart:convert';
import 'dart:io';

import 'package:bandeja/src/admin/data/notification/dto/notification.dto.dart';
import 'package:bandeja/src/core/data/authentication/dto/location.dto.dart';
import 'package:get_storage/get_storage.dart';
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

      if (userDto.localImage != null && userDto.localImage!.isNotEmpty) {
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
            key != 'avatar' &&
            key != 'enabled' &&
            key != 'localImage') {
          request.fields[key] = value.toString();
        }
      });

      String token = GetStorage().read('token');
      Map<String, String>? header = Api.multipartHeader(token);
      request.headers.addAll(header!);
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
      Api.request("users"),
      headers: Api.getHeader(GetStorage().read('token')),
    );
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      UserModel user = UserModel.fromJson(responseDto.data);
      return user;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<UserModel> signupUser({required UserDto user}) async {
    Map<String, String> body = <String, String>{};

    Map<String, dynamic> jsonMap = user.toJson();
    jsonMap.forEach((key, value) {
      if (value != null
          // && (key == 'UID' || key == 'phoneNumber' || key == 'role')
          ) {
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

  Future<UserModel> loginUser({required UserDto user}) async {
    Map<String, String> body = <String, String>{};

    Map<String, dynamic> jsonMap = user.toJson();
    jsonMap.forEach((key, value) {
      if (value != null
          // &&(key == 'UID' || key == 'phoneNumber' || key == 'role')
          ) {
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

  Future<bool> logOut() async {
    String? token = GetStorage().read('token');
    if (token == null) return true;
    http.Response response = await client.post(Api.request("auth/logout"),
        headers: Api.postHeader(token));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      return true;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<UserModel>? setFCMToken({required String token}) async {
    Map<String, String> body = <String, String>{};
    body['fcm'] = token;
    http.Response response = await client.post(Api.request("auth/updateFCM"),
        body: body, headers: Api.postHeader(GetStorage().read('token')));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      UserModel user = UserModel.fromJson(responseDto.data);
      return user;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<bool> onAppVisit() async {
    String? token = GetStorage().read('token');
    if (token == null) return true;
    http.Response response = await client.post(Api.request("users/visitStart"),
        headers: Api.postHeader(token));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      return true;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<bool> onAppVisitEnd() async {
    String? token = GetStorage().read('token');
    if (token == null) return true;
    http.Response response = await client.post(Api.request("users/visitEnd"),
        headers: Api.postHeader(token));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      return true;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<bool> editLocation({required LocationDto locationDto}) async {
    Map<String, String> body = <String, String>{};
    locationDto.toJson().forEach((key, value) {
      if (value != null) body.addEntries({key: value.toString()}.entries);
    });
    http.Response response = await client.post(
        Api.request("users/editLocation"),
        headers: Api.postHeader(GetStorage().read('token')),
        body: body);
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      return true;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }
}
