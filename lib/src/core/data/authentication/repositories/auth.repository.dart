import 'package:bandeja/src/core/data/authentication/dto/user.dto.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/authentication/repositories/i.auth.repository.dart';
import '../../../error/failure.dart';

class AuthRepository implements IAuthRepository {
  static String PHONENUMBER = "";
  static String VERIFICATION_ID = "";
  static String IDENTIFIER = "";
  static bool isLogin = false;
  static int? RESEND_TOKEN;
  static String SMSCODE = "";
  static String FULLNAME = "";

  final void Function(PhoneAuthCredential credential)? onVerficationComplete;
  final Future<void> Function(String verificationId, int? resendToken)?
      onCodeSent;
  final void Function(String verificationId)? onCodeAutoRetrievalTimeout;
  final void Function(FirebaseAuthException e)? onVerificationFailed;

  AuthRepository(
      {this.onVerficationComplete,
      this.onCodeSent,
      this.onCodeAutoRetrievalTimeout,
      this.onVerificationFailed});

  @override
  Future<User?> verifyPhoneNumber(String phoneNumber) async {
    IDENTIFIER = "phone_number";
    PHONENUMBER = phoneNumber;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerficationComplete ?? (_) => {},
      verificationFailed: onVerificationFailed ?? (_) => {},
      codeSent: (String verificationId, int? resendToken) {
        VERIFICATION_ID = verificationId;
        RESEND_TOKEN = resendToken;
        if (onCodeSent != null) {
          onCodeSent!(verificationId, resendToken);
        }
      },
      // timeout: const Duration(seconds: 120),
      forceResendingToken: RESEND_TOKEN,
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = VERIFICATION_ID;
        if (onCodeAutoRetrievalTimeout != null) {
          onCodeAutoRetrievalTimeout!(verificationId);
        }
      },
    );
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Future<User?> resendPhoneConfirmationCode() async {
    IDENTIFIER = "phone_number";
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: PHONENUMBER,
      verificationCompleted: onVerficationComplete ?? (_) => {},
      verificationFailed: onVerificationFailed ?? (_) => {},
      codeSent: (String verificationId, int? resendToken) {
        VERIFICATION_ID = verificationId;
        RESEND_TOKEN = resendToken;
        if (onCodeSent != null) {
          onCodeSent!(verificationId, resendToken);
        }
      },
      // timeout: const Duration(seconds: 120),
      forceResendingToken: RESEND_TOKEN,
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = VERIFICATION_ID;
        if (onCodeAutoRetrievalTimeout != null) {
          onCodeAutoRetrievalTimeout!(verificationId);
        }
      },
    );
    return FirebaseAuth.instance.currentUser;
  }

  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Future<Either<Failure, UserCredential>?> loginWIthEmailAndPassword(
      {required UserDto userDto}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userDto.emailAddress!, password: userDto.password!);
      return Right(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(
            UnExpectedFailure(message: 'No user found with this email!'));
      } else if (e.code == 'wrong-password') {
        return Left(UnExpectedFailure(message: 'Wrong password!'));
      } else {
        return Left(UnExpectedFailure(message: e.message));
      }
    } catch (e) {
      return Left(UnExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserCredential>?> createUserWithEmailAndPassword(
      {required UserDto userDto}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userDto.emailAddress!, password: userDto.password!);
      return Right(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Left(
            UnExpectedFailure(message: 'The password provided is too weak!'));
      } else if (e.code == 'email-already-in-use') {
        return Left(UnExpectedFailure(
            message:
                'An account with this email already exists! Try to sign up instead.'));
      } else {
        return Left(UnExpectedFailure(message: e.message));
      }
    } catch (e) {
      return Left(UnExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>?> changePassword(
      {required String newPassword}) async {
    try {
      User? user = getUser();

      if (user == null) {
        Left(UnExpectedFailure(
            message:
                'Sorry, seems like we are encountering some issue, maybe if you login again it might fix the pro!'));
      }
      await user?.updatePassword(newPassword);
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Left(
            UnExpectedFailure(message: 'The password provided is too weak!'));
      } else {
        return Left(UnExpectedFailure(message: e.message));
      }
    } catch (e) {
      return Left(UnExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>?> deleteUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
      }
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(UnExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>?> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(UnExpectedFailure(message: e.toString()));
    }
  }
}
