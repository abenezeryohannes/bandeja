import 'package:feekpadel/src/core/network/api.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/cached.image.provider.dart';
import '../../../domain/posts/entities/post.dart';

class PostAvatar extends StatefulWidget {
  const PostAvatar(
      {Key? key,
      required this.item,
      required this.borderColor,
      required this.radius,
      required this.margins,
      required this.hero,
      required this.onClick})
      : super(key: key);

  final PostModel item;
  final Color borderColor;
  final String hero;
  final double radius;
  final Function onClick;
  final EdgeInsetsGeometry margins;

  @override
  State<PostAvatar> createState() => _PostAvatarState();
}

class _PostAvatarState extends State<PostAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  image: Api.getMedia(widget.item.coverImage()),
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
    );
  }
}
