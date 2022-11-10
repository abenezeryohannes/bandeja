import 'package:bandeja/src/core/domain/padels/entities/promo.code.dart';
import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';

class OwnerPromoCodeCard extends StatefulWidget {
  const OwnerPromoCodeCard({Key? key, this.promo, required this.onClick})
      : super(key: key);
  final PromoCodeModel? promo;
  final Function(PromoCodeModel) onClick;
  @override
  State<OwnerPromoCodeCard> createState() => _OwnerPromoCodeCardState();
}

class _OwnerPromoCodeCardState extends State<OwnerPromoCodeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      elevation: 0,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: InkWell(
        onTap: () {
          if (widget.promo != null) widget.onClick(widget.promo!);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomShimmer(
                show: widget.promo == null,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Colors.amber),
                  child: Text(
                    "${widget.promo?.discount.toInt() ?? 0} %",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomShimmer(
                            show: widget.promo == null,
                            child: Text(
                              widget.promo == null
                                  ? "........."
                                  : widget.promo!.code,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Colors.black,
                                      backgroundColor: widget.promo == null
                                          ? Colors.grey
                                          : null,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomShimmer(
                            show: widget.promo == null,
                            child: Text(
                              "${widget.promo == null ? 0 : widget.promo!.leftForBooking} Booking Promo",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.amber,
                                      backgroundColor: widget.promo == null
                                          ? Colors.grey
                                          : null,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomShimmer(
                            show: widget.promo == null,
                            child: Text(
                              "Court: ${widget.promo == null ? "............................" : (widget.promo!.PadelName ?? '')}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      backgroundColor: widget.promo == null
                                          ? Colors.grey
                                          : null,
                                      color: Colors.grey.shade500),
                            ),
                          ),
                        ],
                      ),
                      if (widget.promo != null)
                        Icon(
                          Icons.chevron_right,
                          size: 32,
                          color: Colors.grey.shade700,
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
