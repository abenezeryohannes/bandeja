import 'package:bandeja/src/core/data/authentication/dto/location.dto.dart';
import 'package:bandeja/src/core/domain/authentication/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.dto.g.dart';

@JsonSerializable()
class UserDto {
  String? fullName;
  String? avatar;
  String? UID;
  String? emailAddress;
  String? password;
  String role = "user";
  int? locationId;
  String? phoneNumber;
  bool enabled = true;
  String? localImage;
  bool? bookingNotification;
  bool? faceId;
  LocationDto? Location;

  UserDto(
      {this.fullName,
      this.avatar,
      this.UID,
      this.localImage,
      this.emailAddress,
      this.password,
      required this.role,
      this.locationId,
      this.phoneNumber,
      this.faceId,
      this.bookingNotification,
      this.Location,
      this.enabled = true});

  UserDto.fromModel(UserModel model) {
    fullName = model.fullName;
    avatar = model.avatar;
    UID = model.UID;
    emailAddress = model.emailAddress;
    password = model.password;
    role = model.role;
    locationId = model.locationId;
    phoneNumber = model.phoneNumber;
    enabled = model.enabled;
    faceId = model.Setting?.faceId;
    Location =
        model.Location != null ? LocationDto.fromModel(model.Location) : null;
    bookingNotification = model.Setting?.bookingNotification;
  }

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
