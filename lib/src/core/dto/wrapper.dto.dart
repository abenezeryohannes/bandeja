import 'package:freezed_annotation/freezed_annotation.dart';

import '../error/failure.dart';
part 'wrapper.dto.freezed.dart';

@freezed
class WrapperDto<T> with _$WrapperDto {
  factory WrapperDto.emptyState() = EmptyState;

  factory WrapperDto.loadingState({
    @Default(0) double percent,
  }) = LoadingState;

  factory WrapperDto.loadedState({
    required T value,
  }) = LoadedState;

  factory WrapperDto.errorState({
    required Failure failure,
  }) = ErrorState;
}
