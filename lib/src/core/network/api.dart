import 'dart:io';

import 'package:feekpadel/src/core/error/failure.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../utils/util.dart';

class Api {
  static String? hostUrl() =>
      "${dotenv.env['HOST_URL']}/${dotenv.env['HOST_URL_PREFIX']}";

  static Uri request(String path) => Uri.parse("${hostUrl()}/$path");
  static Uri getRequestWithParams(String path, Map<String, dynamic> query) =>
      Uri.parse("${hostUrl()}/$path").replace(queryParameters: query);

  static Map<String, String>? header(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": token,
      };

  static Map<String, String>? multipartHeader(String token) => {
        'Content-Type': 'multipart/form-data',
        'Accept': '*/*',
        "Authorization": token,
      };

  static String getMedia(String x) {
    if (Util.isUrl(x)) return x;
    return "${hostUrl()}/media?path=$x";
  }

  // static Future<String?> uploadImage({required List<String> pathes}) async {
  //   if (pathes.isEmpty) return null;
  //   File file = File(pathes[0]);

  //   try {
  //     if (!(await file.exists()))
  //       throw Failure.unExpectedFailure(message: "File not found");

  //     String fileName = file.path.split('/').last;

  //     FormData data = FormData.fromMap({
  //       "action": "upload",
  //       "source": await MultipartFile.fromFile(
  //         file.path,
  //         filename: fileName,
  //         //contentType: MediaType("image", (fileName.contains("png"))?"png":"jpeg"),
  //       ),
  //       //"type": "image/jpg"
  //     });

  //     var request = new http.MultipartRequest("POST", url);
  //     request.fields['user'] = 'someone@somewhere.com';
  //     request.files.add(http.MultipartFile.fromPath(
  //       'package',
  //       'build/package.tar.gz',
  //       contentType: new MediaType('application', 'x-tar'),
  //     ));
  //     request.send().then((response) {
  //       if (response.statusCode == 200) print("Uploaded!");
  //     });

  //     Dio dio = Dio();
  //     // dio.options.queryParameters["key"] = "";
  //     // dio.options.headers["authorization"] = "${user.getToken().token}";
  //     Response response = await dio.post(path,
  //         data: data,
  //         options: Options(headers: {
  //           "accept": "*/*",
  //           // "Authorization": "${user.getToken().token}"
  //         }));
  //     if (response.data["status_code"] == 200) {
  //       AlertBox()
  //           .showSnackBarSuccess(context: context, text: "Image Uploaded");
  //       return response.data["image"]["url"];
  //     } else {
  //       String error = response.data["error"]["message"];
  //       AlertBox().showSnackBarError(context: context, text: error);
  //     }
  //     print(response);
  //   } on DioError catch (e) {
  //     print("uploading error: ${e.toString()}");
  //     rethrow;
  //   }
  // }
}
