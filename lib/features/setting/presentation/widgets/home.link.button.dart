import 'package:flutter/material.dart';
import 'package:app/features/setting/presentation/bloc/bloc/setting.bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/widgets/big.text.button.dart';

class HomeLinkButton extends StatefulWidget {
  const HomeLinkButton(
      {Key? key,
      required this.onClick,
      required this.onRetry,
      required this.state})
      : super(key: key);
  final Function onClick;
  final Function onRetry;
  final SettingState state;

  @override
  State<HomeLinkButton> createState() => _HomeLinkButtonState();
}

class _HomeLinkButtonState extends State<HomeLinkButton> {
  @override
  Widget build(BuildContext context) {
    switch (widget.state.runtimeType) {
      case SettingStateLoading:
        return _shimmer();
      case SettingStateLoaded:
        return _button();
      default:
        return _buttonEmpty();
    }
  }

  Widget _buttonEmpty() {
    return BigTextButton(
        horizontalMargin: 24,
        fontWight: FontWeight.w600,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        text: "تأكد من قيدك الإنتخابي",
        onClick: () {
          widget.onRetry();
        });
  }

  Widget _button() {
    return BigTextButton(
        horizontalMargin: 24,
        fontWight: FontWeight.w600,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        text: "تأكد من قيدك الإنتخابي",
        onClick: () {
          widget.onClick();
        });
  }

  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: BigTextButton(
          horizontalMargin: 24,
          onClick: () {},
          fontWight: FontWeight.w500,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          text: "تأكد من قيدك الإنتخابي"),
    );
  }
}
