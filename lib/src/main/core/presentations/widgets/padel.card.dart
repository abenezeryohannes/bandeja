import 'package:bandeja/src/core/network/api.dart';
import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/app.snack.bar.dart';
import '../../../../core/presentation/widgets/cached.image.dart';
import '../../../../core/utils/util.dart';
import '../../../domain/padels/repositories/i.padel.repository.dart';
import '../../../presentation/home/widget/padel.avatar.dart';
import 'feature.card.dart';

class PadelCard extends StatefulWidget {
  const PadelCard({Key? key, this.item, this.onBookmarkChanged})
      : super(key: key);
  final PadelModel? item;
  final Function? onBookmarkChanged;
  @override
  State<PadelCard> createState() => _PadelCardState();
}

class _PadelCardState extends State<PadelCard> {
  bool bookmarked = false;
  final padelRepository = getIt<IPadelRepository>();

  @override
  void initState() {
    bookmarked = !(widget.item == null || widget.item!.isBookmarked());
    // loadIsBookmark(widget.item?.id);
    super.initState();
  }

  void loadIsBookmark(int? padelId) async {
    if (padelId == null) return;
    (await getIt<IPadelRepository>().isBookmark(padelId: padelId))?.fold((_) {},
        (r) {
      if (mounted) {
        setState(() {
          bookmarked = r;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    loadIsBookmark(widget.item?.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              CustomShimmer(
                show: widget.item == null,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: CachedImage(
                    radius: 20,
                    gradient: (widget.item == null)
                        ? null
                        : const LinearGradient(
                            colors: [Colors.transparent, Colors.black],
                            begin: Alignment.center,
                            end: Alignment.bottomCenter),
                    imageLink: Api.getMedia(widget.item == null
                        ? 'img/placeholder.jpg'
                        : widget.item!.banner),
                    width: double.infinity,
                  ),
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
                      }, (r) async {
                        if (mounted) {
                          setState(() {
                            if (r) {
                              bookmarked = !bookmarked;
                            }
                          });
                        }
                        await Future.delayed(const Duration(seconds: 1));
                        if (widget.onBookmarkChanged != null) {
                          widget.onBookmarkChanged!();
                        }
                      });
                    },
                    icon: Icon(
                      Icons.bookmark,
                      size: 32,
                      color: bookmarked
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.white,
                    )),
              ),
              Align(
                alignment: const Alignment(1, -1),
                child: CustomShimmer(
                  show: widget.item == null,
                  child: InkWell(
                    onTap: () async {
                      if (widget.item?.Location != null) {
                        try {
                          await Util.launchUrI(
                              Api.mapUrI(widget.item!.Location!));
                        } on Failure catch (f) {
                          AppSnackBar.failure(failure: f);
                        }
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.80)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          widget.item == null
                              ? " "
                              : widget.item!.getAddress().name,
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
              ),
              Align(
                alignment: const Alignment(-1, 1.77),
                child: PadelAvatar(
                  borderColor: Colors.white,
                  hero: '',
                  gap: 0,
                  item: widget.item,
                  margins: const EdgeInsets.only(left: 20),
                  onClick: () {},
                  radius: 36,
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
                              : "${widget.item == null ? '-' : widget.item!.price} KD  ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.secondary),
                          children: [
                            TextSpan(
                                text: Util.getDurationIn(widget.item == null
                                    ? 0
                                    : widget.item!.getDuration().minute),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
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
        if (widget.item != null && widget.item!.getFeatures().isEmpty)
          const SizedBox(
            height: 40,
          ),
        Padding(
          padding:
              EdgeInsets.only(top: (widget.item == null ? 16 : 0), left: 24),
          child: CustomShimmer(
            show: widget.item == null,
            child: Text(
              widget.item == null
                  ? '..........................'
                  : widget.item!.getUser().fullName,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  backgroundColor:
                      widget.item == null ? Colors.grey.shade400 : null),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 5, left: 24),
            child: CustomShimmer(
              show: widget.item == null,
              child: Text(
                widget.item == null ? '............' : widget.item!.name,
                style: Theme.of(context).textTheme.caption!.copyWith(
                    backgroundColor:
                        widget.item == null ? Colors.grey.shade400 : null),
              ),
            )),
      ],
    );
  }
}
