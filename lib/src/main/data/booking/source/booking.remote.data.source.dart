import 'dart:convert';

import 'package:bandeja/src/main/data/dto/padel.order.dto.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/dto/response.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/api.dart';

@singleton
class BookingRemoteDataSource {
  late http.Client client;

  BookingRemoteDataSource({required this.client});

  Future<List<PadelOrderModel>>? getBookings({int? page, int? limit}) async {
    http.Response response = await client.get(
      Api.getRequestWithParams(
          "bookings", Api.GetListQuery(page: page, limit: limit)),
      headers: Api.getHeader(GetStorage().read('token')),
    );

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));

    if (responseDto.success) {
      List<PadelOrderModel> orders =
          await loadPadelOrdersFromJson(responseDto.data);
      return orders;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<PadelOrderModel>? book({required PadelOrderDto order}) async {
    Map<String, String> body = <String, String>{};

    order.toJson().forEach((key, value) {
      if (value != null) {
        body.addEntries({key: value.toString()}.entries);
      }
    });

    http.Response response = await client.post(
      Api.request("bookings/order"),
      body: body,
      headers: Api.postHeader(GetStorage().read('token')),
    );

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));

    if (responseDto.success) {
      PadelOrderModel order = PadelOrderModel.fromJson(responseDto.data);

      return order;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<PadelOrderModel>> loadPadelOrdersFromJson(Iterable l) async {
    return List<PadelOrderModel>.from(
        l.map((model) => PadelOrderModel.fromJson(model)));
  }
}
