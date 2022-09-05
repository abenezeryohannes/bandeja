import 'package:flutter/material.dart';

class ConfirmSlide extends StatefulWidget {
  const ConfirmSlide(
      {Key? key, required this.onCodeChanged, required this.onFucusChange})
      : super(key: key);

  final Function(bool) onFucusChange;
  final Function(String) onCodeChanged;
  @override
  State<ConfirmSlide> createState() => _ConfirmSlideState();
}

class _ConfirmSlideState extends State<ConfirmSlide> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 42.0),
              child: Text(
                "أدخل رمز التفعيل",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42.0, vertical: 10),
            child: Focus(
              onFocusChange: (hasFocus) {
                widget.onFucusChange(hasFocus);
              },
              child: TextFormField(
                style: const TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "000000",

                  focusColor: Colors.amber.shade400,
                  // constraints: BoxConstraints(maxHeight: 42),
                  filled: true, fillColor: Colors.white,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[500]),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.amber.shade400),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.amber.shade400),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  // errorText:     !validCode ? widget.tr('field_required') : null,
                ),
                onChanged: (val) {
                  widget.onCodeChanged(val);
                },
              ),
            )),
        const SizedBox(height: 5),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 44.0),
          child: Text(
            "تسجيلك في التطبيق هو موافقة منك على",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(height: 5),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 44.0),
          child: Text(
            "شروط الخصوصية",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
