import 'package:feekpadel/src/main/domain/posts/entities/post.dart';
import 'package:feekpadel/src/main/presentation/posts/widget/post.images.dart';
import 'package:flutter/material.dart';

class PostBottomSheet extends StatefulWidget {
  const PostBottomSheet({Key? key, required this.post}) : super(key: key);
  final PostModel post;
  @override
  State<PostBottomSheet> createState() => _PostBottomSheetState();
}

class _PostBottomSheetState extends State<PostBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: Theme.of(context).scaffoldBackgroundColor),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              color: Theme.of(context).dividerColor,
              width: 60,
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: PostImages(
                post: widget.post,
                height: 220,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                        child: Text(
                      widget.post.desc,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 40.0,
                        left: 0,
                        right: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Price/ ',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    "${widget.post.price} KD",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.blueAccent),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                (widget.post.offer) ? "Offered" : "wanted",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: widget.post.offer
                                            ? Colors.greenAccent
                                            : Colors.redAccent),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Card(
                                color: Colors.black,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: InkWell(
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 13),
                                    child: Icon(
                                      Icons.phone_in_talk_outlined,
                                      size: 32,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Card(
                                color: Colors.green,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: InkWell(
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 13),
                                    child: Icon(
                                      Icons.whatsapp_outlined,
                                      size: 32,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
