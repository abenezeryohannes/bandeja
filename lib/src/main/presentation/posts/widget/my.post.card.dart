import 'package:feekpadel/src/main/domain/posts/entities/post.dart';
import 'package:feekpadel/src/main/presentation/posts/widget/post.card.dart';
import 'package:flutter/material.dart';

class MyPostCard extends StatefulWidget {
  const MyPostCard({Key? key, required this.post, required this.onDelete})
      : super(key: key);
  final PostModel post;
  final Function onDelete;
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
          Align(
            alignment: Alignment(1, -1),
            child: InkWell(
              onTap: () {
                widget.onDelete();
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
