import 'package:flutter/material.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/network/api.dart';
import '../../../../core/presentation/widgets/cached.image.provider.dart';
import '../../../../core/presentation/widgets/custom.shimmer.dart';

class PadelAvatar extends StatefulWidget {
  const PadelAvatar(
      {Key? key,
      this.item,
      required this.borderColor,
      required this.radius,
      required this.margins,
      required this.hero,
      required this.onClick})
      : super(key: key);

  final PadelModel? item;
  final Color borderColor;
  final String hero;
  final double radius;
  final Function onClick;
  final EdgeInsetsGeometry margins;

  @override
  State<PadelAvatar> createState() => _PadelAvatarState();
}

class _PadelAvatarState extends State<PadelAvatar> {
  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      show: widget.item == null,
      child: Container(
        width: (widget.radius * 2) + 10,
        height: (widget.radius * 2) + 10,
        margin: widget.margins,
        // child:
        // Hero(
        //   tag: widget.hero,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: widget.radius,
                  child: CachedImageProvider(
                    borderRadius: 100,
                    height: widget.radius * 2,
                    image: Api.getMedia(widget.item == null
                        ? '/img/placeholder.jpg'
                        : widget.item!.avatar),
                    onError: Container(color: Colors.grey.shade200),
                    width: widget.radius * 2,
                  ),
                  // backgroundImage: AssetImage(widget.item.image),
                ),
              ),
              InkWell(
                onTap: () {
                  widget.onClick();
                },
                child: Container(
                  width: (widget.radius * 2) + 10,
                  height: (widget.radius * 2) + 10,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: widget.borderColor, width: 3)),
                ),
              ),
              // if (widget.item.verified)
              //   Align(
              //     alignment: Alignment.bottomRight,
              //     child: Image.asset(
              //       "assets/img/verify.png",
              //       width: widget.radius,
              //       height: widget.radius,
              //     ),
              //   )
            ],
          ),
        ),
        // ),
      ),
    );
  }
}
