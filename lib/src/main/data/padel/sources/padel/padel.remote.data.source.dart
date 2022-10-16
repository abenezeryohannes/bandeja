import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/domain/authentication/entities/user.dart';
import '../../../../../core/domain/padels/entities/bookmark.dart';
import '../../../../../core/domain/padels/entities/padel.dart';
import '../../../../../core/domain/padels/entities/padel.group.dart';
import '../../../../../core/dto/response.dto.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/fixtures/fixture.reader.dart';
import '../../../../../core/network/api.dart';
import '../../../../domain/core/entities/address.dart';
import '../../../../domain/core/entities/location.dart';

@singleton
class PadelRemoteDataSource {
  late http.Client client;
  PadelRemoteDataSource({required this.client});

  Future<List<PadelModel>>? getFilteredPadels(
      {int? page,
      PadelGroupModel? itemGroup,
      AddressModel? address,
      required DateTime date,
      DateTime? timeOfDay}) async {
    return loadPadelsFromLocalJson(await fixture("padels.json"));
  }

  Future<List<PadelModel>>? getFeaturedPadels(
      int? page, AddressModel? address, LocationModel? location) async {
    Response response = await client.get(Api.request("padels/featured"),
        headers: Api.getHeader("user"));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<PadelModel> padels = await loadPadelsFromJson(responseDto.data);
      return padels;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<List<PadelModel>>? getMyPadels(int? page) async {
    return loadPadelsFromLocalJson(await fixture("padels.json"));
  }

  Future<PadelModel>? getPadel(int id) async {
    return PadelModel.fromJson(json.decode(await fixture("padel.json")));
  }

  Future<List<PadelModel>>? getBookmarks({int? page, int? limit}) async {
    Response response = await client.get(Api.request("bookmarks"),
        headers: Api.getHeader("user"));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<PadelModel> bookmarks =
          await loadBookmarksFromJson(responseDto.data);
      // List<PadelModel> padels =
      //     bookmarks.map((e) => e.Padel as PadelModel).toList();
      return bookmarks;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<List<UserModel>>? getFilterPadels(
      {int? page,
      PadelGroupModel? padelGroup,
      AddressModel? address,
      bool indoor = false,
      int? limit,
      required String date,
      DateTime? timeOfDay}) async {
    Map<String, String> query = {'date': date, 'indoor': indoor.toString()};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    if (address != null) {
      query.addEntries({"addressId": address.id.toString()}.entries);
    }

    if (padelGroup != null) {
      query.addEntries({"padelGroupId": padelGroup.id.toString()}.entries);
    }

    Response response = await client.get(
        Api.getRequestWithParams("padels", query),
        headers: Api.getHeader("user"));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<UserModel> owners = await loadOwnersFromJson(responseDto.data);
      return owners;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<List<PadelModel>> loadPadelsFromLocalJson(String x) async {
    Iterable l = json.decode(x);
    return List<PadelModel>.from(l.map((model) => PadelModel.fromJson(model)));
  }

  Future<List<PadelModel>> loadPadelsFromJson(Iterable l) async {
    // Iterable l = json.decode(x);
    return List<PadelModel>.from(l.map((model) => PadelModel.fromJson(model)));
  }

  Future<List<PadelModel>> loadBookmarksFromJson(Iterable l) async {
    return List<PadelModel>.from(l.map((model) => PadelModel.fromJson(model)));
  }

  Future<List<UserModel>> loadOwnersFromJson(Iterable l) async {
    return List<UserModel>.from(l.map((model) => UserModel.fromJson(model)));
  }

  Future<bool> setBookmark({required int padelId}) async {
    Map<String, String> body = {'padelId': padelId.toString()};

    Response response = await client.post(Api.request("bookmarks/set"),
        headers: Api.postHeader("user"), body: body);

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      bool result = (responseDto.data) as bool;
      return result;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }
}
