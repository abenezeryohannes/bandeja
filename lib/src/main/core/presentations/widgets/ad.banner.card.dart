import 'dart:ui';

import 'package:bandeja/src/core/domain/ads/entities/ad.dart';
import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/network/api.dart';

class AdBannerCard extends StatefulWidget {
  const AdBannerCard({
    Key? key,
    this.ad,
    required this.height,
    this.scrollAmount = 1,
    required this.index,
    required this.onClick,
  }) : super(key: key);
  final AdModel? ad;
  final Function onClick;
  final double height;
  final int index;
  final double scrollAmount;
  @override
  State<AdBannerCard> createState() => _AdBannerCardState();
}

class _AdBannerCardState extends State<AdBannerCard> {
  late double scale;
  late Offset offset;
  late double clampedDifference;

  @override
  Widget build(BuildContext context) {
    clampedDifference = (widget.scrollAmount - widget.index).clamp(-1, 1);

    // offset = Offset(0.0, 128.0 * clampedDifference);

    scale = lerpDouble(1, 0.8, clampedDifference.abs())!;

    return InkWell(
      onTap: () {
        widget.onClick();
      },
      child: SizedBox(
        height: widget.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Stack(
            children: [
              Container(
                height: widget.height,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey.shade200,
                    image: widget.ad == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                NetworkImage(Api.getMedia(widget.ad!.banner)))),
              ),
              CustomShimmer(
                show: widget.ad == null,
                child: Container(
                    height: widget.height,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      gradient: RadialGradient(
                        radius: 0.8,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
