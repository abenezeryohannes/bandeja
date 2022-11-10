import 'package:bandeja/src/core/dto/wrapper.dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../dto/response.dto.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure implements Exception {
  factory Failure.cacheFailure(
      {@Default("No connection, please connect to the Internet and try again.")
          final String? message}) = CacheFailure;

  factory Failure.unExpectedFailure(
      {@Default("Sorry, Something went wrong, please try again later!")
          final String? message}) = UnExpectedFailure;

  factory Failure.notFound(
      {@Default("Sorry, we couldn't find what your looking for!")
          final String? message}) = NotFound;

  factory Failure.validationFailure(
      {@Default("Sorry, wrong or incomplete form is presented.")
          final String? message,
      String? key}) = ValidationFailure;

  factory Failure.noDataFailure(
      {@Default("Sorry, there is no data here yet.")
          final String? message}) = NoDataFailure;

  factory Failure.serverFailure(
      {@Default("Sorry, an error occurred on our part. Try again later.")
          final String? message}) = ServerFailure;

  factory Failure.networkFailure(
      {@Default("No connection, please connect to the Internet and try again.")
          final String? message}) = NetworkFailure;

  factory Failure.unauthorized(
      {@Default("Not authorized, please signup or login and try again.")
          final String? message}) = UnAuthorizedFailure;
  static Failure AssignFailureType(ResponseDto responseDto) {
    if (responseDto.statusCode == 403) {
      return UnAuthorizedFailure(message: responseDto.message);
    } else {
      return ServerFailure(message: responseDto.message);
    }
  }
}
