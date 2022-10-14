import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../../core/fixtures/fixture.reader.dart';
import '../../../../domain/padels/entities/padel.group.dart';

@singleton
class PadelGroupRemoteDataSource {
  late http.Client client;
  PadelGroupRemoteDataSource({required this.client});

  Future<List<PadelGroupModel>> loadPadelGroupsFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<PadelGroupModel>.from(
        l.map((model) => PadelGroupModel.fromJson(model)));
  }

  Future<List<PadelGroupModel>>? getPadelGroups(int? page) async {
    return loadPadelGroupsFromJson(await fixture("padel.groups.json"));
  }

  Future<PadelGroupModel> getPadelGroup() async {
    return PadelGroupModel.fromJson(
        json.decode(await fixture("padel.group.json")));
  }
}
