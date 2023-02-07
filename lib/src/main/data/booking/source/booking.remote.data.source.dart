import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:bandeja/src/main/data/dto/padel.order.dto.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/dto/response.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/api.dart';
import '../../../../core/utils/util.dart';

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

/**
  Future<PadelOrderModel?>? pay({required PadelOrderDto order}) async {
    Map<String, String> body = <String, String>{};

    //merchant_id
    body.addEntries({
      'merchant_id': dotenv.env[
              '${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_MARCHANT_ID'] ??
          ''
    }.entries);

    //username
    body.addEntries({
      'username': dotenv.env[
              '${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_USER_NAME'] ??
          ''
    }.entries);

    //password
    body.addEntries({
      'password': dotenv
              .env['${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_PASSWORD'] ??
          ''
    }.entries);

    //api_key
    body.addEntries({
      'api_key': dotenv
              .env['${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_API_KEY'] ??
          ''
    }.entries);

    //currencycode
    body.addEntries({
      'CurrencyCode': dotenv.env[
              '${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_CURRENCY_CODE'] ??
          ''
    }.entries);

    //success_url
    body.addEntries({
      'success_url': dotenv.env[
              '${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_SUCCESS_URL'] ??
          ''
    }.entries);

    //error_url
    body.addEntries({
      'error_url': dotenv.env[
              '${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_ERROR_URL'] ??
          ''
    }.entries);

    //test_mode
    body.addEntries({
      'test_mode': dotenv.env[
              '${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_TEST_MODE'] ??
          ''
    }.entries);

    //order_id
    body.addEntries({'order_id': order.barCode!}.entries);

    //total_price
    body.addEntries({'total_price': order.amount.toString()}.entries);

    print('Payment Request $body');

    Uri url = Uri.parse(
        dotenv.env['${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_URL'] ?? '');

    Map<String, String>? header = Api.postHeader(dotenv.env[
            '${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_ENCRYPTED_API_KEY'] ??
        '');
    Util.launchUrI(url);
    // http.Response response = await client.post(
    //   Uri.parse(
    //       dotenv.env['${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_URL'] ??
    //           ''),
    //   body: body,
    //   headers: header,
    // );

    //ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));

    //print('response $responseDto');
    return null;
  }
**/
  Future<PadelOrderModel?>? editBooking({required PadelOrderDto order}) async {
    Map<String, String> body = <String, String>{};

    order.toJson().forEach((key, value) {
      if (value != null) {
        body.addEntries({key: value.toString()}.entries);
      }
    });

    http.Response response = await client.post(
      Api.request("bookings/editOrder"),
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

  Future<PadelOrderModel?>? checkIfMyReservation(
      {required int padelScheduleId}) async {
    Map<String, String> body = <String, String>{};

    body.addEntries({'padelScheduleId': padelScheduleId.toString()}.entries);

    http.Response response = await client.post(
      Api.request("bookings/checkIfMyReservation"),
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

  Future<PadelOrderModel?>? notifyPayment({required data}) async {
    Map<String, String?> queryParams = {
      'PaymentID': (data['PaymentID'] as List<String>).isNotEmpty
          ? (data['PaymentID'] as List<String>).first
          : null,
      'Auth': (data['Auth'] as List<String>).isNotEmpty
          ? (data['Auth'] as List<String>).first
          : null,
      'Result': (data['Result'] as List<String>).isNotEmpty
          ? (data['Result'] as List<String>).first
          : null,
      'PostDate': (data['PostDate'] as List<String>).isNotEmpty
          ? (data['PostDate'] as List<String>).first
          : null,
      'TranID': (data['TranID'] as List<String>).isNotEmpty
          ? (data['TranID'] as List<String>).first
          : null,
      'OrderID': (data['OrderID'] as List<String>).isNotEmpty
          ? (data['OrderID'] as List<String>).first
          : null,
      'TrackID': (data['TrackID'] as List<String>).isNotEmpty
          ? (data['TrackID'] as List<String>).first
          : null,
      'Ref': (data['Ref'] as List<String>).isNotEmpty
          ? (data['Ref'] as List<String>).first
          : null,
    };

    http.Response response = await client.get(
        Api.getRequestWithParams("bookings/notifyPayment", queryParams),
        headers: Api.getHeader(GetStorage().read('token')));

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      PadelOrderModel order = PadelOrderModel.fromJson(responseDto.data);
      return order;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }
}
