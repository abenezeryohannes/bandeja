import 'package:flutter/material.dart';

import '../../../../core/data/posts/dto/post.image.dto.dart';
import '../../../../core/presentation/widgets/image.form.dart';

class PostImagesFrom extends StatefulWidget {
  const PostImagesFrom(
      {Key? key,
      required this.postImages,
      required this.uploadImage,
      required this.onLoadingChanged,
      this.validator,
      required this.placeholder})
      : super(key: key);
  final List<PostImageDto> postImages;
  final String? Function()? validator;
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
    String? error = widget.validator == null ? null : widget.validator!();
    List<Widget> res = widget.postImages
        .map((pI) => Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ImageForm(
                imageLink: pI.img,
                localImage: pI.localImg,
                width: 100,
                height: 100,
                elevation: 2,
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
    res.add(Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: ImageForm(
        backgroundColor: Colors.grey.shade100,
        radius: 12,
        elevation: 2,
        width: 100,
        height: 100,
        validator: widget.validator,
        placeholder: Image.asset(
          widget.placeholder,
          height: error == null ? 100 : 70,
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
