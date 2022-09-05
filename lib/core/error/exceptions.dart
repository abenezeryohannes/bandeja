class CacheException implements Exception {
  String? message =
      "لا يوجد اتصال ، يرجى الاتصال بالإنترنت والمحاولة مرة أخرى.";
  CacheException(
      {this.message =
          "لا يوجد اتصال ، يرجى الاتصال بالإنترنت والمحاولة مرة أخرى."});
}

class ServerSideException implements Exception {
  String? message = "عذرا ، حدث خطأ من جانبنا. حاول مرة أخرى في وقت لاحق.";

  ServerSideException(
      {this.message = "عذرا ، حدث خطأ من جانبنا. حاول مرة أخرى في وقت لاحق."});
}

class NoDataException implements Exception {
  String? message = "آسف ، لا توجد بيانات هنا حتى الآن.";
  NoDataException({this.message = "آسف ، لا توجد بيانات هنا حتى الآن."});
}

class NetworkException implements Exception {
  String? message =
      "لا يوجد اتصال ، يرجى الاتصال بالإنترنت والمحاولة مرة أخرى.";

  NetworkException(
      {this.message =
          "لا يوجد اتصال ، يرجى الاتصال بالإنترنت والمحاولة مرة أخرى."});
}
