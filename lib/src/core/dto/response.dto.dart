import 'package:freezed_annotation/freezed_annotation.dart';
part 'response.dto.freezed.dart';
part 'response.dto.g.dart';

@freezed
class ResponseDto with _$ResponseDto {
  factory ResponseDto(
      {@Default(200) int statusCode,
      @Default(false) bool success,
      @Default(null) dynamic data,
      String? message,
      int? count,
      @Default(1) int page,
      @Default(1) int totalPages,
      @Default(25) int limit,
      String? sortBy,
      String? sort}) = _ResponseDto;

  factory ResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ResponseDtoFromJson(json);
}
