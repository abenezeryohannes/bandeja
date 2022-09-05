import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SignUpEvent {}

class SignInEvent extends SignUpEvent {
  User user;
  // BuildContext context;
  SignInEvent({required this.user});
}

class SignUpInitialEvnent extends SignUpEvent {}

class OnVerficationComplete extends SignUpEvent {
  late PhoneAuthCredential credential;
  OnVerficationComplete({required this.credential});
}

class OnCodeSent extends SignUpEvent {
  late String verificationId;
  int? resendToken;
  OnCodeSent({required this.verificationId});
}

class OnVerificationFailed extends SignUpEvent {
  late FirebaseAuthException exception;
  OnVerificationFailed({required this.exception});
}

class OnCodeAutoRetrievalTimeout extends SignUpEvent {
  late String verificationId;
  OnCodeAutoRetrievalTimeout({required this.verificationId});
}

class VerifyEvent extends SignUpEvent {
  late String phoneNumber;
  VerifyEvent({required this.phoneNumber});
}

class ResendConfirmationCodeEvent extends SignUpEvent {
  late String resendToken;
  ResendConfirmationCodeEvent({required this.resendToken});
}

class ConfirmEvent extends SignUpEvent {
  late String code;
  // late BuildContext context;
  ConfirmEvent({required this.code});
}
