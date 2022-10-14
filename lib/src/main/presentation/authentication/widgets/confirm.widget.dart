import 'package:bandeja/src/main/presentation/authentication/widgets/countdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfirmSlide extends StatefulWidget {
  const ConfirmSlide(
      {Key? key,
      required this.onResendCode,
      required this.code,
      required this.onFocustChange,
      required this.onCodeChange,
      this.error})
      : super(key: key);
  final Function() onResendCode;
  final Function(bool focus) onFocustChange;
  final Function(String val) onCodeChange;
  final String code;
  final String? error;

  @override
  State<ConfirmSlide> createState() => _ConfirmSlideState();
}

class _ConfirmSlideState extends State<ConfirmSlide> {
  List<TextFormField> textForms = [];
  List<FocusNode> focusNodes = [];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<Card> lists = [];
  List<TextEditingController> controllers = [];
  int countDownMaxNumber = 2;
  @override
  void initState() {
    _focusNode.addListener(() {
      widget.onFocustChange(_focusNode.hasFocus);
    });
    countDownMaxNumber = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.requestFocus();
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
        Stack(
          alignment: Alignment.center,
          children: [
            TextFormField(
              focusNode: _focusNode,
              textInputAction: TextInputAction.send,
              keyboardType: TextInputType.number,
              controller: _controller,
              onChanged: (val) {
                widget.onCodeChange(val.trim());
              },
            ),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  circle(widget.code, 0),
                  circle(widget.code, 1),
                  circle(widget.code, 2),
                  circle(widget.code, 3),
                  circle(widget.code, 4),
                  circle(widget.code, 5),
                ],
              ),
            ),
          ],
        ),
        if (widget.error != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    widget.error!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.red),
                  ),
                ),
              ],
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
            child: (countDownMaxNumber > 0)
                ? CountDown(
                    start: countDownMaxNumber,
                    onEnd: () {
                      setState(() {
                        countDownMaxNumber = 0;
                      });
                    })
                : InkWell(
                    onTap: () {
                      widget.onResendCode();
                      setState(() {
                        countDownMaxNumber = 2;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Resend a new code.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 16, color: Colors.blueAccent),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget circle(String c, int num) {
    return InkWell(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Card(
          color: (c.length <= num)
              ? Colors.grey.shade300
              : Theme.of(context).colorScheme.secondary,
          shape: const CircleBorder(),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                width: 30,
                height: 30,
                child: Center(
                  child: Text(c.length > num ? c[num] : '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white)),
                ),
              ))),
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
    if (value.length < 6) {
      for (int i = 0; i < 6 - value.length; i++) {
        response += ' ';
      }
    } else {
      response = value.substring(0, 6);
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
