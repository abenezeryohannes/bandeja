import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/features/authentication/domain/usecases/register.user.dart';
import 'package:app/features/authentication/presentation/bloc/sign_up/sign.up.event.dart';
import 'package:app/features/authentication/presentation/bloc/sign_up/sign.up.state.dart';
import '../../../domain/entities/user.dart' as MyUser;

import '../../../../../core/error/failure.dart';
import '../../../domain/usecases/firebase.auth.controller.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  late FireBaseAuthController fireBaseAuthController;
  late RegisterUser registerUser;
  SignUpBloc({required this.registerUser}) : super(NotVerifiedState()) {
    on<SignUpInitialEvnent>((event, emit) async {
      fireBaseAuthController = FireBaseAuthController(
          onVerficationComplete: (PhoneAuthCredential credential) async {
        add(OnVerficationComplete(credential: credential));
      }, onCodeSent: (String verificationId, int? resendToken) async {
        add(OnCodeSent(verificationId: verificationId));
      }, onCodeAutoRetrievalTimeout: (String verificationId) async {
        add(OnCodeAutoRetrievalTimeout(verificationId: verificationId));
      }, onVerificationFailed: (FirebaseAuthException exception) async {
        add(OnVerificationFailed(exception: exception));
      });
      emit(NotVerifiedState());
    });
    on<OnVerificationFailed>((event, emit) {
      emit(VerificationFailedState(
          failure: Failure(message: event.exception.message)));
    });
    on<OnCodeAutoRetrievalTimeout>((event, emit) {
      // ?
    });
    on<OnCodeSent>((event, emit) {
      emit(CodeSentState(
          verificationId: event.verificationId,
          resendToken: event.resendToken));
    });
    on<OnVerficationComplete>((event, emit) {
      emit(VerifiedState(phoneAuthCredential: event.credential));
    });
    on<VerifyEvent>((event, emit) async {
      FireBaseAuthController.isLogin = false;
      emit(VerifiyingState());
      FireBaseAuthController.FULLNAME = event.phoneNumber;
      await fireBaseAuthController.verifyPhoneNumber(event.phoneNumber);
    });
    on<ResendConfirmationCodeEvent>((event, emit) {});
    on<ConfirmEvent>((event, emit) async {
      emit(ConfirmingState());
      FireBaseAuthController.SMSCODE = event.code;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: FireBaseAuthController.VERIFICATION_ID,
          smsCode: event.code);
      try {
        await FirebaseAuth.instance.signInWithCredential(credential);

        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          add(SignInEvent(user: user));
        } else {
          emit(ConfirmationFailedState(
              failure: Failure(
                  message: "Sorry, something went wrong, please try again!")));
        }
      } on FirebaseAuthException catch (e) {
        emit(ConfirmationFailedState(failure: Failure(message: e.message)));
      } finally {}
    });
    on<SignInEvent>((event, emit) async {
      // emit(SignIn());
      MyUser.User myUser = MyUser.User(
        createdAt: DateTime.now().toString(),
        identifier: ((event.user.phoneNumber != null)
            ? event.user.phoneNumber!
            : "unknown"),
        uid: event.user.uid,
        id: "-1",
      );
      final response = await registerUser(SetParams(user: myUser));
      if (response == null) {
        emit(ConfirmedState(user: event.user));
        return;
      }
      final result = response.fold((l) => ConfirmationFailedState(failure: l),
          (r) => ConfirmedState(user: event.user));

      emit(result);
    });
  }

  // handleFailure(Failure failure) {
  //   switch (failure.runtimeType) {
  //     case CacheFailure:
  //       return VerificationFailedState(message: failure.message);
  //     case ServerFailure:
  //       return VerificationFailedState(message: failure.message);
  //     case ClientFailure:
  //       return VerificationFailedState(message: failure.message);
  //     case NoDataFailure:
  //       return VerificationFailedState(message: failure.message);
  //     default:
  //       return VerificationFailedState(message: 'Unexpected Error');
  //   }
  // }
}
