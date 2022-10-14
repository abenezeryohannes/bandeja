import 'package:flutter/material.dart';

class ConfirmSlide extends StatefulWidget {
  const ConfirmSlide(
      {Key? key,
      required this.onResendCode,
      required this.code,
      required this.onCodeChange})
      : super(key: key);
  final Function() onResendCode;
  final Function(String val) onCodeChange;
  final String code;

  @override
  State<ConfirmSlide> createState() => _ConfirmSlideState();
}

class _ConfirmSlideState extends State<ConfirmSlide> {
  List<TextFormField> textForms = [];
  List<FocusNode> focusNodes = [];
  List<Card> lists = [];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _inputs(widget.code);
    _inputs2();
    if (widget.code.length < 4) {
      for (var element in focusNodes) {
        element.unfocus();
      }
      focusNodes[widget.code.length].requestFocus();
    }
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Phone Verification',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.grey.shade800),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Enter your OTP code here',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: lists,
          ),
        ),
        const SizedBox(
          height: 80,
        ),
        Text(
          "Didn't you received any code ?",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 14, color: Colors.grey.shade600),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            widget.onResendCode();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
            child: Text(
              'Resend a new code.',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 16, color: Colors.blueAccent),
            ),
          ),
        ),
      ],
    );
  }

  List<Card> _inputs2() {
    lists.clear();
    List<String> _response = _split(widget.code);
    for (int i = 0; i < _response.length; i++) {
      lists.add(Card(
          color: (_response[i] == ' ')
              ? Colors.grey.shade300
              : Theme.of(context).colorScheme.secondary,
          shape: const CircleBorder(),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                child: Center(child: textForms[i]),
              ))));
    }
    return lists;
  }

  List<String> _split(String value) {
    String response = value;
    if (value.length < 4) {
      for (int i = 0; i < 4 - value.length; i++) {
        response += ' ';
      }
    } else {
      response = value.substring(0, 4);
    }
    return response.split('');
  }

  void _inputs(String val) {
    textForms.clear();
    focusNodes.clear();
    controllers.clear();
    List<String> chars = _split(widget.code);
    for (int i = 0; i < chars.length; i++) {
      focusNodes.add(FocusNode());
      controllers.add(TextEditingController(text: chars[i]));
      controllers[i].addListener(() {
        if (controllers[i].text.isEmpty) {
          if (widget.code.isNotEmpty) {
            widget
                .onCodeChange(widget.code.substring(0, widget.code.length - 1));
          }
        }
      });
      textForms.add(TextFormField(
        enabled: false,
        focusNode: focusNodes[i],
        controller: controllers[i],
        style: Theme.of(context)
            .textTheme
            .headline4!
            .copyWith(color: Colors.white),
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        onChanged: (String val) {
          if (val.trim().isEmpty) {
            widget
                .onCodeChange(widget.code.substring(0, widget.code.length - 1));
            if (widget.code.isNotEmpty) {
              controllers[widget.code.length - 1].clear();
            }
          } else {
            widget.onCodeChange(widget.code + val.trim());
          }
        },
      ));
    }
  }
}
