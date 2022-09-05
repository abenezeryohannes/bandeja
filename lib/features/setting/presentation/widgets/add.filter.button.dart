import 'package:flutter/material.dart';
import 'package:app/features/setting/presentation/bloc/bloc/setting.bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/widgets/big.text.button.dart';
import '../../../../core/widgets/show.error.dart';
import '../../../candidate/presentation/bloc/featured_candidates/featured.candidates.bloc.dart';

class AddFilterButton extends StatefulWidget {
  const AddFilterButton(
      {Key? key,
      required this.onClick,
      required this.onRetry,
      required this.state})
      : super(key: key);
  final Function onClick;
  final Function onRetry;
  final SettingState state;

  @override
  State<AddFilterButton> createState() => _AddFilterButtonState();
}

class _AddFilterButtonState extends State<AddFilterButton> {
  @override
  Widget build(BuildContext context) {
    switch (widget.state.runtimeType) {
      case SettingStateLoading:
        return _shimmer();
      case SettingStateLoaded:
        return _button();
      case SettingStateError:
        return ShowError(
            failure: (widget.state as FeaturedCandidatesStateError).failure,
            ErrorShowType: ErrorShowType.Vertical);
      default:
        return _buttonDisabled();
    }
  }

  Widget _buttonDisabled() {
    return Column(
      children: [
        BigTextButton(
            onClick: () {
              widget.onRetry();
            },
            text: "تواصل معنا",
            fontWight: FontWeight.w500,
            cornerRadius: 10,
            isExpanded: false,
            elevation: 0,
            backgroudColor: Colors.grey.shade300,
            fontSize: 18,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _button() {
    return Column(
      children: [
        BigTextButton(
            onClick: () {
              widget.onClick();
            },
            text: "تواصل معنا",
            fontWight: FontWeight.w500,
            cornerRadius: 10,
            isExpanded: false,
            elevation: 0,
            fontSize: 18,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _shimmer() {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: BigTextButton(
              onClick: () {},
              text: "تواصل معنا",
              fontWight: FontWeight.w500,
              cornerRadius: 10,
              isExpanded: false,
              elevation: 0,
              fontSize: 18,
              padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
