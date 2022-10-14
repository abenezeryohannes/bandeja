import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/dto/response.dto.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/fixtures/fixture.reader.dart';
import '../../../../../core/network/api.dart';
import '../../../../domain/padels/entities/padel.group.dart';

@singleton
class PadelGroupRemoteDataSource {
  late http.Client client;
  PadelGroupRemoteDataSource({required this.client});

  Future<List<PadelGroupModel>> loadPadelGroupsFromJson(Iterable l) async {
    return List<PadelGroupModel>.from(
        l.map((model) => PadelGroupModel.fromJson(model)));
  }

  Future<List<PadelGroupModel>>? getPadelGroups(int? page) async {
    Response response = await client.get(Api.request("padel-group"),
        headers: Api.header("user"));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<PadelGroupModel> padelGroups =
          await loadPadelGroupsFromJson(responseDto.data);
      return padelGroups;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<PadelGroupModel> getPadelGroup() async {
    return PadelGroupModel.fromJson(
        json.decode(await fixture("padel.group.json")));
  }
}
