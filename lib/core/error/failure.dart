import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  String? message = "عذرا، هناك خطأ ما. حاول مرة أخرى في وقت لاحق.";
  static String FIREBASE_KEY =
      "عذرًا ، لم يتم إرجاع أي مفتاح جديد! ، حاول مرة أخرى لاحقًا.";
  Failure({this.message});
  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  CacheFailure({super.message});
}

class ServerFailure extends Failure {
  ServerFailure({super.message});
}

class NetworkFailure extends Failure {
  NetworkFailure({super.message});
}

class ClientFailure extends Failure {
  ClientFailure({super.message});
}

class NoDataFailure extends Failure {
  NoDataFailure({super.message});
}
