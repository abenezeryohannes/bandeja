import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/error/failure.dart';

class SignUpState {}

class CodeSentState extends SignUpState {
  late String verificationId;
  int? resendToken;
  CodeSentState({required this.verificationId, this.resendToken});
}

class NotVerifiedState extends SignUpState {}

class VerifiyingState extends SignUpState {}

class ConfirmingState extends SignUpState {}

class VerificationFailedState extends SignUpState {
  late Failure failure;
  VerificationFailedState({required this.failure});
}

class ConfirmationFailedState extends SignUpState {
  late Failure failure;
  ConfirmationFailedState({required this.failure});
}

class VerifiedState extends SignUpState {
  late PhoneAuthCredential phoneAuthCredential;
  VerifiedState({required this.phoneAuthCredential});
}

class ConfirmedState extends SignUpState {
  late User user;
  ConfirmedState({required this.user});
}
