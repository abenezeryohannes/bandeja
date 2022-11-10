import 'dart:convert';

import 'package:bandeja/src/admin/data/notification/dto/notification.dto.dart';
import 'package:bandeja/src/admin/data/notification/dto/notification.response.dto.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/dto/response.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/api.dart';

@singleton
class AdminNotificationRemoteDataSource {
  late http.Client client;
  AdminNotificationRemoteDataSource({required this.client});

  Future<NotificationResponseDto>? send(
      {required NotificationDto notificationDto}) async {
    Map<String, String> body = <String, String>{};

    Map<String, dynamic> temp = notificationDto.toJson();

    temp.forEach((key, value) {
      if (value != null) {
        body.addEntries({key: value.toString()}.entries);
      }
    });

    http.Response response = await client.post(
        Api.request("notifications/send"),
        headers: Api.postHeader(GetStorage().read('token')),
        body: body);

    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      // NotificationResponseDto result =
      //     NotificationResponseDto.fromJson(responseDto.data);
      return NotificationResponseDto.empty();
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }
}
