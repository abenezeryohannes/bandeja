import 'package:bandeja/src/core/domain/authentication/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad.freezed.dart';
part 'ad.g.dart';

@freezed
class AdModel with _$AdModel {
  factory AdModel({
    @Default(-1) int id,
    @Default(-1) int userId,
    required String banner,
    @Default('') String link,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? User,
  }) = _AdModel;

  factory AdModel.fromJson(Map<String, Object?> json) =>
      _$AdModelFromJson(json);
}

extension AdModelX on AdModel {
  UserModel getUser() {
    return this.User ?? UserModel(fullName: '    ');
  }
}
