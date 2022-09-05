import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';
part 'user.model.g.dart';

@JsonSerializable()
class UserModel extends User {
  UserModel(
      {required super.id,
      super.uid,
      required super.createdAt,
      super.votedFor,
      required super.identifier});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
