import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/dto/response.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/fixtures/fixture.reader.dart';
import '../../../../core/network/api.dart';
import '../../../domain/core/entities/address.dart';

@singleton
class AddressRemoteDataSource {
  late http.Client client;

  AddressRemoteDataSource({required this.client});

  Future<AddressModel> getAddress({required int id}) async {
    return AddressModel.fromJson(json.decode(await fixture("addresses.json")));
  }

  Future<List<AddressModel>>? getAddresses({int? page, int? limit}) async {
    Map<String, String> query = <String, String>{};

    query.addEntries({'page': '${page ?? 1}'}.entries);

    if (limit != null) {
      query.addEntries({'limit': '$limit'}.entries);
    }

    http.Response response = await client.get(
      Api.getRequestWithParams("addresses", query),
      headers: Api.getHeader(GetStorage().read('token')),
    );

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));

    if (responseDto.success) {
      List<AddressModel> addresses =
          await loadAddressesFromJson(responseDto.data);
      return addresses;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<AddressModel>> loadAddressesFromJson(Iterable l) async {
    return List<AddressModel>.from(
        l.map((model) => AddressModel.fromJson(model)));
  }
}
