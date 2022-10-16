import 'package:json_annotation/json_annotation.dart';
part 'user.dto.g.dart';

@JsonSerializable()
class UserDto {
  String fullName = "";
  String? avatar;
  String? UID;
  String? emailAddress;
  String? password;
  String role = "user";
  int? locationId;
  String? phoneNumber;
  bool enabled = true;
  String? localImage;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserDto(
      {required this.fullName,
      this.avatar,
      this.UID,
      this.localImage,
      this.emailAddress,
      this.password,
      required this.role,
      this.locationId,
      this.phoneNumber,
      this.enabled = true});

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
