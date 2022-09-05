import 'package:app/core/pages/web.view.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection.container.dart';
import '../../../setting/presentation/bloc/bloc/setting.bloc.dart';

class SignUpSlide extends StatefulWidget {
  const SignUpSlide(
      {Key? key,
      required this.formKey,
      required this.onPhoneChanged,
      required this.onFucusChange})
      : super(key: key);

  final Function(bool) onFucusChange;
  final GlobalKey<FormState> formKey;
  final Function(String? phone) onPhoneChanged;

  @override
  State<SignUpSlide> createState() => _SignUpSlideState();
}

class _SignUpSlideState extends State<SignUpSlide> {
  // String initialCountry = 'ET';
  String initialCountry = 'KW';
  // PhoneNumber number = PhoneNumber(isoCode: 'ET');
  // PhoneNumber number = PhoneNumber(isoCode: 'KW');
  final TextEditingController phoneController = TextEditingController(text: "");
  SettingBloc settingBloc = sl<SettingBloc>();

  @override
  void initState() {
    super.initState();
    settingBloc.add(LoadSettingEvent());
  }

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
                  "رقم الهاتف",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )),
          ],
        ),

        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.only(right: 0.0, left: 10),
              child: Form(
                  key: widget.formKey,
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      widget.onFucusChange(hasFocus);
                    },
                    child: TextFormField(
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 8) {
                          return 'Invalid, phone format';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "00000000",
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 15,
                            ),
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: AssetImage(
                                "assets/img/flag2.png",
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text("+965",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        focusColor: Colors.amber.shade400,
                        // constraints: BoxConstraints(maxHeight: 42),
                        filled: true, fillColor: Colors.white,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500]),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.amber.shade400),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.amber.shade400),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        // errorText:     !validCode ? widget.tr('field_required') : null,
                      ),
                      onChanged: (val) {
                        widget.onPhoneChanged(val);
                      },
                    ),
                  )),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // terms and service

        Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
                children: <TextSpan>[
                  TextSpan(
                      text: ("تسجيلك في التطبيق هو موافقة منك على"),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            )),
        BlocProvider(
          create: (_) => settingBloc,
          child: BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: InkWell(
                  onTap: () {
                    if (state.runtimeType == SettingStateLoaded) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebViewPage(
                                  url: (state as SettingStateLoaded)
                                      .setting
                                      .privacy_url)));
                    }
                  },
                  child: const Text(
                    'شروط الخصوصية',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
