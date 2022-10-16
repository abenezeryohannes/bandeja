import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future<User?> verifyPhoneNumber(String phoneNumber);
  Future<User?> resendPhoneConfirmationCode();
  User? getUser();
}
