import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/domain/posts/entities/post.dart';
import 'post.bottom.sheet.dart';
import 'post.image.dart';

class PostCard extends StatefulWidget {
  const PostCard({Key? key, this.post}) : super(key: key);
  final PostModel? post;
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          if (widget.post == null) return;
          Get.bottomSheet(PostBottomSheet(post: widget.post!));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 3,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: PostImage(
                  post: widget.post,
                  img: widget.post == null
                      ? "img/placeholder.jpg"
                      : widget.post!.coverImage(),
                  height: MediaQuery.of(context).size.width * (4 / 12) - 10,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomShimmer(
                show: widget.post == null,
                child: Text(
                    widget.post == null
                        ? ".................................................................................................."
                        : widget.post!.desc,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        backgroundColor: widget.post == null
                            ? Colors.grey.shade300
                            : Colors.transparent)),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomShimmer(
                    show: widget.post == null,
                    child: RichText(
                        text: TextSpan(
                            text: "Price/ ",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontSize: 11,
                                    backgroundColor: widget.post == null
                                        ? Colors.grey.shade300
                                        : Colors.transparent),
                            children: [
                          TextSpan(
                              text:
                                  "${widget.post == null ? "-" : widget.post!.price} KD",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.secondary))
                        ])),
                  ),
                  CustomShimmer(
                    show: widget.post == null,
                    child: Text(
                        widget.post == null
                            ? "Unknown"
                            : widget.post!.offer
                                ? "Offered"
                                : "Wanted",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            backgroundColor: widget.post == null
                                ? Colors.grey.shade300
                                : Colors.transparent,
                            color: widget.post != null && widget.post!.offer
                                ? const Color(0xFF109825)
                                : Colors.redAccent)),
                  )
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
