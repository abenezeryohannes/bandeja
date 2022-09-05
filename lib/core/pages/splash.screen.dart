import 'dart:async';

import 'package:flutter/material.dart';
import 'package:app/injection.container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/animations/animate.dart';
import '../utils/animations/button.size.animation.dart';
import '../utils/animations/delayed.animation.dart';
import '../utils/setting.sp.dart';
import '../widgets/big.text.button.dart';
import 'home.page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late int delayedAmount;
  StreamController<Animate> buttonController =
      StreamController<Animate>.broadcast();
  StreamController<Animate> logoSizeController =
      StreamController<Animate>.broadcast();
  StreamController<Animate> logoBounceController =
      StreamController<Animate>.broadcast();

  @override
  void initState() {
    delayedAmount = 0;
    super.initState();
  }

  bool sizeDelayed = false;

  @override
  Widget build(BuildContext context) {
    // buttonController = StreamController<Animate>.broadcast();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ButtonSizeAnimation(
                    delay: delayedAmount + 1500,
                    milli: 1000,
                    curve: Curves.easeOut,
                    controller: logoBounceController,
                    begin: 0.95,
                    end: 1,
                    child: DelayedAnimation(
                      delay: delayedAmount + 1500,
                      offset: const Offset(0.0, 0.0),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 6 / 12,
                        child: Image.asset(
                          "assets/img/avatars.png",
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                  ),
                  DelayedAnimation(
                    delay: delayedAmount + 0,
                    offset: const Offset(0.0, -0.02),
                    child: Image.asset(
                      "assets/img/logo.png",
                      width: 90,
                      height: 90,
                      // color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              DelayedAnimation(
                delay: delayedAmount + 300,
                // offset: const Offset(0.0, 0.0),
                child: Image.asset(
                  "assets/img/app_logo_transparent.png",
                  // width: 150,
                  height: 80,
                  // color: Colors.white,
                ),
                // child: const Text("Voice",
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontWeight: FontWeight.w400,
                //         fontSize: 32)),
              ),
              const SizedBox(height: 10),
              DelayedAnimation(
                delay: delayedAmount + 600,
                // offset: const Offset(0.0, 0.0),
                child: Text("أمّة 2022",
                    style: TextStyle(
                        color: Colors.amber.shade500,
                        fontWeight: FontWeight.w600,
                        fontSize: 20)),
              ),
              const SizedBox(height: 10),
            ],
          ),
          Column(
            children: [
              DelayedAnimation(
                delay: delayedAmount + 900,
                // offset: const Offset(0.0, 0.0),
                child: const Text("برنامج التصويت الافتراضي",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 12)),
              ),
              const SizedBox(height: 5),
              DelayedAnimation(
                delay: delayedAmount + 1100,
                // offset: const Offset(0.0, 0.0),
                child: const Text("لانتخابات مجلس الأمة الكويتي 2022",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 12)),
              ),
              const SizedBox(height: 20),
              ButtonSizeAnimation(
                delay: delayedAmount + 3400,
                milli: 1000,
                controller: buttonController,
                begin: 0.50,
                curve: Curves.elasticOut,
                end: 1,
                child: BigTextButton(
                    onClick: () async {
                      SettingSP(prefs: sl<SharedPreferences>()).saveFirstTime();

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    },
                    text: "صوّت",
                    fontWight: FontWeight.bold,
                    fontSize: 18,
                    horizontalMargin: 42,
                    cornerRadius: 10,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15)),
              ),
              const SizedBox(height: 20),
            ],
          )
        ],
      )),
    );
  }
}
