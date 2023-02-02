import 'dart:convert';

import 'package:bandeja/src/core/domain/ads/entities/ad.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/dto/response.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/api.dart';

@singleton
class AdRemoteDataSource {
  late http.Client client;

  AdRemoteDataSource({required this.client});

  Future<List<AdModel>>? getAds({int? page, int? limit}) async {
    http.Response response = await client.get(
      Api.getRequestWithParams(
          "ads", Api.GetListQuery(page: page, limit: limit)),
      headers: Api.getHeader(GetStorage().read('token')),
    );

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));

    if (responseDto.success) {
      List<AdModel> ads = await loadAdsFromJson(responseDto.data);
      return ads;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<AdModel>> loadAdsFromJson(Iterable l) async {
    return List<AdModel>.from(l.map((model) => AdModel.fromJson(model)));
  }
}
