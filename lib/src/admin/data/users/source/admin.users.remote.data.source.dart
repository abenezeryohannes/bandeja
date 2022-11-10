import 'dart:convert';

import 'package:bandeja/src/core/domain/authentication/entities/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/dto/response.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/api.dart';

@singleton
class AdminUsersRemoteDataSource {
  late http.Client client;
  AdminUsersRemoteDataSource({required this.client});

  Future<List<UserModel>> getUsers(
      {int? page, String? search, int? limit}) async {
    Map<String, String> query = {'page': "${page ?? 1}"};

    if (limit != null) {
      query.addEntries({"limit": '$limit'}.entries);
    }

    if (search != null) {
      query.addEntries({"search": search}.entries);
    }

    http.Response response = await client.get(
        Api.getRequestWithParams("users/findAllUsers", query),
        headers: Api.getHeader(GetStorage().read('token')));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<UserModel> owners = await loadUsersFromJson(responseDto.data);
      return owners;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<UserModel>> loadUsersFromJson(Iterable l) async {
    return List<UserModel>.from(l.map((model) => UserModel.fromJson(model)));
  }
}
