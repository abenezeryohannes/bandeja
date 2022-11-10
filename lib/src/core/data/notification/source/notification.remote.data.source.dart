import 'dart:convert';

import 'package:bandeja/src/core/domain/notifications/entities/notification.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import '../../../../core/dto/response.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/api.dart';

@singleton
class NotificationRemoteDataSource {
  late http.Client client;
  NotificationRemoteDataSource({required this.client});

  Future<List<NotificationModel>> getNotifications(
      {int? page, int? limit}) async {
    http.Response response = await client.get(
      Api.getRequestWithParams(
          "notifications", Api.GetListQuery(page: page, limit: limit)),
      headers: Api.getHeader(GetStorage().read('token')),
    );
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<NotificationModel> notifications =
          await loadNotificationsFromJson(responseDto.data);
      return notifications;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<NotificationModel>> getUnSeenNotifications(
      {int? page, int? limit}) async {
    http.Response response = await client.get(
      Api.getRequestWithParams("notifications/findAllUnSeen",
          Api.GetListQuery(page: page, limit: limit)),
      headers: Api.getHeader(GetStorage().read('token')),
    );
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<NotificationModel> notifications =
          await loadNotificationsFromJson(responseDto.data);
      return notifications;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<int> countUnseenNotifications() async {
    http.Response response = await client.get(
      Api.request("notifications/unSeenCount"),
      headers: Api.getHeader(GetStorage().read('token')),
    );
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      int response = (responseDto.data as int);
      return response;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<NotificationModel> makeNotificationSeen(
      {required int notificationId}) async {
    Map<String, String> body = <String, String>{};
    body['notificationId'] = notificationId.toString();
    http.Response response = await client.post(
        Api.request("notifications/seen"),
        headers: Api.postHeader(GetStorage().read('token')),
        body: body);
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      NotificationModel notifications =
          NotificationModel.fromJson(responseDto.data);
      return notifications;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<NotificationModel>> clearNotifications() async {
    http.Response response =
        await client.post(Api.request("notifications/clear"));
    ResponseDto responseDto = ResponseDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      List<NotificationModel> notifications =
          await loadNotificationsFromJson(responseDto.data);
      return notifications;
    } else {
      throw Failure.AssignFailureType(responseDto);
    }
  }

  Future<List<NotificationModel>> loadNotificationsFromJson(Iterable l) async {
    return List<NotificationModel>.from(
        l.map((model) => NotificationModel.fromJson(model)));
  }
}
