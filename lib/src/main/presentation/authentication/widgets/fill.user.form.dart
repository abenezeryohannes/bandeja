import 'package:bandeja/src/core/dto/wrapper.dto.dart';
import 'package:flutter/material.dart';

import '../../../../core/data/authentication/dto/user.dto.dart';
import '../../../../core/presentation/widgets/text.input.form.dart';
import '../../profile/widgets/user.avatar.dart';

class FillUserForm extends StatefulWidget {
  const FillUserForm({
    Key? key,
    required this.userW,
    required this.isLoading,
    required this.userDto,
    required this.onFocus,
    required this.onUpload,
    required this.onNameChange,
  }) : super(key: key);
  final WrapperDto userW;
  final UserDto userDto;
  final Function(bool) isLoading;
  final Function(bool) onFocus;
  final Function(String) onUpload;
  final Function(String) onNameChange;
  @override
  State<FillUserForm> createState() => _FillUserFormState();
}

class _FillUserFormState extends State<FillUserForm> {
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    _focusNode.addListener(() {
      widget.onFocus(_focusNode.hasFocus);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        Center(
          child: UserAvatar(
              userDto: widget.userW,
              size: 100,
              onUpload: (x) => widget.onUpload(x),
              isLoading: (loading) => widget.isLoading(loading),
              localImage: widget.userDto.localImage),
        ),
        const SizedBox(
          height: 16,
        ),
        Center(
            child: Text(
          'Profile Picture',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.grey.shade700),
        )),
        const SizedBox(
          height: 70,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: TextInputForm(
              label: 'Full Name',
              focusNode: FocusNode(),
              placeholder: widget.userDto.fullName,
              error: null,
              suffixText: 'KD',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              initialValue: widget.userDto.fullName,
              onChanged: (change) {
                widget.onNameChange(change);
              }),
        )
      ],
    );
  }
}
