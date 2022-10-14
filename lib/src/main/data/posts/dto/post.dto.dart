import 'package:json_annotation/json_annotation.dart';
part 'post.dto.g.dart';

@JsonSerializable()
class PostDto {
  late int id;
  int? userId;
  String? title;
  String desc = "";
  String? whatsApp;
  String? phoneNumber;
  late bool featured;
  int? postGroupId;
  String price = '0.00';
  bool offer = true;
  late bool enabled = true;

  Map<String, dynamic> toJson() => _$PostDtoToJson(this);

  PostDto(
      {enabled = true,
      offer = false,
      price = '0.00',
      featured = false,
      id = -1});

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);
}
