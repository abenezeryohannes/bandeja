import 'package:flutter/material.dart';
import '../error/failure.dart';

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
  @override
  Widget build(BuildContext context) {
    switch (widget.errorShowType) {
      case ErrorShowType.textOnly:
        return Center(child: _text());
      case ErrorShowType.horizontal:
        return Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
          children: [
            _img(),
            const SizedBox(height: 40),
            Flexible(child: _text())
          ],
        ));
    }
  }

  Widget _img() {
    if (widget.failure.runtimeType == CacheFailure ||
        widget.failure.runtimeType == NetworkFailure) {
      return Image.asset(
        "assets/icons/no_connection.png",
        height: (widget.errorShowType == ErrorShowType.horizontal) ? 50 : 100,
      );
    }
    if (widget.failure.runtimeType == NoDataFailure) {
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
    if (widget.failure.runtimeType == NoDataFailure) {
      return Column(
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
