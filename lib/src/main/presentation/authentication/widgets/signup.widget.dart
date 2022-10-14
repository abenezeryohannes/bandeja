import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controllers/signup.page.controller.dart';

class SignupSlide extends StatefulWidget {
  const SignupSlide(
      {Key? key,
      required this.onChanged,
      required this.value,
      required this.hint,
      this.error,
      required this.countries,
      required this.country,
      required this.onCountryChange,
      required this.onFocustChange})
      : super(key: key);
  final Function(String val) onChanged;
  final Function(Country val) onCountryChange;
  final String value;
  final String? error;
  final Function(bool) onFocustChange;
  final String hint;
  final List<Country> countries;
  final Country country;
  @override
  State<SignupSlide> createState() => _SignupSlideState();
}

class _SignupSlideState extends State<SignupSlide> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(() {
      widget.onFocustChange(_focusNode.hasFocus);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.requestFocus();
    return Column(children: [
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          'Verify your phone number',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: Colors.grey.shade800),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          'We will send you a confirmation code within 2 minutes for authentication.',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.normal, fontSize: 16),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: TextFormField(
          focusNode: _focusNode,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          keyboardType: TextInputType.phone,
          initialValue: widget.value,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.start,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
            focusColor: Colors.grey.shade800,
            prefixIcon: _countrySelector(),
            prefixIconConstraints: const BoxConstraints(minWidth: 60),
            hintText: widget.hint,
            filled: true, fillColor: Colors.grey.shade200,
            labelStyle: TextStyle(color: Colors.grey.shade700),
            floatingLabelBehavior: FloatingLabelBehavior.never,

            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.3, color: Colors.grey.shade300),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.grey.shade400),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.3, color: Colors.grey.shade300),
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 0.3, color: Colors.grey.shade300),
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14),
            // errorText:     !validCode ? widget.tr('field_required') : null,
          ),
          onChanged: (val) {
            widget.onChanged(val);
          },
        ),
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.red),
                ),
              ),
            ],
          ),
        )
    ]);
  }

  Widget _countrySelector() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: DropdownButton<Country>(
        value: widget.country,
        icon: const Icon(
          Icons.arrow_drop_down,
          size: 32,
        ),
        elevation: 16,
        style: Theme.of(context).textTheme.bodyText2,
        underline: null,
        onChanged: (Country? value) {
          widget.onCountryChange(value!);
        },
        items:
            widget.countries.map<DropdownMenuItem<Country>>((Country? country) {
          return DropdownMenuItem<Country>(
            value: country,
            child: Row(
              children: [
                Image.asset(
                  'assets/img/kuwait.png',
                  width: 24,
                  height: 16,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(country!.code),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
