import 'package:bandeja/main/injection/injector.dart';
import 'package:bandeja/src/core/data/authentication/repositories/auth.repository.dart';
import 'package:bandeja/src/core/data/authentication/repositories/user.repository.dart';
import 'package:bandeja/src/core/presentation/widgets/big.text.button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../admin/presentation/authentication/pages/admin.landing.page.dart';
import '../../../flavors.dart';
import '../../../main/presentation/authentication/page/user.landing.page.dart';
import '../../../owner/presentation/authentication/pages/owner.landing.page.dart';
import '../../domain/authentication/repositories/i.user.repository.dart';
import '../../error/failure.dart';

enum ErrorShowType { horizontal, vertical, textOnly }

class ShowError extends StatefulWidget {
  const ShowError(
      {Key? key,
      required this.failure,
      this.errorShowType = ErrorShowType.textOnly,
      this.onRetry})
      : super(key: key);
  final Failure failure;
  final Function? onRetry;
  final ErrorShowType errorShowType;

  @override
  State<ShowError> createState() => _ShowErrorState();
}

class _ShowErrorState extends State<ShowError> {
  bool loading = false;
  @override
  void initState() {
    loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.errorShowType) {
      case ErrorShowType.textOnly:
        return Center(
            child: Column(
          children: [
            _text(),
            if ((widget.failure.runtimeType ==
                UnAuthorizedFailure().runtimeType))
              loginOption()
          ],
        ));
      case ErrorShowType.horizontal:
        return Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _img(),
            const SizedBox(height: 40),
            Flexible(child: _text())
          ],
        ));
      default:
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _img(),
            const SizedBox(height: 40),
            Flexible(child: _text()),
            if ((widget.failure.runtimeType ==
                UnAuthorizedFailure().runtimeType))
              loginOption()
          ],
        ));
    }
  }

  Widget loginOption() {
    return BigTextButton(
      onClick: () async {
        setState(() {
          loading = true;
        });
        await AuthRepository().signOut();
        await getIt<IUserRepository>().logoutUser();
        setState(() {
          loading = true;
        });
        switch (FF.appFlavor) {
          case Flavor.admin:
            Get.offAll(const AdminLandingPage());
            break;
          case Flavor.owner:
            Get.offAll(const OwnerLandingPage());
            break;
          default:
            Get.offAll(const UserLandingPage());
            break;
        }
      },
      text: 'Sign up again',
      borderColor: Theme.of(context).colorScheme.secondary,
      borderWidth: 2,
      backgroudColor: Theme.of(context).scaffoldBackgroundColor,
      textColor: Theme.of(context).colorScheme.secondary,
      isExpanded: false,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      horizontalMargin:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    );
  }

  Widget _img() {
    if ((widget.failure.runtimeType == UnAuthorizedFailure().runtimeType)) {
      return Image.asset(
        "assets/icons/no_connection.png",
        height: (widget.errorShowType == ErrorShowType.horizontal) ? 50 : 100,
      );
    } else if (widget.failure.runtimeType == CacheFailure().runtimeType ||
        widget.failure.runtimeType == NetworkFailure().runtimeType) {
      return Image.asset(
        "assets/icons/no_connection.png",
        height: (widget.errorShowType == ErrorShowType.horizontal) ? 50 : 100,
      );
    } else if (widget.failure.runtimeType == NoDataFailure().runtimeType) {
      return Image.asset(
        "assets/icons/empty.png",
        height: (widget.errorShowType == ErrorShowType.horizontal) ? 50 : 100,
      );
    } else {
      return Image.asset(
        "assets/icons/error.png",
        height: (widget.errorShowType == ErrorShowType.horizontal) ? 50 : 100,
      );
    }
  }

  Widget _text() {
    if (widget.failure.runtimeType == NoDataFailure().runtimeType) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.failure.message ?? "Soryy, No data here yet!!",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.failure.message ?? "Something Went Wrong!!",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ],
      );
    }
  }
}
