import 'package:bandeja/src/core/network/api.dart';
import 'package:bandeja/src/core/presentation/widgets/image.form.dart';
import 'package:flutter/material.dart';

class AddPadelImages extends StatefulWidget {
  const AddPadelImages(
      {Key? key,
      this.localAvatarImage,
      this.localBannerImage,
      this.bannerImageLink,
      this.avatarImageLink,
      required this.avatarLoading,
      required this.uploadAvatar,
      required this.bannerLoading,
      required this.uploadBanner})
      : super(key: key);
  final String? localAvatarImage;
  final String? localBannerImage;
  final String? bannerImageLink;
  final String? avatarImageLink;
  final Function(bool loading) avatarLoading;
  final Function(bool loading) bannerLoading;
  final Function(String path) uploadAvatar;
  final Function(String path) uploadBanner;
  @override
  State<AddPadelImages> createState() => _AddPadelImagesState();
}

class _AddPadelImagesState extends State<AddPadelImages> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: SizedBox(
            child: ImageForm(
              height: 160,
              localImage: widget.localBannerImage,
              width: MediaQuery.of(context).size.width,
              border: Border.all(width: 2, color: Colors.white),
              radius: 20,
              imageLink: widget.bannerImageLink != null
                  ? Api.getMedia(widget.bannerImageLink!)
                  : null,
              backgroundColor: Colors.grey.shade200,
              onUpload: (x) {
                widget.uploadBanner(x);
              },
              isLoading: (loading) {
                widget.bannerLoading(loading);
              },
              placeholder: Container(
                height: 160,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/icons/image-plus.png',
                        width: 42,
                        height: 42,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Courts Banner',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Theme.of(context).dividerColor),
                      )
                    ]),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: SizedBox(
            child: ImageForm(
              height: 80,
              width: 80,
              radius: 200,
              border: Border.all(width: 2, color: Colors.white),
              backgroundColor: Colors.transparent,
              imageLink: widget.avatarImageLink != null
                  ? Api.getMedia(widget.avatarImageLink!)
                  : null,
              onUpload: (x) {
                widget.uploadAvatar(x);
              },
              isLoading: (loading) {
                widget.avatarLoading(loading);
              },
              localImage: widget.localAvatarImage,
              placeholder: Container(
                height: 80,
                width: 80,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/icons/image-plus.png',
                        width: 24,
                        height: 24,
                      ),
                      Text(
                        'Logo',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Theme.of(context).dividerColor),
                      )
                    ]),
              ),
            ),
          ),
        )
      ],
    );
  }
}
