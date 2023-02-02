import 'dart:convert';

import 'package:bandeja/src/core/domain/padels/entities/duration.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../../../core/domain/authentication/entities/user.dart';
import '../../../../../core/domain/padels/entities/padel.dart';
import '../../../../../core/domain/padels/entities/padel.group.dart';
import '../../../../../core/domain/padels/entities/promo.code.dart';
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

  Future<List<PadelModel>>? getFeaturedPadels(
    int? page,
    AddressModel? address,
    LocationModel? location,
    PadelGroupModel? padelGroup,
  ) async {
    Map<String, String> query = <String, String>{};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    if (location != null) {
      query.addEntries({'latitude': "${location.longitude}"}.entries);
      query.addEntries({'longitude': "${location.latitude}"}.entries);
    }

    if (address != null) {
      query.addEntries({'addressId': "${address.id}"}.entries);
    }

    if (padelGroup != null) {
      query.addEntries({'padelGroupId': "${padelGroup.id}"}.entries);
    }

    Response response = await client.get(
        Api.getRequestWithParams("padels/featured", query),
        headers: Api.getHeader(GetStorage().read('token')));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));

    if (responseDto.success) {
      List<PadelModel> padels = await loadPadelsFromJson(responseDto.data);
      return padels;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<PadelModel>>? getBookmarks({int? page, int? limit}) async {
    Response response = await client.get(Api.request("bookmarks"),
        headers: Api.getHeader(GetStorage().read('token')));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<PadelModel> bookmarks =
          await loadBookmarksFromJson(responseDto.data);
      // List<PadelModel> padels =
      //     bookmarks.map((e) => e.Padel as PadelModel).toList();
      return bookmarks;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<UserModel>>? getFilterPadels(
      {int? page,
      DurationModel? duration,
      PadelGroupModel? padelGroup,
      AddressModel? address,
      bool indoor = false,
      int? limit,
      required String date,
      DateTime? timeOfDay}) async {
    Map<String, String> query = {'date': date, 'indoor': indoor.toString()};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    if (duration != null) {
      query.addEntries({"durationId": duration.id.toString()}.entries);
    }

    if (address != null) {
      query.addEntries({"addressId": address.id.toString()}.entries);
    }

    if (padelGroup != null) {
      query.addEntries({"padelGroupId": padelGroup.id.toString()}.entries);
    }

    Response response = await client.get(
        Api.getRequestWithParams("padels", query),
        headers: Api.getHeader(GetStorage().read('token')));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<UserModel> owners = await loadOwnersFromJson(responseDto.data);
      return owners;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<bool> setBookmark({required int padelId}) async {
    Map<String, String> body = {'padelId': padelId.toString()};

    Response response = await client.post(Api.request("bookmarks/set"),
        headers: Api.postHeader(GetStorage().read('token')), body: body);

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      bool result = (responseDto.data) as bool;
      getBookmarks();
      return result;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<PromoCodeModel>? checkPromo(
      {required String promo, required int padelId}) async {
    Map<String, String> query = {'code': promo, 'padelId': '$padelId'};

    Response response = await client.get(
        Api.getRequestWithParams("padels/getPromoCode", query),
        headers: Api.getHeader(GetStorage().read('token')));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      PromoCodeModel promo = PromoCodeModel.fromJson(responseDto.data);
      return promo;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<bool>? isBookmark({required int padelId}) async {
    Map<String, String> body = {'padelId': '$padelId'};

    Response response = await client.post(Api.request("bookmarks/isBookmark"),
        body: body, headers: Api.postHeader(GetStorage().read('token')));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      return responseDto.data as bool;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<PadelModel>? findPadelWIthPeriod(
      {required int padelId,
      required DateTime startTime,
      required DateTime endTime}) async {
    Map<String, String> query = {
      'startDate': DateFormat('yyyy-MM-dd').format(startTime),
      'endDate': DateFormat('yyyy-MM-dd').format(endTime),
      'padelId': '$padelId'
    };

    Response response = await client.get(
        Api.getRequestWithParams("padels/findOneWithPeriod", query),
        headers: Api.getHeader(GetStorage().read('token')));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      PadelModel padel = PadelModel.fromJson(responseDto.data);
      return padel;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<PadelModel>? findPadel({int? padelId, DateTime? date}) async {
    Map<String, String> query = {
      'date': DateFormat('yyyy-MM-dd').format(date ?? DateTime.now()),
      'padelId': '$padelId'
    };

    Response response = await client.get(
        Api.getRequestWithParams("padels/$padelId", query),
        headers: Api.getHeader(GetStorage().read('token')));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      PadelModel padel = PadelModel.fromJson(responseDto.data);
      return padel;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<PadelModel> getPadel(int id) async {
    Response response = await client.get(Api.request("padels/$id"),
        headers: Api.getHeader(GetStorage().read('token')));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      PadelModel padel = PadelModel.fromJson(responseDto.data);
      return padel;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<DurationModel>> getDurations() async {
    Response response = await client.get(Api.request("padels/durations"),
        headers: Api.getHeader(GetStorage().read('token')));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<DurationModel> durations =
          await loadDurationsFromLocalJson(responseDto.data);
      return durations;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<DurationModel>> loadDurationsFromLocalJson(Iterable l) async {
    return List<DurationModel>.from(
        l.map((model) => DurationModel.fromJson(model)));
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
}
