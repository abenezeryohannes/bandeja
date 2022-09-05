import 'package:flutter/material.dart';
import 'package:app/core/widgets/big.text.button.dart';

class SignUpSuccess extends StatefulWidget {
  const SignUpSuccess({Key? key}) : super(key: key);

  @override
  State<SignUpSuccess> createState() => _SignUpSuccessState();
}

class _SignUpSuccessState extends State<SignUpSuccess> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.check_circle,
          size: 140,
          color: Colors.greenAccent,
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          "Registered Successffuly!",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 40,
        ),
        Center(
          child: BigTextButton(
            onClick: () => Navigator.maybePop(context),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            text: "continue",
            isExpanded: false,
          ),
        )
      ],
    );
  }
}
