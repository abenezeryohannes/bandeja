// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'response.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ResponseDto _$ResponseDtoFromJson(Map<String, dynamic> json) {
  return _ResponseDto.fromJson(json);
}

/// @nodoc
mixin _$ResponseDto {
  int get statusCode => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  String? get sortBy => throw _privateConstructorUsedError;
  String? get sort => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResponseDtoCopyWith<ResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponseDtoCopyWith<$Res> {
  factory $ResponseDtoCopyWith(
          ResponseDto value, $Res Function(ResponseDto) then) =
      _$ResponseDtoCopyWithImpl<$Res>;
  $Res call(
      {int statusCode,
      bool success,
      dynamic data,
      String? message,
      int? count,
      int page,
      int totalPages,
      int limit,
      String? sortBy,
      String? sort});
}

/// @nodoc
class _$ResponseDtoCopyWithImpl<$Res> implements $ResponseDtoCopyWith<$Res> {
  _$ResponseDtoCopyWithImpl(this._value, this._then);

  final ResponseDto _value;
  // ignore: unused_field
  final $Res Function(ResponseDto) _then;

  @override
  $Res call({
    Object? statusCode = freezed,
    Object? success = freezed,
    Object? data = freezed,
    Object? message = freezed,
    Object? count = freezed,
    Object? page = freezed,
    Object? totalPages = freezed,
    Object? limit = freezed,
    Object? sortBy = freezed,
    Object? sort = freezed,
  }) {
    return _then(_value.copyWith(
      statusCode: statusCode == freezed
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: totalPages == freezed
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      limit: limit == freezed
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      sortBy: sortBy == freezed
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String?,
      sort: sort == freezed
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ResponseDtoCopyWith<$Res>
    implements $ResponseDtoCopyWith<$Res> {
  factory _$$_ResponseDtoCopyWith(
          _$_ResponseDto value, $Res Function(_$_ResponseDto) then) =
      __$$_ResponseDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {int statusCode,
      bool success,
      dynamic data,
      String? message,
      int? count,
      int page,
      int totalPages,
      int limit,
      String? sortBy,
      String? sort});
}

/// @nodoc
class __$$_ResponseDtoCopyWithImpl<$Res> extends _$ResponseDtoCopyWithImpl<$Res>
    implements _$$_ResponseDtoCopyWith<$Res> {
  __$$_ResponseDtoCopyWithImpl(
      _$_ResponseDto _value, $Res Function(_$_ResponseDto) _then)
      : super(_value, (v) => _then(v as _$_ResponseDto));

  @override
  _$_ResponseDto get _value => super._value as _$_ResponseDto;

  @override
  $Res call({
    Object? statusCode = freezed,
    Object? success = freezed,
    Object? data = freezed,
    Object? message = freezed,
    Object? count = freezed,
    Object? page = freezed,
    Object? totalPages = freezed,
    Object? limit = freezed,
    Object? sortBy = freezed,
    Object? sort = freezed,
  }) {
    return _then(_$_ResponseDto(
      statusCode: statusCode == freezed
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: totalPages == freezed
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      limit: limit == freezed
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      sortBy: sortBy == freezed
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String?,
      sort: sort == freezed
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ResponseDto implements _ResponseDto {
  _$_ResponseDto(
      {this.statusCode = 200,
      this.success = false,
      this.data = null,
      this.message,
      this.count,
      this.page = 1,
      this.totalPages = 1,
      this.limit = 25,
      this.sortBy,
      this.sort});

  factory _$_ResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_ResponseDtoFromJson(json);

  @override
  @JsonKey()
  final int statusCode;
  @override
  @JsonKey()
  final bool success;
  @override
  @JsonKey()
  final dynamic data;
  @override
  final String? message;
  @override
  final int? count;
  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int totalPages;
  @override
  @JsonKey()
  final int limit;
  @override
  final String? sortBy;
  @override
  final String? sort;

  @override
  String toString() {
    return 'ResponseDto(statusCode: $statusCode, success: $success, data: $data, message: $message, count: $count, page: $page, totalPages: $totalPages, limit: $limit, sortBy: $sortBy, sort: $sort)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ResponseDto &&
            const DeepCollectionEquality()
                .equals(other.statusCode, statusCode) &&
            const DeepCollectionEquality().equals(other.success, success) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.count, count) &&
            const DeepCollectionEquality().equals(other.page, page) &&
            const DeepCollectionEquality()
                .equals(other.totalPages, totalPages) &&
            const DeepCollectionEquality().equals(other.limit, limit) &&
            const DeepCollectionEquality().equals(other.sortBy, sortBy) &&
            const DeepCollectionEquality().equals(other.sort, sort));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(statusCode),
      const DeepCollectionEquality().hash(success),
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(count),
      const DeepCollectionEquality().hash(page),
      const DeepCollectionEquality().hash(totalPages),
      const DeepCollectionEquality().hash(limit),
      const DeepCollectionEquality().hash(sortBy),
      const DeepCollectionEquality().hash(sort));

  @JsonKey(ignore: true)
  @override
  _$$_ResponseDtoCopyWith<_$_ResponseDto> get copyWith =>
      __$$_ResponseDtoCopyWithImpl<_$_ResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ResponseDtoToJson(
      this,
    );
  }
}

abstract class _ResponseDto implements ResponseDto {
  factory _ResponseDto(
      {final int statusCode,
      final bool success,
      final dynamic data,
      final String? message,
      final int? count,
      final int page,
      final int totalPages,
      final int limit,
      final String? sortBy,
      final String? sort}) = _$_ResponseDto;

  factory _ResponseDto.fromJson(Map<String, dynamic> json) =
      _$_ResponseDto.fromJson;

  @override
  int get statusCode;
  @override
  bool get success;
  @override
  dynamic get data;
  @override
  String? get message;
  @override
  int? get count;
  @override
  int get page;
  @override
  int get totalPages;
  @override
  int get limit;
  @override
  String? get sortBy;
  @override
  String? get sort;
  @override
  @JsonKey(ignore: true)
  _$$_ResponseDtoCopyWith<_$_ResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}
