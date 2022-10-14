// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ResponseDto _$$_ResponseDtoFromJson(Map<String, dynamic> json) =>
    _$_ResponseDto(
      statusCode: json['statusCode'] as int? ?? 200,
      success: json['success'] as bool? ?? true,
      data: json['data'] ?? null,
      message: json['message'] as String?,
      count: json['count'] as int?,
      page: json['page'] as int? ?? 1,
      totalPages: json['totalPages'] as int? ?? 1,
      limit: json['limit'] as int? ?? 25,
      sortBy: json['sortBy'] as String?,
      sort: json['sort'] as String?,
    );

Map<String, dynamic> _$$_ResponseDtoToJson(_$_ResponseDto instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
      'count': instance.count,
      'page': instance.page,
      'totalPages': instance.totalPages,
      'limit': instance.limit,
      'sortBy': instance.sortBy,
      'sort': instance.sort,
    };
