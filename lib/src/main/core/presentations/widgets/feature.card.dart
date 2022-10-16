import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/padels/entities/feature.dart';
import '../../../../core/network/api.dart';
import '../../../../core/presentation/widgets/cached.image.provider.dart';

class FeatureCard extends StatefulWidget {
  const FeatureCard({Key? key, this.feature, this.big = false})
      : super(key: key);
  final FeatureModel? feature;
  final bool big;
  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.big ? 44 : 30,
          height: widget.big ? 40 : 28,
          child: Stack(
            alignment: const Alignment(1, 1),
            children: [
              CustomShimmer(
                show: widget.feature == null,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: CachedImageProvider(
                      borderRadius: 0,
                      height: widget.big ? 34 : 24,
                      image: Api.getMedia(widget.feature == null
                          ? "img/placeholder.jpg"
                          : widget.feature!.icon),
                      onError: Container(color: Colors.grey.shade200),
                      width: widget.big ? 24 : 24),
                ),
              ),
              if (widget.feature == null
                  ? false
                  : widget.feature!.getPadelFeature().free)
                Align(
                  alignment: const Alignment(1, 2),
                  child: Container(
                      padding: EdgeInsets.all(widget.big ? 6 : 5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Text(
                        "\$",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: widget.big ? 14 : 10),
                      )),
                )
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Text(widget.feature == null ? '' : widget.feature!.name,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(fontSize: widget.big ? 14 : 10)))
      ],
    );
  }
}
