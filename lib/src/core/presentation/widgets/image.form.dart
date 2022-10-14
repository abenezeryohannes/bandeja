import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'cached.image.dart';

class ImageForm extends StatefulWidget {
  const ImageForm({
    Key? key,
    required this.onUpload,
    this.imageLink,
    this.placeholder,
    this.radius,
    this.localImage,
    required this.isLoading,
    this.width,
    this.height,
  }) : super(key: key);
  final Widget? placeholder;
  final double? radius;
  final double? width;
  final double? height;
  final String? imageLink;
  final String? localImage;
  final Function(String) onUpload;
  final Function(bool) isLoading;
  @override
  State<ImageForm> createState() => _ImageFormState();
}

class _ImageFormState extends State<ImageForm> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          _getImage(context);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (widget.localImage != null)
              Container(
                height: widget.height ?? MediaQuery.of(context).size.height,
                width: widget.width ?? MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(widget.radius ?? 0)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(
                        File(widget.localImage!),
                      ),
                    )),
              )
            else if (widget.imageLink != null && widget.imageLink!.isNotEmpty)
              CachedImage(
                  imageLink: widget.imageLink!,
                  radius: widget.radius ?? 0,
                  width: widget.width ?? MediaQuery.of(context).size.width,
                  height: widget.height ?? MediaQuery.of(context).size.height)
            else if (widget.placeholder != null)
              widget.placeholder!
            else
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: CircleAvatar(
                    backgroundColor: (widget.imageLink != null &&
                            widget.imageLink!.isNotEmpty)
                        ? Colors.white.withOpacity(0.5)
                        : Colors.white,
                    child: Icon(
                      (widget.imageLink == null && widget.imageLink!.isEmpty)
                          ? Icons.add
                          : Icons.edit,
                      color: Colors.grey.shade700,
                      size: 30,
                    ),
                  ),
                ),
              ),
          ],
        ));
  }

  Future _getImage(BuildContext context) async {
    File image;
    var imagePicker =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    widget.isLoading(true);
    if (imagePicker != null) {
      image = File(imagePicker.path);
      if (await image.exists()) widget.onUpload(imagePicker.path);
      // String? imagePath = await widget.uploadImage(image, context);
      // if (imagePath != null) {
      //   widget.onUpload(imagePath);
      // }
    }
    widget.isLoading(false);
    // _image = _pickedFile.path.;
  }
}
