class CacheException implements Exception {
  String? message =
      "No connection, please connect to the Internet and try again.";
  CacheException(
      {this.message =
          "No connection, please connect to the Internet and try again."});
}

class ServerSideException implements Exception {
  String? message = "Sorry, an error occurred on our part. Try again later.";

  ServerSideException(
      {this.message =
          "Sorry, an error occurred on our part. Try again later."});
}

class NoDataException implements Exception {
  String? message = "Sorry, there is no data here yet.";
  NoDataException({this.message = "Sorry, there is no data here yet."});
}

class NetworkException implements Exception {
  String? message =
      "No connection, please connect to the Internet and try again.";

  NetworkException(
      {this.message =
          "No connection, please connect to the Internet and try again."});
}

class ValidationException implements Exception {
  final String key;
  String? message;
  ValidationException({
    required this.key,
    this.message = "Invalid Input",
  });
}
