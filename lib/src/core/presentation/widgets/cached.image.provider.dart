import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedImageProvider extends StatefulWidget {
  const CachedImageProvider(
      {Key? key,
      required this.image,
      required this.borderRadius,
      this.height,
      this.width,
      this.onError})
      : super(key: key);
  final String image;
  final double borderRadius;
  final double? height;
  final double? width;
  final Widget? onError;
  @override
  State<CachedImageProvider> createState() => CachedImageProviderState();
}

class CachedImageProviderState extends State<CachedImageProvider> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.image,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => SizedBox(
          width: widget.width,
          height: widget.height,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                )),
          )),
      errorWidget: (context, url, error) => Container(
          width: MediaQuery.of(context).size.width,
          height: widget.height,
          alignment: Alignment.center,
          child: widget.onError ??
              Icon(Icons.error_outline, color: Colors.grey.shade300)),
    );
  }
}
