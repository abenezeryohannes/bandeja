import 'dart:io';

import 'package:bandeja/src/core/network/api.dart';
import 'package:bandeja/src/core/utils/util.dart';
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
    this.elevation,
    this.validator,
    this.height,
    this.backgroundColor,
    this.border,
  }) : super(key: key);
  final Widget? placeholder;
  final String? Function()? validator;
  final double? radius;
  final double? width;
  final Color? backgroundColor;
  final double? elevation;
  final double? height;
  final String? imageLink;
  final BoxBorder? border;
  final String? localImage;
  final Function(String) onUpload;
  final Function(bool) isLoading;
  @override
  State<ImageForm> createState() => _ImageFormState();
}

class _ImageFormState extends State<ImageForm> {
  @override
  Widget build(BuildContext context) {
    String? error = widget.validator == null ? null : widget.validator!();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
            onTap: () {
              _getImage(context);
            },
            child: Material(
              elevation: widget.elevation ?? 0,
              color: widget.backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.radius ?? 0))),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(widget.radius ?? 0)),
                    border: error != null
                        ? Border.all(color: Colors.red, width: 1)
                        : widget.border),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (widget.localImage != null)
                      Container(
                        height: (widget.height ??
                                MediaQuery.of(context).size.height) -
                            (error != null ? 30 : 0),
                        width:
                            widget.width ?? MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(widget.radius ?? 0)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(widget.localImage!),
                              ),
                            )),
                      )
                    else if (widget.imageLink != null &&
                        widget.imageLink!.isNotEmpty &&
                        Util.isUrl(widget.imageLink!))
                      CachedImage(
                          imageLink: widget.imageLink!,
                          radius: widget.radius ?? 0,
                          width:
                              widget.width ?? MediaQuery.of(context).size.width,
                          height: (widget.height ??
                                  MediaQuery.of(context).size.height) -
                              (error != null ? 30 : 0))
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
                              (widget.imageLink != null &&
                                      widget.imageLink!.isEmpty)
                                  ? Icons.add
                                  : Icons.edit,
                              color: Colors.grey.shade700,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )),
        if (error != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            child: Text(
              error,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.red),
            ),
          )
      ],
    );
  }

  Future _getImage(BuildContext context) async {
    File image;
    var imagePicker =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    widget.isLoading(true);
    if (imagePicker != null) {
      image = File(imagePicker.path);
      widget.isLoading(false);

      if (await image.exists()) widget.onUpload(imagePicker.path);
      // String? imagePath = await widget.uploadImage(image, context);
      // if (imagePath != null) {
      //   widget.onUpload(imagePath);
      // }
    } else {
      widget.isLoading(false);
    }
    // _image = _pickedFile.path.;
  }
}
