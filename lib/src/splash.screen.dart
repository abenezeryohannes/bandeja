import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen(
      {super.key, required this.nextPage, this.milliseconds = 2500});
  final Widget nextPage;
  final int milliseconds;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  startTimer() async {
    var duration = Duration(milliseconds: widget.milliseconds);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget.nextPage));
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Container(
      alignment: Alignment.center,
      color: Colors.grey.shade50,
      // child: GifImage(
      //   controller: controller,
      //   image: const AssetImage("assets/icons/splash_screen.gif"),
      // )
      child: Image.asset(
        "assets/icons/splash_screen.gif",
        fit: BoxFit.fill,
      ),
    );
  }
}
