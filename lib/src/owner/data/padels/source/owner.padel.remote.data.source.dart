import 'dart:convert';

import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/core/domain/padels/entities/duration.dart';
import 'package:bandeja/src/core/domain/padels/entities/feature.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/core/domain/padels/entities/promo.code.dart';
import 'package:bandeja/src/owner/data/bookings/dto/padel.schedule.dto.dart';
import 'package:bandeja/src/owner/data/padels/dto/padel.dto.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

import '../../../../core/dto/response.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/api.dart';
import '../dto/promo.code.dto.dart';

@singleton
class OwnerPadelRemoteDataSource {
  late http.Client client;
  OwnerPadelRemoteDataSource({required this.client});

  Future<List<PadelOrderModel>> getBookings(
      {int? page,
      int? limit,
      String? search,
      String? startTime,
      String? endTime}) async {
    Map<String, String> query = {};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    if (search != null) {
      query.addEntries({'search': search}.entries);
    }

    if (startTime != null) {
      query.addEntries({'startTime': startTime}.entries);
    }
    if (endTime != null) {
      query.addEntries({'endTime': endTime}.entries);
    }

    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }
    String token = GetStorage().read('token');

    http.Response response = await client.get(
        Api.getRequestWithParams("bookings/findAllOwner", query),
        headers: Api.getHeader(token));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));

    if (responseDto.success) {
      List<PadelOrderModel> padelOrder =
          await loadPadelOrdersFromJson(responseDto.data);

      return padelOrder;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<List<PadelModel>> getPadels(
      {int? page, int? limit, String? startTime, String? endTime}) async {
    Map<String, String> query = {};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    if (startTime != null) {
      query.addEntries({'startTime': startTime}.entries);
    }
    if (endTime != null) {
      query.addEntries({'endTime': endTime}.entries);
    }

    if (limit != null) {
      query.addEntries({"limit": '$limit'}.entries);
    }

    http.Response response = await client.get(
        Api.getRequestWithParams("padels/all", query),
        headers: Api.getHeader(GetStorage().read('token')));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<PadelModel> padels = await loadPadelsFromJson(responseDto.data);
      return padels;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<List<PromoCodeModel>> getPromoCodes({int? page, int? limit}) async {
    Map<String, String> query = {};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    http.Response response = await client.get(
        Api.getRequestWithParams("padels/findAllPromoCodes", query),
        headers: Api.getHeader(GetStorage().read('token')));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<PromoCodeModel> promoCodes =
          await loadPromoCodessFromJson(responseDto.data);
      return promoCodes;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<PromoCodeModel>? addPromoCode({required PromoCodeDto promo}) async {
    Map<String, String> body = <String, String>{};

    Map<String, dynamic> jsonMap = promo.toJson();
    jsonMap.forEach((key, value) {
      if (value != null &&
          (key != 'PadelName' && key != 'User' && key != 'id')) {
        body[key] = value.toString();
      }
    });
    http.Response response = await client.post(
        Api.request("padels/addPromoCode"),
        body: body,
        headers: Api.postHeader(GetStorage().read('token')));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      // PromoCodeModel promoCode = PromoCodeModel.fromJson(responseDto.data);
      return PromoCodeModel(padelId: -1, userId: -1);
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<PromoCodeModel>? editPromoCode({required PromoCodeDto promo}) async {
    Map<String, String> body = <String, String>{};

    Map<String, dynamic> jsonMap = promo.toJson();
    jsonMap.forEach((key, value) {
      if (value != null && (key != 'PadelName' && key != 'User')) {
        body[key] = value.toString();
      }
    });
    http.Response response = await client.post(
        Api.request("padels/editPromoCode"),
        body: body,
        headers: Api.postHeader(GetStorage().read('token')));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      // PromoCodeModel promoCode = PromoCodeModel.fromJson(responseDto.data);
      return PromoCodeModel(padelId: -1, userId: -1);
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<List<DurationModel>> getDurations({int? page, int? limit}) async {
    Map<String, String> query = {};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    http.Response response = await client.get(
        Api.getRequestWithParams("padels/findAllDurations", query),
        headers: Api.getHeader(GetStorage().read('token')));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<DurationModel> durations =
          await loadDurationsFromJson(responseDto.data);
      return durations;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<List<FeatureModel>> getFeatures({int? page, int? limit}) async {
    Map<String, String> query = {};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    http.Response response = await client.get(
        Api.getRequestWithParams("padels/findAllFeatures", query),
        headers: Api.getHeader(GetStorage().read('token')));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<FeatureModel> features =
          await loadFeaturesFromJson(responseDto.data);
      return features;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<PadelScheduleModel>? editSchedule(
      {required PadelScheduleDto schedule}) async {
    Map<String, String> body = <String, String>{};

    Map<String, dynamic> jsonMap = schedule.toJson();
    jsonMap.forEach((key, value) {
      if (value != null) {
        body[key] = value.toString();
      }
    });
    http.Response response = await client.post(
        Api.request("padels/editSchedule"),
        body: body,
        headers: Api.postHeader(GetStorage().read('token')));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      PadelScheduleModel padelScheduleModel =
          PadelScheduleModel.fromJson(responseDto.data);
      return padelScheduleModel;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<List<DurationModel>> loadDurationsFromJson(Iterable l) async {
    return List<DurationModel>.from(
        l.map((model) => DurationModel.fromJson(model)));
  }

  Future<List<FeatureModel>> loadFeaturesFromJson(Iterable l) async {
    return List<FeatureModel>.from(
        l.map((model) => FeatureModel.fromJson(model)));
  }

  Future<List<PromoCodeModel>> loadPromoCodessFromJson(Iterable l) async {
    return List<PromoCodeModel>.from(
        l.map((model) => PromoCodeModel.fromJson(model)));
  }

  Future<List<PadelModel>> loadPadelsFromJson(Iterable l) async {
    return List<PadelModel>.from(l.map((model) => PadelModel.fromJson(model)));
  }

  Future<List<PadelOrderModel>> loadPadelOrdersFromJson(Iterable l) async {
    return List<PadelOrderModel>.from(
        l.map((model) => PadelOrderModel.fromJson(model)));
  }

  Future<PadelModel>? addPadel({required PadelDto padelDto}) async {
    try {
      var request = http.MultipartRequest('POST', Api.request('padels/add'));

      request = await Api.addImage(
          name: 'avatar', request: request, path: padelDto.avatarLocalImage);

      request = await Api.addImage(
          name: 'banner', request: request, path: padelDto.bannerLocalImage);

      Map<String, dynamic> jsonMap = padelDto.toJson();
      jsonMap.forEach((key, value) {
        if (value != null &&
            key != 'id' &&
            key != 'userId' &&
            key != 'avatar' &&
            key != 'banner' &&
            key != 'bannerLocalImage' &&
            key != 'avatarLocalImage' &&
            key != 'enabled' &&
            key != 'PostImages') {
          if (key == 'padelFeatureDto') {
            request.fields[key] = (json.encode(value));
          } else if (key == 'locationDto') {
            request.fields[key] = (json.encode(value));
          } else if (key == 'padelSchedules') {
            request.fields[key] = (json.encode(value));
          } else if (value is List) {
            request.fields[key] = (json.encode(value));
          } else {
            request.fields[key] = value.toString();
          }
        }
      });

      request.headers.addAll(Api.multipartHeader(GetStorage().read('token'))!);
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      ResponseDto responseDto =
          ResponseDto.fromJson(json.decode(response.body));
      if (responseDto.success) {
        PadelModel padel = PadelModel.fromJson(responseDto.data);
        return padel;
      } else {
        throw ServerFailure(message: responseDto.message);
      }
    } catch (e) {
      throw Failure.unExpectedFailure(message: e.toString());
    }
  }

  Future<PadelModel>? editPadel({required PadelDto padelDto}) async {
    try {
      var request = http.MultipartRequest('POST', Api.request('padels/edit'));

      request = await Api.addImage(
          name: 'avatar', request: request, path: padelDto.avatarLocalImage);

      request = await Api.addImage(
          name: 'banner', request: request, path: padelDto.bannerLocalImage);

      Map<String, dynamic> jsonMap = padelDto.toJson();
      jsonMap.forEach((key, value) {
        if (value != null &&
            key != 'userId' &&
            key != 'bannerLocalImage' &&
            key != 'avatar' &&
            key != 'banner' &&
            key != 'avatarLocalImage' &&
            key != 'PostImages') {
          if (key == 'padelFeatureDto') {
            request.fields[key] = (json.encode(value));
          } else if (key == 'locationDto') {
            request.fields[key] = (json.encode(value));
          } else if (key == 'padelSchedules') {
            request.fields[key] = (json.encode(value));
          } else if (value is List) {
            request.fields[key] = (json.encode(value));
          } else {
            request.fields[key] = value.toString();
          }
        }
      });

      request.headers.addAll(Api.multipartHeader(GetStorage().read('token'))!);
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      ResponseDto responseDto =
          ResponseDto.fromJson(json.decode(response.body));
      if (responseDto.success) {
        PadelModel padel = PadelModel.fromJson(responseDto.data);
        return padel;
      } else {
        throw ServerFailure(message: responseDto.message);
      }
    } catch (e) {
      throw Failure.unExpectedFailure(message: e.toString());
    }
  }
}
