import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/network/api.dart';
import '../../../../core/presentation/widgets/cached.image.provider.dart';
import '../../../../core/presentation/widgets/custom.shimmer.dart';
import '../../../domain/padels/repositories/i.padel.repository.dart';
import 'padel.avatar.dart';

class PadelCardWithAvatar extends StatefulWidget {
  const PadelCardWithAvatar(
      {Key? key,
      this.item,
      required this.avatarBorderColor,
      required this.avatarRadius,
      this.scrollAmount = 1,
      this.cornerRadius = 25,
      this.showAvatar = true,
      this.showName = true,
      this.showCourtNo = true,
      this.index = 1,
      required this.avatarMargins,
      required this.onClick,
      required this.avatarHeroTag,
      required this.cardHeroTag})
      : super(key: key);

  final PadelModel? item;
  final Color avatarBorderColor;
  final double avatarRadius;
  final double cornerRadius;
  final double scrollAmount;
  final bool showAvatar;
  final bool showName;
  final String avatarHeroTag;
  final String cardHeroTag;
  final bool showCourtNo;
  final Function(String, String) onClick;
  final int index;
  final EdgeInsetsGeometry avatarMargins;

  @override
  State<PadelCardWithAvatar> createState() => _PadelCardWithAvatarState();
}

class _PadelCardWithAvatarState extends State<PadelCardWithAvatar> {
  late double scale;
  late Offset offset;
  late double clampedDifference;

  bool bookmarked = false;
  final padelRepository = getIt<IPadelRepository>();

  @override
  void initState() {
    bookmarked = !(widget.item == null || widget.item!.isBookmarked());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    clampedDifference = (widget.scrollAmount - widget.index).clamp(-1, 1);

    offset = Offset(0.0, 128.0 * clampedDifference);

    scale = lerpDouble(1.0, 0.8, clampedDifference.abs())!;

    return Transform.scale(
        scale: scale,
        child: GestureDetector(
            onTapDown: (_) {
              widget.onClick(widget.avatarHeroTag, widget.cardHeroTag);
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomShimmer(
                  show: widget.item == null,
                  child: CachedImageProvider(
                      borderRadius: widget.cornerRadius,
                      image: Api.getMedia(widget.item == null
                          ? '/img/placeholder.jpg'
                          : widget.item!.banner)),
                ),
                // CustomShimmer(
                //   show: widget.item == null,
                //   child: IconButton(
                //       onPressed: () async {
                //         if (widget.item == null) return;
                //         final result = await padelRepository.setBookmark(
                //             padelId: widget.item!.id);
                //         result!.fold((l) {
                //           Get.snackbar('Error', l.message ?? '',
                //               backgroundColor: Colors.red,
                //               colorText: Colors.white);
                //         }, (r) {
                //           setState(() {
                //             if (r) {
                //               bookmarked = !bookmarked;
                //             }
                //           });
                //         });
                //       },
                //       icon: Icon(
                //         bookmarked ? Icons.bookmark : Icons.bookmark_outline,
                //         size: 32,
                //         color: Colors.white,
                //       )),
                // ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: widget.item == null
                            ? [Colors.grey.shade200, Colors.grey.shade300]
                            : [
                                Colors.transparent,
                                Colors.black.withOpacity(0.8),
                              ],
                      )),
                ),
                Align(
                  alignment: const Alignment(1, -1),
                  child: CustomShimmer(
                    show: widget.item == null,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.80)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          widget.item == null
                              ? ''
                              : widget.item!.Address == null
                                  ? ''
                                  : widget.item!.Address!.name,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Icon(
                          Icons.location_on,
                          size: 16,
                        )
                      ]),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (widget.showAvatar)
                          PadelAvatar(
                            hero: widget.avatarHeroTag,
                            item: widget.item,
                            borderColor: widget.avatarBorderColor,
                            radius: widget.avatarRadius,
                            margins: widget.avatarMargins,
                            onClick: () {
                              widget.onClick(
                                  widget.avatarHeroTag, widget.cardHeroTag);
                            },
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.showCourtNo)
                              Text(
                                widget.item == null ? '' : widget.item!.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              ),
                            const SizedBox(
                              height: 5,
                            ),
                            if (widget.showName)
                              Flexible(
                                child: Text(
                                  widget.item == null
                                      ? ''
                                      : widget.item!.getUser().fullName,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: Theme.of(context).cardColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
