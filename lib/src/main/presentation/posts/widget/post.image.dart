import 'package:feekpadel/src/main/domain/posts/entities/post.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/api.dart';
import '../../../../core/utils/util.dart';

class PostImage extends StatefulWidget {
  const PostImage(
      {Key? key, required this.post, required this.img, required this.height})
      : super(key: key);
  final PostModel post;
  final double height;
  final String img;
  @override
  State<PostImage> createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: const Alignment(-1, -1),
        child: Container(
          width: MediaQuery.of(context).size.width, //200,
          height: widget.height,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(Api.getMedia(widget.img))),
          ),
        ),
      ),
      Align(
        alignment: const Alignment(-1, -1),
        child: Card(
          margin: const EdgeInsets.all(10),
          shape: const StadiumBorder(),
          color: widget.post.getGroup().color == null ||
                  widget.post.getGroup().color!.isEmpty
              ? Theme.of(context).colorScheme.secondary
              : Util.fromHex(widget.post.getGroup().color!),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Text(
              widget.post.getGroup().name,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    ]);
  }
}