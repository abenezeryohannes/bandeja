import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/presentation/widgets/custom.shimmer.dart';

class AdminBookingCard extends StatefulWidget {
  const AdminBookingCard({Key? key, this.order, required this.onClick})
      : super(key: key);
  final PadelOrderModel? order;
  final Function(PadelOrderModel) onClick;
  @override
  State<AdminBookingCard> createState() => _AdminBookingCardState();
}

class _AdminBookingCardState extends State<AdminBookingCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      elevation: 1,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: InkWell(
        onTap: () {
          if (widget.order != null) widget.onClick(widget.order!);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 10, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomShimmer(
                show: widget.order == null,
                child: Container(
                  width: 78,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: (widget.order?.paymentId != null ||
                            widget.order?.status == 'confirmed')
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.8),
                  ),
                  child: Text(
                    (widget.order?.paymentDate != null)
                        ? DateFormat.jm().format(widget.order!.paymentDate!)
                        : (widget.order?.createdAt != null)
                            ? DateFormat.jm().format(widget.order!.createdAt!)
                            : '00:00 AM',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomShimmer(
                            show: widget.order == null,
                            child: Text(
                              widget.order == null
                                  ? "........."
                                  : widget.order!.getUser().fullName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Colors.black,
                                      backgroundColor: widget.order == null
                                          ? Colors.grey
                                          : null,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomShimmer(
                            show: widget.order == null,
                            child: Text(
                              "${widget.order == null ? '.................' : widget.order!.barCode}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.grey.shade500,
                                      backgroundColor: widget.order == null
                                          ? Colors.grey
                                          : null,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomShimmer(
                            show: widget.order == null,
                            child: Text(
                              "Court: ${widget.order == null ? "............................" : (widget.order!.getPadel().name)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      backgroundColor: widget.order == null
                                          ? Colors.grey
                                          : null,
                                      color: Colors.grey.shade500),
                            ),
                          ),
                        ],
                      ),
                      // if (widget.order != null)
                      CustomShimmer(
                        show: widget.order == null,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey.shade200),
                          child: Text(
                            (widget.order == null ||
                                    widget.order!.barCode == null)
                                ? '#0000000'
                                : widget.order!.barCode!,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
