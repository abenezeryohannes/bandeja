import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failure.dart';

part 'auth.state.freezed.dart';

@freezed
class AuthState<T> with _$AuthState {
  factory AuthState.CodeSentState({
    required String verificationId,
    int? resendToken,
  }) = CodeSentState;

  factory AuthState.NotVerifiedState() = NotVerifiedState;

  factory AuthState.VerifiyingState() = VerifiyingState;

  factory AuthState.ConfirmingState() = ConfirmingState;

  factory AuthState.VerificationFailedState({
    required Failure failure,
  }) = VerificationFailedState;

  factory AuthState.ConfirmationFailedState({required Failure failure}) =
      ConfirmationFailedState;

  factory AuthState.VerifiedState({
    required PhoneAuthCredential phoneAuthCredential,
  }) = VerifiedState;

  factory AuthState.ConfirmedState({required User user}) = ConfirmedState;
}
