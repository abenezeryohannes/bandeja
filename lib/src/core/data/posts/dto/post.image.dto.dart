import 'package:json_annotation/json_annotation.dart';
part 'post.image.dto.g.dart';

@JsonSerializable()
class PostImageDto {
  late int id;
  int? postId;
  String? img;
  String? localImg;

  PostImageDto({id = -1, this.localImg, this.img});

  factory PostImageDto.fromJson(Map<String, dynamic> json) =>
      _$PostImageDtoFromJson(json);
}
