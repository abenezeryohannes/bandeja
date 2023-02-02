import 'dart:ui';

import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/network/api.dart';

class RecentBookingCard extends StatefulWidget {
  const RecentBookingCard(
      {Key? key,
      this.padelOrder,
      required this.height,
      required this.width,
      this.scrollAmount = 1,
      this.length = 1,
      required this.index,
      required this.onClick,
      required this.onQrClick,
      required this.onLocationClick})
      : super(key: key);
  final PadelOrderModel? padelOrder;
  final Function onClick;
  final Function onQrClick;
  final Function onLocationClick;
  final double height;
  final int length;
  final double width;
  final int index;
  final double scrollAmount;
  @override
  State<RecentBookingCard> createState() => _RecentBookingCardState();
}

class _RecentBookingCardState extends State<RecentBookingCard> {
  late double scale;
  late Offset offset;
  late double clampedDifference;

  @override
  Widget build(BuildContext context) {
    clampedDifference = (widget.scrollAmount - widget.index).clamp(-1, 1);

    // offset = Offset(0.0, 128.0 * clampedDifference);

    scale =
        lerpDouble(1, widget.length > 1 ? 0.8 : 1, clampedDifference.abs())!;

    return Transform.scale(
      scaleY: scale,
      child: InkWell(
        onTap: () {
          widget.onClick();
        },
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Stack(
              children: [
                Container(
                  height: widget.height,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey.shade200,
                      image: widget.padelOrder == null
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(Api.getMedia(
                                  widget.padelOrder!.getPadel().banner)))),
                ),
                CustomShimmer(
                  show: widget.padelOrder == null,
                  child: Container(
                      height: widget.height,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        gradient: RadialGradient(
                          radius: 0.8,
                          colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.padelOrder == null
                                ? '   '
                                : widget.padelOrder!.getUser().fullName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18, color: Colors.white),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              widget.padelOrder == null
                                  ? '   '
                                  : widget.padelOrder!.getPadel().name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 13, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.padelOrder != null)
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.padelOrder == null
                                    ? '   '
                                    : widget.padelOrder!
                                        .getPadel()
                                        .getAddress()
                                        .name,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.padelOrder != null)
                                Image.asset(
                                  'assets/icons/calendar.png',
                                  height: 16,
                                  width: 22,
                                ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.padelOrder == null
                                    ? '   '
                                    : DateFormat('d/MM/yyyy').format(widget
                                        .padelOrder!
                                        .getSchedule()
                                        .startTime),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.padelOrder != null)
                                const Icon(
                                  Icons.watch_later,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.padelOrder == null
                                    ? '-'
                                    : "${DateFormat.jm().format(widget.padelOrder!.getSchedule().startTime)} ( ${widget.padelOrder!.getPadel().getDuration().minute} min)",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.padelOrder != null)
                                const Icon(
                                  Icons.paid,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.padelOrder == null
                                    ? '   '
                                    : "${widget.padelOrder!.amount} KD",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: Colors.white, fontSize: 14),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  widget.onQrClick();
                                },
                                child: CustomShimmer(
                                  show: widget.padelOrder == null,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    child: const Icon(
                                      Icons.qr_code,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  widget.onLocationClick();
                                },
                                child: CustomShimmer(
                                  show: widget.padelOrder == null,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    child: Image.asset(
                                      'assets/icons/location.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
