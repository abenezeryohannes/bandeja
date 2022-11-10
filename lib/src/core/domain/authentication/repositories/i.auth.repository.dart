import 'package:bandeja/src/core/data/authentication/dto/user.dto.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../error/failure.dart';

abstract class IAuthRepository {
  Future<User?> verifyPhoneNumber(String phoneNumber);

  Future<User?> resendPhoneConfirmationCode();

  Future<Either<Failure, UserCredential>?> createUserWithEmailAndPassword(
      {required UserDto userDto});

  Future<Either<Failure, UserCredential>?> loginWIthEmailAndPassword(
      {required UserDto userDto});

  Future<Either<Failure, bool>?> signOut();

  Future<Either<Failure, bool>?> changePassword({required String newPassword});

  User? getUser();
  // UserCredential? getUser();
}
