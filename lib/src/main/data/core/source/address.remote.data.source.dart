import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/fixtures/fixture.reader.dart';
import '../../../domain/core/entities/address.dart';

@singleton
class AddressRemoteDataSource {
  late http.Client client;
  AddressRemoteDataSource({required this.client});
  Future<AddressModel> getAddress({required int id}) async {
    return AddressModel.fromJson(json.decode(await fixture("addresses.json")));
  }

  Future<List<AddressModel>>? getAddresses({int? page, int? limit}) async {
    return loadItemGroupsFromJson(await fixture("addresses.json"));
  }

  Future<List<AddressModel>> loadItemGroupsFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<AddressModel>.from(
        l.map((model) => AddressModel.fromJson(model)));
  }
}
