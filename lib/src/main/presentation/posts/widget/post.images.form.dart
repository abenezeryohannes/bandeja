import 'package:flutter/material.dart';

import '../../../../core/data/posts/dto/post.image.dto.dart';
import '../../../../core/presentation/widgets/image.form.dart';

class PostImagesFrom extends StatefulWidget {
  const PostImagesFrom(
      {Key? key,
      required this.postImages,
      required this.uploadImage,
      required this.onLoadingChanged,
      required this.placeholder})
      : super(key: key);
  final List<PostImageDto> postImages;
  final Function(String imgPath) uploadImage;
  final Function(bool isLoading) onLoadingChanged;
  final String placeholder;
  @override
  State<PostImagesFrom> createState() => _PostImagesFromState();
}

class _PostImagesFromState extends State<PostImagesFrom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: getForms()),
    );
  }

  List<Widget> getForms() {
    List<Widget> res = widget.postImages
        .map((pI) => Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey.shade100,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: ImageForm(
                imageLink: pI.img,
                localImage: pI.localImg,
                width: 100,
                height: 100,
                radius: 12,
                placeholder: Image.asset(
                  widget.placeholder,
                  height: 100,
                ),
                onUpload: (imagePath) {
                  widget.uploadImage(imagePath);
                },
                isLoading: (loading) {
                  widget.onLoadingChanged(loading);
                },
              ),
            ))
        .toList();
    res.add(Card(
      color: Colors.grey.shade100,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: ImageForm(
        radius: 12,
        width: 100,
        height: 100,
        placeholder: Image.asset(
          widget.placeholder,
          height: 100,
        ),
        onUpload: (imagePath) {
          widget.uploadImage(imagePath);
        },
        isLoading: (loading) {
          widget.onLoadingChanged(loading);
        },
      ),
    ));
    return res;
  }
}
