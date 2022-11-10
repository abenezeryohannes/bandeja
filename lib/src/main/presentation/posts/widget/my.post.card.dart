import 'package:flutter/material.dart';

import '../../../../core/domain/posts/entities/post.dart';
import 'post.card.dart';

class MyPostCard extends StatefulWidget {
  const MyPostCard({Key? key, this.post, required this.onDelete})
      : super(key: key);
  final PostModel? post;
  final Function(PostModel?) onDelete;
  @override
  State<MyPostCard> createState() => _MyPostCardState();
}

class _MyPostCardState extends State<MyPostCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Align(
              alignment: Alignment.center, child: PostCard(post: widget.post)),
          if (widget.post != null)
            Align(
              alignment: const Alignment(0.95, -0.95),
              child: InkWell(
                onTap: () {
                  widget.onDelete(widget.post);
                },
                child: const Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  color: Colors.red,
                  child: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
