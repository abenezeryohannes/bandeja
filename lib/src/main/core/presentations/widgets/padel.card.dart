import 'package:bandeja/src/core/network/api.dart';
import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/presentation/widgets/cached.image.dart';
import '../../../../core/utils/util.dart';
import '../../../domain/padels/repositories/i.padel.repository.dart';
import '../../../presentation/home/widget/padel.avatar.dart';
import 'feature.card.dart';

class PadelCard extends StatefulWidget {
  const PadelCard({Key? key, this.item}) : super(key: key);
  final PadelModel? item;
  @override
  State<PadelCard> createState() => _PadelCardState();
}

class _PadelCardState extends State<PadelCard> {
  bool bookmarked = false;
  final padelRepository = getIt<IPadelRepository>();

  @override
  void initState() {
    bookmarked = !(widget.item == null || widget.item!.isBookmarked());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                CustomShimmer(
                  show: widget.item == null,
                  child: CachedImage(
                    radius: 20,
                    gradient: const LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        begin: Alignment.center,
                        end: Alignment.bottomCenter),
                    imageLink: Api.getMedia(widget.item == null
                        ? 'img/placeholder.jpg'
                        : widget.item!.banner),
                    width: double.infinity,
                  ),
                ),
                CustomShimmer(
                  show: widget.item == null,
                  child: IconButton(
                      onPressed: () async {
                        if (widget.item == null) return;
                        final result = await padelRepository.setBookmark(
                            padelId: widget.item!.id);
                        result!.fold((l) {
                          Get.snackbar('Error', l.message ?? '',
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        }, (r) {
                          setState(() {
                            if (r) {
                              bookmarked = !bookmarked;
                            }
                          });
                        });
                      },
                      icon: Icon(
                        bookmarked ? Icons.bookmark : Icons.bookmark_outline,
                        size: 32,
                        color: Colors.white,
                      )),
                ),
                Align(
                  alignment: const Alignment(0.9, -0.9),
                  child: CustomShimmer(
                    show: widget.item == null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.85)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          widget.item == null
                              ? " "
                              : widget.item!.getAddress().name,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.location_on,
                          size: 20,
                        )
                      ]),
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(-1, 1.9),
                  child: PadelAvatar(
                    borderColor: Colors.white,
                    hero: '',
                    item: widget.item,
                    margins: const EdgeInsets.only(left: 20),
                    onClick: () {},
                    radius: 40,
                  ),
                ),
                Align(
                  alignment: const Alignment(0.9, 0.9),
                  child: CustomShimmer(
                    show: widget.item == null,
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: widget.item == null
                                ? ''
                                : "${widget.item == null ? '-' : widget.item!.price} KD",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary),
                            children: [
                              TextSpan(
                                  text: Util.getDurationIn(widget.item == null
                                      ? 0
                                      : widget.item!.getDuration().minute),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.grey.shade400))
                            ])),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 10),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                  children: (widget.item == null
                          ? [null, null, null]
                          : widget.item!.getFeatures())
                      .map((f) => Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: FeatureCard(feature: f),
                          ))
                      .toList()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 10),
            child: Text(
              widget.item == null ? '' : widget.item!.getUser().fullName,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 5, left: 10),
              child: Text(
                widget.item == null ? '' : widget.item!.name,
                style: Theme.of(context).textTheme.bodyText2,
              )),
        ],
      ),
    );
  }
}
