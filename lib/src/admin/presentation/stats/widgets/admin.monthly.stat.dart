import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/booking/dto/admin.monthly.stat.dto.dart';

class AdminMonthlyStat extends StatefulWidget {
  const AdminMonthlyStat(
      {Key? key,
      required this.adminMonthlyStatDto,
      required this.date,
      required this.onDateClicked})
      : super(key: key);
  final AdminMonthlyStatDto? adminMonthlyStatDto;
  final DateTime? date;
  final Function onDateClicked;
  @override
  State<AdminMonthlyStat> createState() => _AdminMonthlyStatState();
}

class _AdminMonthlyStatState extends State<AdminMonthlyStat> {
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
                        title: 'All Hours',
                        value: widget.adminMonthlyStatDto?.allHours == null
                            ? '0 Hrs'
                            : '${widget.adminMonthlyStatDto!.allHours?.toInt() ?? 0} Hrs'),
                    _items(
                        asset: 'assets/icons/clock.png',
                        title: 'Booked Hours',
                        value: widget.adminMonthlyStatDto?.totalHours == null
                            ? '0 Hrs'
                            : '${widget.adminMonthlyStatDto!.totalHours?.toInt() ?? 0} Hrs'),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _items(
                        asset: 'assets/icons/view_circle.png',
                        title: 'App Visits',
                        value: widget.adminMonthlyStatDto?.appVisitsCount ==
                                null
                            ? '0'
                            : '${widget.adminMonthlyStatDto!.appVisitsCount?.toInt() ?? 0}'),
                    _items(
                        asset: 'assets/icons/dollar-symbol.png',
                        title: 'Income',
                        value: widget.adminMonthlyStatDto?.totalincome == null
                            ? '0 KD'
                            : '${widget.adminMonthlyStatDto!.totalincome} KD'),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _items(
                        asset: 'assets/icons/tennis_circle.png',
                        title: 'Our Courts',
                        value: widget.adminMonthlyStatDto?.padelsCount == null
                            ? '0'
                            : '${widget.adminMonthlyStatDto!.padelsCount?.toInt() ?? 0}'),
                    _items(
                        asset: 'assets/icons/group_circle.png',
                        title: 'New Users',
                        value: widget.adminMonthlyStatDto?.newUserCount == null
                            ? '0'
                            : '${widget.adminMonthlyStatDto!.newUserCount?.toInt() ?? 0}'),
                  ],
                ),
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
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: Row(
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
      ),
    );
  }
}
