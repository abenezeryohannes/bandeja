import 'dart:io';
import 'dart:typed_data';

import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:social_share/social_share.dart';

import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/api.dart';
import '../../../../core/utils/util.dart';
import '../../home/widget/padel.avatar.dart';
import '../widgets/triangle.painter.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key, required this.padel, required this.order})
      : super(key: key);
  final PadelModel padel;
  final PadelOrderModel order;
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  GlobalKey globalKey = GlobalKey();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: RepaintBoundary(
        key: globalKey,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: _reciept(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [triangle(), triangle(), triangle(), triangle()],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget triangle() {
    return CustomPaint(
      painter: TrianglePainter(
        strokeColor: Theme.of(context).primaryColor,
        strokeWidth: 1,
        paintingStyle: PaintingStyle.fill,
      ),
      child: const SizedBox(
        height: 20,
        width: 70,
      ),
    );
  }

  Widget _reciept() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
            child: PadelAvatar(
                item: widget.padel,
                borderColor: Colors.transparent,
                radius: 42,
                margins: EdgeInsets.zero,
                hero: '',
                onClick: () {})),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            widget.padel.getUser().fullName,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            widget.padel.name,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // if (widget.order.status.endsWith('confirmed') ||
        //     widget.order.status.endsWith('paid') ||
        //     widget.order.status.endsWith('payed'))
        Center(
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            color: Colors.green.shade400,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 26.0),
              child: Text(
                widget.order.status,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _item(
                "Date",
                widget.order.PadelSchedule == null
                    ? '-'
                    : DateFormat("DD/MM/yy")
                        .format(widget.order.getSchedule().startTime)),
            _item(
                "Time",
                widget.order.PadelSchedule == null
                    ? '-'
                    : DateFormat.jm()
                        .format(widget.order.getSchedule().startTime)),
            _item(
                "Location",
                widget.padel.Address == null
                    ? '-'
                    : widget.padel.getAddress().name),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            onPressed: () async {
              setState(() {
                loading = true;
              });
              try {
                Uint8List? img = await Util.capturePng(globalKey);
                if (img != null) {
                  Directory appDocDirectory =
                      await getApplicationDocumentsDirectory();

                  await Directory('${appDocDirectory.path}/')
                      .create(recursive: true);
                  final file =
                      await File('${appDocDirectory.path}/shareImage.jpg')
                          .writeAsBytes(img);
                  if (file.existsSync()) {
                    SocialShare.shareOptions((widget.padel.name),
                        imagePath: file.path);
                  } else {
                    SocialShare.shareOptions(
                      (widget.padel.name),
                    );
                  }
                }
              } catch (_) {
              } finally {
                setState(() {
                  loading = false;
                });
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.forward,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                (loading)
                    ? const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        child: CircularProgressIndicator(),
                      )
                    : Text("Invite Your Team",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white)),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        QrImage(
          data: widget.order.barCode ?? '',
          version: QrVersions.auto,
          size: 160,
          gapless: false,
        )
      ],
    );
  }

  Widget _item(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Theme.of(context).colorScheme.secondary),
        )
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        "Your Booking",
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leadingWidth: 56,
      elevation: 0,
      leading: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
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
      actions: [
        IconButton(
            onPressed: () async {
              if (widget.order == null) return;
              if (widget.order.getPadel().Location == null) {
                return;
              }
              try {
                await Util.launchUrI(
                    Api.mapUrI(widget.order!.getPadel().Location!));
              } on Failure catch (f) {
                AppSnackBar.failure(failure: f);
              }
            },
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/location.png',
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 3,
                ),
                Flexible(
                  child: Text('Location',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.white, fontSize: 9)),
                )
              ],
            ))
      ],
    );
  }
}
