import 'dart:convert';

import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/main/data/dto/padel.order.dto.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/dto/response.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/api.dart';
import '../../dto/owner.monthly.stat.dto.dart';
import '../../dto/owner.weekly.stat.dto.dart';

@singleton
class OwnerBookingRemoteDataSource {
  late http.Client client;
  OwnerBookingRemoteDataSource({required this.client});

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

    http.Response response = await client.get(
        Api.getRequestWithParams("bookings/findAllOwner", query),
        headers: Api.getHeader(GetStorage().read('token')));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));

    if (responseDto.success) {
      List<PadelOrderModel> padelOrder =
          await loadPadelOrdersFromJson(responseDto.data);

      return padelOrder;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<OwnerWeeklyStatDto>> getOwnerWeeklyStat(
      {String? startTime, String? endTime, PadelModel? padel}) async {
    Map<String, String> query = {};

    if (startTime != null) {
      query.addEntries({'startTime': startTime}.entries);
    }
    if (endTime != null) {
      query.addEntries({'endTime': endTime}.entries);
    }
    if (padel != null) {
      query.addEntries({'padelId': '${padel.id}'}.entries);
    }

    http.Response response = await client.get(
        Api.getRequestWithParams("bookings/ownerWeeklyStats", query),
        headers: Api.getHeader(GetStorage().read('token')));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<OwnerWeeklyStatDto> dto =
          await loadOwnerWeeklyStatFromJson(responseDto.data);
      return dto;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<OwnerMonthlyStatDto> getOwnerMontlyStat(
      {String? startTime, String? endTime, PadelModel? padel}) async {
    Map<String, String> query = {};

    if (startTime != null) {
      query.addEntries({'startTime': startTime}.entries);
    }
    if (endTime != null) {
      query.addEntries({'endTime': endTime}.entries);
    }
    if (padel != null) {
      query.addEntries({'padelId': '${padel.id}'}.entries);
    }

    http.Response response = await client.get(
        Api.getRequestWithParams("bookings/ownerMonthlyStats", query),
        headers: Api.getHeader(GetStorage().read('token')));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      OwnerMonthlyStatDto dto = OwnerMonthlyStatDto.fromJson(responseDto.data);
      return dto;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<PadelOrderModel> editBooking({required PadelOrderDto orderDto}) async {
    Map<String, String> body = {};

    Map<String, dynamic> jsonMap = orderDto.toJson();
    jsonMap.forEach((key, value) {
      if (value != null) {
        body.addEntries({key: value.toString()}.entries);
      }
    });

    http.Response response = await client.post(
        Api.request("bookings/editUserOrder"),
        body: body,
        headers: Api.postHeader(GetStorage().read('token')));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      PadelOrderModel order = PadelOrderModel.fromJson(responseDto.data);
      return order;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<PadelOrderModel> getpaymentFromSchedule(
      {required int scheduleId}) async {
    Map<String, String> body = <String, String>{};
    body['id'] = '$scheduleId';
    http.Response response = await client.post(
        Api.request(
          "bookings/getpaymentFromSchedule",
        ),
        body: body,
        headers: Api.postHeader(GetStorage().read('token')));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      PadelOrderModel padelOrderModel =
          PadelOrderModel.fromJson(responseDto.data);
      return padelOrderModel;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<PadelOrderModel>? getBookingFromQrCode(
      {required String qrCode}) async {
    Map<String, String> body = <String, String>{};
    body['qrCode'] = qrCode;
    http.Response response = await client.post(
        Api.request(
          "bookings/getBookingFromQrCode",
        ),
        body: body,
        headers: Api.postHeader(GetStorage().read('token')));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      PadelOrderModel padelOrderModel =
          PadelOrderModel.fromJson(responseDto.data);
      return padelOrderModel;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<OwnerWeeklyStatDto>> loadOwnerWeeklyStatFromJson(
      Iterable l) async {
    return List<OwnerWeeklyStatDto>.from(
        l.map((model) => OwnerWeeklyStatDto.fromJson(model)));
  }

  Future<List<PadelOrderModel>> loadPadelOrdersFromJson(Iterable l) async {
    return List<PadelOrderModel>.from(
        l.map((model) => PadelOrderModel.fromJson(model)));
  }
}
