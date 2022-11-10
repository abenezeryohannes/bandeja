import 'dart:convert';

import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/dto/response.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/api.dart';

@singleton
class AdminPadelRemoteDataSource {
  late http.Client client;
  AdminPadelRemoteDataSource({required this.client});

  Future<List<PadelModel>>? getPadels(
      {int? page, String? search, int? limit, bool? enabled}) async {
    Map<String, String> query = <String, String>{};
    query.addEntries({'page': "${page ?? 1}"}.entries);

    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    if (enabled != null) {
      query.addEntries({'enabled': "$enabled"}.entries);
    }

    if (search != null) {
      query.addEntries({'search': search}.entries);
    }

    http.Response response = await client.get(
        Api.getRequestWithParams("padels/findAllPadels", query),
        headers: Api.getHeader(GetStorage().read('token')));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<PadelModel> padels = await loadPadelsFromJson(responseDto.data);
      return padels;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<PadelModel>>? getPadelsForApproval(
      {int? page, String? search, int? limit, bool? approved}) async {
    Map<String, String> query = <String, String>{};
    query.addEntries({'page': "${page ?? 1}"}.entries);

    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    if (approved != null) {
      query.addEntries({'approved': "$approved"}.entries);
    }

    if (search != null) {
      query.addEntries({'search': search}.entries);
    }

    http.Response response = await client.get(
        Api.getRequestWithParams("padels/findAllPadelsForApproval", query),
        headers: Api.getHeader(GetStorage().read('token')));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<PadelModel> padels = await loadPadelsFromJson(responseDto.data);
      return padels;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<int>? countAll() async {
    http.Response response = await client.get(Api.request("padels/countAll"),
        headers: Api.getHeader(GetStorage().read('token')));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      int count = responseDto.data as int;
      return count;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<PadelModel>> loadPadelsFromJson(Iterable l) async {
    // Iterable l = json.decode(x);
    return List<PadelModel>.from(l.map((model) => PadelModel.fromJson(model)));
  }
}
