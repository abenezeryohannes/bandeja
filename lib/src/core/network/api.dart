import 'dart:io';

import 'package:bandeja/src/main/domain/core/entities/location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../error/failure.dart';
import '../utils/util.dart';

class Api {
  static bool isProduction() =>
      dotenv.env['ENV']?.toLowerCase().startsWith('prod') ?? false;

  static String? hostUrl() =>
      "${isProduction() ? dotenv.env['HOST_URL'] : dotenv.env['DEBUG_HOST_URL']}/${dotenv.env['HOST_URL_PREFIX']}";

  static Uri request(String path) => Uri.parse("${hostUrl()}/$path");
  static Uri getRequestWithParams(String path, Map<String, dynamic> query) =>
      Uri.parse("${hostUrl()}/$path").replace(queryParameters: query);

  static Map<String, String>? getHeader(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": token,
      };

  static Map<String, String>? postHeader(String token) => {
        "Authorization": token,
      };

  static Map<String, String>? multipartHeader(String token) => {
        'Content-Type': 'multipart/form-data',
        'Accept': '*/*',
        "Authorization": token,
      };

  static GetListQuery({int? page, int? limit}) {
    Map<String, String> query = <String, String>{};

    query.addEntries({'page': '${page ?? 1}'}.entries);

    if (limit != null) {
      query.addEntries({'limit': '$limit'}.entries);
    }

    return query;
  }

  static String getMedia(String x) {
    if (Util.isUrl(x)) return x;
    return "${hostUrl()}/media?path=$x";
  }

  static Uri mapUrI(LocationModel location) {
    // final url = 'geo:${location.latitude},${location.longitude}';
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}';

    return Uri.parse(googleUrl);
  }

  static Future<MultipartRequest> addImage(
      {required String name,
      String? path,
      required MultipartRequest request}) async {
    if (path != null && path.isNotEmpty) {
      File file = File(path);
      if (!(await file.exists())) {
        throw Failure.unExpectedFailure(message: "File not found");
      }
      String? memeTD = lookupMimeType(path, headerBytes: [0xFF, 0xD8]);

      List<String> memes =
          memeTD == null ? ['image', 'jpg'] : memeTD.split('/');

      request.files.add(MultipartFile(
          name, File(path).readAsBytes().asStream(), File(path).lengthSync(),
          filename: path.split("/").last,
          contentType: MediaType(memes[0], memes[1])));
      return request;
    } else {
      return request;
    }
  }
}
