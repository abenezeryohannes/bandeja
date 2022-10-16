import 'dart:async';

import 'package:flutter/material.dart';

class CountDown extends StatefulWidget {
  const CountDown({Key? key, required this.start, required this.onEnd})
      : super(key: key);

  final int start;
  final Function onEnd;

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  late Duration myDuration;
  late Timer countdownTimer;

  @override
  void initState() {
    myDuration = Duration(minutes: widget.start);
    startTimer();
    super.initState();
  }

  void startTimer() {
    if (mounted) {
      countdownTimer =
          Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    }
  }

  void stopTimer() {
    if (mounted) {
      setState(() => countdownTimer.cancel());
    }
  }

  void resetTimer() {
    stopTimer();
    if (mounted) {
      setState(() => myDuration = const Duration(minutes: 2));
    }
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
  }

  // Step 6
  void setCountDown() {
    const reduceSecondsBy = 1;
    if (mounted) {
      setState(() {
        final seconds = myDuration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          countdownTimer.cancel();
          widget.onEnd();
        } else {
          myDuration = Duration(seconds: seconds);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return Column(
      children: [
        // const SizedBox(
        //   height: 50,
        // ),
        // Step 8
        Text(
          '$minutes:$seconds',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
              fontSize: 14),
        ),
        const SizedBox(height: 20),
        // Step 9
        // ElevatedButton(
        //   onPressed: startTimer,
        //   child: const Text(
        //     'Start',
        //     style: TextStyle(
        //       fontSize: 30,
        //     ),
        //   ),
        // ),
        // // Step 10
        // ElevatedButton(
        //   onPressed: () {
        //     if (countdownTimer == null || countdownTimer!.isActive) {
        //       stopTimer();
        //     }
        //   },
        //   child: const Text(
        //     'Stop',
        //     style: TextStyle(
        //       fontSize: 30,
        //     ),
        //   ),
        // ),
        // // Step 11
        // ElevatedButton(
        //     onPressed: () {
        //       resetTimer();
        //     },
        //     child: const Text(
        //       'Reset',
        //       style: TextStyle(
        //         fontSize: 30,
        //       ),
        //     ))
      ],
    );
  }
}
