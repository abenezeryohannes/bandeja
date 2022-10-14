import 'package:bandeja/main/injection/injector.dart';
import 'package:bandeja/src/core/data/authentication/source/auth.local.data.source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../core/network/network.info.dart';
import '../../domain/authentication/repositories/i.auth.repository.dart';
import 'source/auth.remote.datasource.dart';

@Singleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  static String PHONENUMBER = "";
  static String VERIFICATION_ID = "";
  static String IDENTIFIER = "";
  static bool isLogin = false;
  static int? RESEND_TOKEN;
  static String SMSCODE = "";
  static String FULLNAME = "";

  final void Function(PhoneAuthCredential credential) onVerficationComplete;
  final Future<void> Function(String verificationId, int? resendToken)
      onCodeSent;
  final void Function(String verificationId) onCodeAutoRetrievalTimeout;
  final void Function(FirebaseAuthException e) onVerificationFailed;

  INetworkInfo networkInfo = getIt<INetworkInfo>();
  AuthRemoteDataSource remoteDataSource = getIt<AuthRemoteDataSource>();
  AuthLocalDataSource localDataSource = getIt<AuthLocalDataSource>();

  AuthRepository(
      {required this.onVerficationComplete,
      required this.onCodeSent,
      required this.onCodeAutoRetrievalTimeout,
      required this.onVerificationFailed});

  @override
  Future<User?> verifyPhoneNumber(String phoneNumber) async {
    IDENTIFIER = "phone_number";
    PHONENUMBER = phoneNumber;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerficationComplete,
      verificationFailed: onVerificationFailed,
      codeSent: (String verificationId, int? resendToken) {
        VERIFICATION_ID = verificationId;
        RESEND_TOKEN = resendToken;
        onCodeSent(verificationId, resendToken);
      },
      // timeout: const Duration(seconds: 120),
      forceResendingToken: RESEND_TOKEN,
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = VERIFICATION_ID;
        onCodeAutoRetrievalTimeout(verificationId);
      },
    );
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Future<User?> resendPhoneConfirmationCode() async {
    IDENTIFIER = "phone_number";
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: PHONENUMBER,
      verificationCompleted: onVerficationComplete,
      verificationFailed: onVerificationFailed,
      codeSent: (String verificationId, int? resendToken) {
        VERIFICATION_ID = verificationId;
        RESEND_TOKEN = resendToken;
        onCodeSent(verificationId, resendToken);
      },
      // timeout: const Duration(seconds: 120),
      forceResendingToken: RESEND_TOKEN,
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = VERIFICATION_ID;
        onCodeAutoRetrievalTimeout(verificationId);
      },
    );
    return FirebaseAuth.instance.currentUser;
  }

  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
