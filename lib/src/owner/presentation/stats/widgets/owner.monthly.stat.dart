import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:bandeja/src/owner/data/dto/owner.monthly.stat.dto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OwnerMonthlyStat extends StatefulWidget {
  const OwnerMonthlyStat(
      {Key? key,
      required this.ownerMonthlyStatDto,
      required this.date,
      required this.onDateClicked})
      : super(key: key);
  final OwnerMonthlyStatDto? ownerMonthlyStatDto;
  final DateTime? date;
  final Function onDateClicked;
  @override
  State<OwnerMonthlyStat> createState() => _OwnerMonthlyStatState();
}

class _OwnerMonthlyStatState extends State<OwnerMonthlyStat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.grey.shade100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomShimmer(
                show: widget.date == null,
                child: Text(
                  'Monthly Static',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.grey.shade600, fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.onDateClicked();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomShimmer(
                      show: widget.date == null,
                      child: Image.asset(
                        'assets/icons/calendar_nav_active.png',
                        color: Colors.grey.shade500,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomShimmer(
                      show: widget.date == null,
                      child: Text(
                        DateFormat("MMM yyyy")
                            .format(widget.date ?? DateTime.now()),
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Colors.grey.shade500,
                            backgroundColor:
                                widget.date == null ? Colors.grey : null),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _items(
                        asset: 'assets/icons/clock.png',
                        title: 'Hours Booking',
                        value: widget.ownerMonthlyStatDto?.totalHours == null
                            ? null
                            : '${widget.ownerMonthlyStatDto!.totalHours} Hrs'),
                    _items(
                        asset: 'assets/icons/dollar-symbol.png',
                        title: 'Income',
                        value: widget.ownerMonthlyStatDto?.totalincome == null
                            ? null
                            : '${widget.ownerMonthlyStatDto!.totalincome} KD'),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                _items(
                    asset: 'assets/icons/view.png',
                    title: 'Court visits',
                    value: widget.ownerMonthlyStatDto?.totalVisit == null
                        ? null
                        : '${widget.ownerMonthlyStatDto!.totalVisit} Visits'),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _items({required String asset, required String title, String? value}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomShimmer(
          show: value == null,
          child: Container(
            height: 24,
            width: 24,
            margin: const EdgeInsets.only(right: 10, top: 5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(asset))),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomShimmer(
              show: value == null,
              child: Text(
                title,
                style: Theme.of(context).textTheme.caption!.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade500),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            CustomShimmer(
              show: value == null,
              child: Text(
                value ?? '____',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    backgroundColor: value == null ? Colors.grey : null),
              ),
            ),
          ],
        )
      ],
    );
  }
}
