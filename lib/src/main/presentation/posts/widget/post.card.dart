import 'package:feekpadel/src/main/domain/posts/entities/post.dart';
import 'package:feekpadel/src/main/presentation/posts/widget/post.bottom.sheet.dart';
import 'package:feekpadel/src/main/presentation/posts/widget/post.image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCard extends StatefulWidget {
  const PostCard({Key? key, required this.post}) : super(key: key);
  final PostModel post;
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Get.bottomSheet(PostBottomSheet(post: widget.post));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 3,
              ),
              PostImage(
                post: widget.post,
                img: widget.post.coverImage(),
                height: 120,
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                  child: Text(widget.post.desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2)),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Price/ ",
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 11),
                          children: [
                        TextSpan(
                            text: "${widget.post.price} KD",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.secondary))
                      ])),
                  Text(widget.post.offer ? "Offered" : "Wanted",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: widget.post.offer
                              ? Colors.greenAccent
                              : Colors.redAccent))
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
