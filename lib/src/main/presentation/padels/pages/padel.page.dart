import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:bandeja/src/main/presentation/padels/controllers/padel.page.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/api.dart';
import '../../../../core/utils/util.dart';
import '../../../domain/padels/repositories/i.padel.repository.dart';
import '../../home/widget/padel.avatar.dart';
import '../widgets/padel.page.body.dart';

class PadelPage extends StatefulWidget {
  const PadelPage({Key? key, required this.padel}) : super(key: key);
  final PadelModel padel;
  @override
  State<PadelPage> createState() => _PadelPageState();
}

class _PadelPageState extends State<PadelPage> {
  bool isFloating = true;
  double offset = 0;
  final ScrollController _controller = ScrollController();
  late PadelPageController controller;
  final padelRepository = getIt<IPadelRepository>();

  @override
  void initState() {
    controller = Get.put(PadelPageController(padel: widget.padel));
    _controller.addListener(() {
      if (mounted) {
        setState(() {
          offset = _controller.offset.toDouble();
        });
      }
    });

    try {
      controller.schedule.value =
          widget.padel.getSchedules().firstWhere((element) => !element.booked);
    } catch (_) {}

    controller.loadPadel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Align(
          alignment: Alignment(0.5, -0.72 - (offset / 400)),
          child: AnimatedOpacity(
              duration: const Duration(microseconds: 300),
              opacity: ((120 - (offset > 120 ? 120 : offset)) / 120),
              child: _floatingCard()),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        body: NestedScrollView(
            controller: _controller,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: _appBar(),
                  pinned: true,
                  floating: true,
                  iconTheme: const IconThemeData(size: 0),
                  leadingWidth: 0,
                  leading: null,
                  expandedHeight: 200,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 3,
                    background: Stack(
                      children: [
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      Api.getMedia(widget.padel.banner)))),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.only(bottom: 48.0, top: 70),
              child: PadelPageBody(
                padel: widget.padel,
                controller: controller,
              ),
            )));
  }

  Widget _floatingCard() {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: const Alignment(0, 0),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            padding:
                const EdgeInsets.only(left: 24, right: 20, top: 10, bottom: 20),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.3)),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            widget.padel.getAddress().name,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.location_on,
                            size: 16,
                          )
                        ]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.padel.getUser().fullName,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 8),
                  Text(widget.padel.name,
                      style: Theme.of(context).textTheme.caption),
                ]),
          ),
          Align(
            alignment: const Alignment(-0.8, -1.1),
            child: PadelAvatar(
              borderColor: Colors.white,
              hero: '',
              item: widget.padel,
              margins: const EdgeInsets.only(left: 20),
              onClick: () {},
              radius: 40,
            ),
          ),
          Align(
            alignment: const Alignment(0.8, 0.5),
            child: IconButton(
                onPressed: () async {
                  final result = await padelRepository.setBookmark(
                      padelId: widget.padel.id);
                  result!.fold((l) {
                    AppSnackBar.failure(failure: l);
                  }, (r) {
                    if (mounted) {
                      setState(() {
                        if (r) {
                          controller.isBookmarked.value =
                              !(controller.isBookmarked.value);
                        }
                      });
                    }
                  });
                },
                icon: Icon(
                  controller.isBookmarked.value
                      ? Icons.bookmark
                      : Icons.bookmark_outline,
                  size: 32,
                  color: controller.isBookmarked.value
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.grey,
                )),
          ),
        ],
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: Colors.white)),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                size: 24,
                color: Colors.black,
              ),
            )),
        IconButton(
            onPressed: () async {
              if (widget.padel.Location == null) {
                return;
              }
              try {
                await Util.launchUrI(Api.mapUrI(widget.padel.Location!));
              } on Failure catch (f) {
                AppSnackBar.failure(failure: f);
              }
            },
            icon: Stack(
              children: [
                Image.asset(
                  'assets/icons/location.png',
                  width: 24,
                  height: 24,
                  color: Colors.grey.shade700,
                ),

                AnimatedOpacity(
                  duration: const Duration(microseconds: 300),
                  opacity: ((120 - (offset > 120 ? 120 : offset)) / 120),
                  child: Image.asset(
                    'assets/icons/location.png',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                ),

                // Flexible(
                //   child: Text('Location',
                //       style: Theme.of(context)
                //           .textTheme
                //           .caption!
                //           .copyWith(color: Colors.white, fontSize: 11)),
                // )
              ],
            ))
      ],
    );
  }
}
