import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatefulWidget {
  const CachedImage(
      {Key? key,
      required this.imageLink,
      this.height,
      this.width,
      this.radius = 0,
      this.gradient})
      : super(key: key);
  final String imageLink;
  final double radius;
  final double? height;
  final double? width;
  final Gradient? gradient;

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: widget.height ?? MediaQuery.of(context).size.height,
      width: widget.width ?? MediaQuery.of(context).size.width,
      imageUrl: widget.imageLink,
      placeholder: (context, url) => Center(
        child: CustomShimmer(
          show: true,
          child: Container(
            height: widget.height,
            width: widget.width,
            color: Colors.grey.shade300,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      imageBuilder: (context, imageProvider) => Container(
        height: widget.height,
        width: widget.width,
        foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
            gradient: (widget.gradient != null)
                ? widget.gradient
                : const LinearGradient(colors: [])),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
