import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/main/presentation/booking/widgets/checkout.items.dart';
import 'package:bandeja/src/main/presentation/home/widget/padel.avatar.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrModal extends StatefulWidget {
  const QrModal({Key? key, required this.padelOrder}) : super(key: key);
  final PadelOrderModel padelOrder;
  @override
  State<QrModal> createState() => _QrModalState();
}

class _QrModalState extends State<QrModal> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 45, left: 30, right: 30),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 30,
            ),
            Text(_getTitle(), style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(
              height: 10,
            ),
            Text(widget.padelOrder.getPadel().name,
                style: Theme.of(context).textTheme.caption),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: CheckoutItems(
                  padel: widget.padelOrder.getPadel(),
                  time: widget.padelOrder.getSchedule().startTime),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: QrImage(
                data: 'This is a simple QR code',
                version: QrVersions.auto,
                size: 180,
                gapless: false,
              ),
            )
          ]),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: PadelAvatar(
            borderColor: Colors.white,
            radius: 40,
            margins: EdgeInsets.zero,
            hero: '',
            onClick: () {},
            item: widget.padelOrder.getPadel(),
          ),
        )
      ],
    );
  }

  String _getTitle() {
    if (widget.padelOrder.getPadel().User != null) {
      return widget.padelOrder.getPadel().User!.fullName;
    }
    return 'Unknown';
  }
}
