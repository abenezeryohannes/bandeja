import 'dart:convert';

import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/dto/response.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/api.dart';
import '../dto/admin.monthly.stat.dto.dart';
import '../dto/admin.weekly.stat.dto.dart';

@singleton
class AdminBookingRemoteDataSource {
  late http.Client client;
  AdminBookingRemoteDataSource({required this.client});

  Future<List<PadelOrderModel>> getBookings(
      {int? page, int? limit, String? search, PadelModel? padel}) async {
    Map<String, String> query = {};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    if (search != null) {
      query.addEntries({'search': search}.entries);
    }

    if (padel != null) {
      query.addEntries({'padelId': '${padel.id}'}.entries);
    }

    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    http.Response response = await client.get(
        Api.getRequestWithParams("bookings/findAllBookings", query),
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

  Future<List<AdminWeeklyStatDto>> getAdminWeeklyStat(
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
        Api.getRequestWithParams("bookings/adminWeeklyStats", query),
        headers: Api.getHeader(GetStorage().read('token')));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<AdminWeeklyStatDto> dto =
          await loadAdminWeeklyStatFromJson(responseDto.data);
      return dto;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<AdminMonthlyStatDto> getAdminMonthlyStat(
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
        Api.getRequestWithParams("bookings/adminMonthlyStats", query),
        headers: Api.getHeader(GetStorage().read('token')));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      AdminMonthlyStatDto dto = AdminMonthlyStatDto.fromJson(responseDto.data);
      return dto;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<AdminWeeklyStatDto>> loadAdminWeeklyStatFromJson(
      Iterable l) async {
    return List<AdminWeeklyStatDto>.from(
        l.map((model) => AdminWeeklyStatDto.fromJson(model)));
  }

  Future<List<PadelOrderModel>> loadPadelOrdersFromJson(Iterable l) async {
    return List<PadelOrderModel>.from(
        l.map((model) => PadelOrderModel.fromJson(model)));
  }
}
