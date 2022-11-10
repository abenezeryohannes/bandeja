import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/domain/padels/entities/padel.dart';

class CheckoutItems extends StatefulWidget {
  const CheckoutItems({Key? key, this.padel, this.time}) : super(key: key);
  final PadelModel? padel;
  final DateTime? time;
  @override
  State<CheckoutItems> createState() => _CheckoutItemsState();
}

class _CheckoutItemsState extends State<CheckoutItems> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _item("Date",
            DateFormat("DD/MM/YY").format(widget.time ?? DateTime.now())),
        _item("Time", DateFormat.jm().format(widget.time ?? DateTime.now())),
        _item(
            "Location",
            widget.padel == null
                ? '....................'
                : widget.padel!.getAddress().name),
      ],
    );
  }

  Widget _item(String title, String value) {
    return CustomShimmer(
      show: widget.padel == null,
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                backgroundColor: widget.padel != null ? null : Colors.black),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                backgroundColor: widget.padel != null ? null : Colors.black),
          )
        ],
      ),
    );
  }
}
