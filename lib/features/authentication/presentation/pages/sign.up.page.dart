import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/features/authentication/presentation/bloc/sign_up/sign.up.bloc.dart';
import 'package:app/features/authentication/presentation/bloc/sign_up/sign.up.event.dart';
import 'package:app/features/authentication/presentation/widgets/sign.up.success.dart';

import '../../../../core/widgets/loading.bar.dart';
import '../../../../injection.container.dart';
import '../bloc/sign_up/sign.up.state.dart';
import '../widgets/confirm.slide.dart';
import '../widgets/sign.up.slide.dart';
import '../../../../core/widgets/big.text.button.dart';

class SIgnUpPage extends StatefulWidget {
  const SIgnUpPage({Key? key, required this.onClick}) : super(key: key);
  final void Function(BuildContext context) onClick;

  @override
  State<SIgnUpPage> createState() => _SIgnUpPageState();
}

class _SIgnUpPageState extends State<SIgnUpPage> {
  late int pageIndex;

  late String? error;
  late bool loading;
  late String? confirmationCode;
  late BuildContext _context;
  User? user;
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? phoneNumber;
  late SignUpBloc signUpBloc;
  late SignUpState signUpState;
  bool popped = true;
  late bool isKeyboardOpen;

  @override
  void initState() {
    popped = true;
    isKeyboardOpen = false;
    loading = false;
    pageIndex = 0;
    signUpBloc = sl<SignUpBloc>();
    signUpBloc.add(SignUpInitialEvnent());
    signUpState = NotVerifiedState();
    error = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(" xx ${MediaQuery.of(context).viewInsets.bottom}");
    _context = context;
    return WillPopScope(
      onWillPop: () async {
        if (pageIndex > 0) {
          return Future.value(true);
        } else if (pageIndex == 1) {
          moveTo(0, true);
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // if (loading) const LoadingBar(),
              Center(
                child: SizedBox(
                  height: 30,
                  child: Icon(
                    Icons.maximize,
                    size: 50,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              if (MediaQuery.of(context).viewInsets.bottom < 10)
                Padding(
                  padding: EdgeInsets.zero,
                  child: Image.asset(
                    "assets/img/registration.png",
                    width: 110,
                    height: 110,
                  ),
                ),
              if (MediaQuery.of(context).viewInsets.bottom < 10)
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("سجل للتصويت",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 42)),
                ),
              if (MediaQuery.of(context).viewInsets.bottom < 10)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("للتسجيل أدخل رقم الهاتف الخاص بك",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400,
                          fontSize: 12)),
                ),
              if (MediaQuery.of(context).viewInsets.bottom < 10)
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text("ليصلك رمز التفعيل",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400,
                          fontSize: 12)),
                ),
              if (!isKeyboardOpen) const SizedBox(height: 22),
              _body()
            ],
          ),
        )),
      ),
    );
  }

  Widget _body() {
    return BlocProvider(
      create: (_) => signUpBloc,
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          loading = false;
          error = null;

          switch (state.runtimeType) {
            case CodeSentState:
              moveTo(1, false);
              break;
            case NotVerifiedState:
              break;
            case VerifiyingState:
              loading = true;
              break;
            case ConfirmingState:
              loading = true;
              break;
            case VerificationFailedState:
              error = (state as VerificationFailedState).failure.message;
              break;
            case ConfirmationFailedState:
              error = (state as ConfirmationFailedState).failure.message;
              break;
            case VerifiedState:
              break;
            case ConfirmedState:
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (popped) {
                  widget.onClick(context);
                  popped = false;
                }
              });
              return Column(
                children: [
                  SizedBox(
                      height: (MediaQuery.of(context).size.height * (2 / 12))),
                  const SignUpSuccess(),
                ],
              );
            default:
          }
          return Column(children: [
            SizedBox(
              height: 180,
              child: _pageView(pageIndex),
            ),
            if (loading)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.amber.shade400,
                      ),
                    )
                  ],
                ),
              ),
            if (error != null)
              Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 42.0),
                child: Column(
                  children: [
                    Text(
                      error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
            const SizedBox(
              height: 10,
            ),
            (WidgetsBinding.instance.window.viewInsets.bottom <= 0.0)
                ? _button(context)
                : const SizedBox(),
          ]);
        },
      ),
    );
  }

  void moveTo(int page, bool update) {
    if (update) {
      setState(() {
        pageIndex = page;
      });
    } else {
      pageIndex = page;
    }
  }

  Widget _pageView(int page) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 3 / 13,
      child: pageSlide(page),
    );
  }

  Widget pageSlide(int page) {
    if (page == 0) {
      return SignUpSlide(
        onPhoneChanged: (String? phone) {
          phoneNumber = phone;
        },
        onFucusChange: (val) {
          // setState(() {
          //   isKeyboardOpen = val;
          // });
        },
        formKey: formKey,
      );
    }
    return ConfirmSlide(
      onCodeChanged: (val) {
        confirmationCode = val;
      },
      onFucusChange: (val) {
        // setState(() {
        //   isKeyboardOpen = val;
        // });
      },
    );
  }

  Widget _button(BuildContext context) {
    return BigTextButton(
        onClick: () {
          if (pageIndex == 0) {
            onSignUpClicked();
          } else if (pageIndex == 1) {
            onConfirmClicked(context);
          } else {
            widget.onClick(context);
          }
        },
        text: (pageIndex == 0)
            ? "تسـجـيل"
            : ((pageIndex == 1) ? "تسـجـيل" : "Continue"),
        cornerRadius: 10,
        fontSize: 18,
        elevation: 0,
        isExpanded: false,
        horizontalMargin: 40,
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15));
  }

  onSignUpClicked() async {
    FocusScope.of(_context).unfocus();
    if (formKey.currentState != null &&
        formKey.currentState!.validate() &&
        phoneNumber != null) {
      formKey.currentState!.save();
      setState(() {
        error = null;
      });
    } else {
      FocusScope.of(_context).unfocus();
      setState(() {
        loading = false;
      });
      return;
    }
    formKey.currentState?.validate();
    signUpBloc.add(VerifyEvent(phoneNumber: "+965$phoneNumber"));
  }

  void onConfirmClicked(BuildContext context) async {
    if (confirmationCode == null) return;
    signUpBloc.add(ConfirmEvent(code: confirmationCode!));
  }
}
