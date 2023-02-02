import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../main/presentation/home/widget/padel.avatar.dart';
import '../../../../main/presentation/padels/widgets/triangle.painter.dart';

class OwnerBookingPage extends StatefulWidget {
  const OwnerBookingPage({Key? key, required this.order}) : super(key: key);
  final PadelOrderModel order;
  @override
  State<OwnerBookingPage> createState() => _OwnerBookingPageState();
}

class _OwnerBookingPageState extends State<OwnerBookingPage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
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
                item: widget.order.getPadel(),
                borderColor: Colors.transparent,
                radius: 42,
                margins: EdgeInsets.zero,
                hero: '',
                onClick: () {})),
        const SizedBox(
          height: 3,
        ),
        Center(
          child: Text(
            widget.order.getUser().fullName,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            widget.order.getUser().phoneNumber,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            widget.order.getPadel().name,
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
                borderRadius: BorderRadius.all(Radius.circular(14))),
            color: (widget.order.paymentId != null ||
                    widget.order.status == 'confirmed')
                ? Colors.green.shade400
                : Colors.amber,
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
          height: 34,
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
                widget.order.getPadel().Address == null
                    ? '-'
                    : widget.order.getPadel().getAddress().name),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
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
          margin: const EdgeInsets.only(top: 12, bottom: 12, left: 20),
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
      actions: [],
    );
  }
}
