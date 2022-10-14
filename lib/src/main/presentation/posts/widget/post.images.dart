import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/posts/entities/post.dart';
import 'post.image.dart';

class PostImages extends StatefulWidget {
  const PostImages({Key? key, required this.post, required this.height})
      : super(key: key);
  final PostModel post;
  final double height;
  @override
  State<PostImages> createState() => _PostImagesState();
}

class _PostImagesState extends State<PostImages> {
  late PageController _pageController;
  double _scrollAmount = 0.0;

  @override
  void initState() {
    _pageController = PageController(initialPage: _scrollAmount.toInt());
    _pageController.addListener(() {
      setState(() {
        _scrollAmount = _pageController.page!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: widget.height,
        child: Column(
          children: [
            SizedBox(
              height: widget.height - 30,
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.post.coverImages().length,
                  itemBuilder: ((context, index) {
                    return PostImage(
                        post: widget.post,
                        img: widget.post.coverImages()[index],
                        height: widget.height - 30);
                  })),
            ),
            DotsIndicator(
              dotsCount: widget.post.coverImages().length,
              position: _scrollAmount,
              decorator: DotsDecorator(
                  size: const Size(10, 10),
                  activeSize: const Size(40, 10),
                  activeShape: const StadiumBorder(),
                  color: Colors.grey.shade300,
                  activeColor: Theme.of(context).colorScheme.secondary),
            )
          ],
        ));
  }
}
