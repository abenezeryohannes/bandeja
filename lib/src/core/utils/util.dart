import 'dart:convert';
import 'dart:io';

import 'dart:ui' as ui;
import 'package:bandeja/src/core/domain/padels/entities/duration.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:bandeja/src/owner/data/bookings/dto/padel.schedule.dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../domain/notifications/entities/notification.dart';

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/rendering.dart';

class Util {
  static bool isUrl(String x) {
    try {
      return Uri.parse(x).isAbsolute;
    } catch (e) {
      return false;
    }
  }

  static List<Map<String, DateTime>> getTimesOfADay(DurationModel duration) {
    DateTime startTime = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
    DateTime endTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 23, 59, 0);
    List<Map<String, DateTime>> result = [];
    for (DateTime index = startTime;
        index.isBefore(endTime);
        index = index.add(Duration(minutes: duration.minute))) {
      result.add({DateFormat.jm().format(index): index});
    }
    return result;
  }

  static List<PadelScheduleDto> getAllSchedules(
      DurationModel duration, DateTime startTime, DateTime endTime) {
    List<PadelScheduleDto> result = [];
    for (DateTime index = startTime;
        index.isBefore(endTime);
        index = index.add(Duration(minutes: duration.minute))) {
      result.add(PadelScheduleDto.empty(
          startTime: index,
          endTime: index.add(Duration(minutes: duration.minute))));
    }
    return result;
  }

  static String? validateStartTimeIsBeforeEndTime(
      DateTime? startTime, DateTime? endTime) {
    if (startTime == null && endTime == null) return null;
    if ((startTime == null && endTime != null) ||
        (endTime == null && startTime != null) ||
        endTime!.isBefore(startTime!) ||
        endTime.isAtSameMomentAs(startTime)) {
      return 'Start time must come before end time!';
    }
    return null;
  }

  static validEmail(String? emailAddress) {
    if (GetUtils.isEmail(emailAddress ?? '')) {
      return null;
    } else {
      return 'No valid email address!';
    }
  }

  static validPhoneNumber(String? phoneNumb) {
    if (GetUtils.isPhoneNumber(phoneNumb ?? '')) {
      return null;
    } else {
      return 'No valid phone number!';
    }
  }

  static validatePassworkStrong(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])');
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Password must be consists of uppercase latter, lower case latter, digit and special character.';
      } else {
        return null;
      }
    }
  }

  static String? validateNoEmpty(dynamic input) {
    if (input == null ||
        (input.runtimeType == String && input.trim().isEmpty)) {
      return 'Required Field!';
    }
    return null;
  }

  static String? validateMatch(dynamic newP, dynamic old) {
    if (newP == null || (newP.runtimeType == String && newP.trim().isEmpty)) {
      return 'Required Field!';
    }
    if (newP != old) {
      return 'password don\'t match!';
    }
    return null;
  }

  static String? validateGreaterThan(double? input, double min) {
    if (input == null || input <= min) {
      return 'Must be greater than $min!';
    }
    return null;
  }

  static String? phoneValidation(String? input) {
    if (input == null) return null;
    String? validation =
        GetUtils.isPhoneNumber(input) ? null : 'Not valid phone number!';
    return validation;
  }

  static String getDurationIn(num minute, {String showIn: 'H'}) {
    int hour = (minute / 60).toInt();
    int minutes = (minute % 60).toInt();
    return "${hour > 0 ? hour : ''} ${hour > 1 ? 'Hours' : (hour > 0) ? 'Hour' : ''} ${minutes > 0 ? minutes : ''} ${(minutes > 1) ? 'Minutes' : (minutes > 0) ? 'Minute' : ''}";
  }

  static List<DateTime> times(DateTime date) {
    List<DateTime> response = [];
    DateTime startTime = DateTime(date.year, date.month, date.day, 0, 0, 0);
    DateTime endTime = startTime.add(const Duration(hours: 24));
    for (DateTime index = startTime;
        index.isBefore(endTime);
        index = index.add(const Duration(hours: 1))) {
      response.add(index);
    }
    return response;
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Future GetImage(BuildContext context, Function(bool) isLoading,
      Function(String) onUpload) async {
    File image;
    var imagePicker =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    isLoading(true);
    if (imagePicker != null) {
      image = File(imagePicker.path);
      if (await image.exists()) {
        onUpload(imagePicker.path);
      }
    }
    isLoading(false);
  }

  static int unseenNotifications(List<NotificationModel> notifications) {
    int result = 0;
    for (var element in notifications) {
      if (!element.seen) result++;
    }
    return result;
  }

  static Future<void> launchUrI(Uri url) async {
    // final url = Uri.parse(path);
    if (!await launchUrl(url)) {
      throw UnExpectedFailure(message: 'Could not launch $url');
    }
  }

  static List<DateTime> dates(DateTime date) {
    List<DateTime> response = [];
    DateTime startTime = DateTime(date.year, date.month, date.day, 0, 0, 0);
    DateTime endTime = startTime.add(const Duration(days: 30));
    for (DateTime index = startTime.add(const Duration(hours: 24));
        index.isBefore(endTime);
        index = index.add(const Duration(days: 1))) {
      response.add(index);
    }
    return response;
  }

  static PadelScheduleModel? getAllSchedulesFirstFreeSopt(
      List<PadelScheduleModel> schedules) {
    List<PadelScheduleModel> sorted = schedules;
    sorted.sort((a, b) => a.startTime.isAfter(b.startTime) ? 1 : 0);

    for (PadelScheduleModel p in sorted) {
      if (!p.booked && p.status == 'free') {
        return p;
      }
    }
    return null;
  }

  static openwhatsapp(String whatsapp) async {
    var whatsappURl_android = "whatsapp://send?phone=$whatsapp";
    var whatappURL_ios = "https://wa.me/$whatsapp";
    if (Platform.isIOS) {
      // for iOS phone onlyS
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        AppSnackBar.failure(
            failure: UnExpectedFailure(
                message: "Please, install whatsApp first, and try again."));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        AppSnackBar.error(
            message: 'Please, install whatsApp first, and try again.');
      }
    }
  }

  static openPhone(String phoneNumber) async {
    if (await canLaunch('tel:$phoneNumber')) {
      await launch('tel:+$phoneNumber');
    } else {
      AppSnackBar.success(message: 'Sorry, Couldn\'t call $phoneNumber.');
    }
  }

  static Future<Uint8List?> capturePng(GlobalKey globalKey) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
      // print(pngBytes);
    } catch (e) {
      AppSnackBar.error(message: e.toString());
    }
  }
}
