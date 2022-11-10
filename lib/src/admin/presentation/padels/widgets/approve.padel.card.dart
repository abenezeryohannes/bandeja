import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/presentation/widgets/app.snack.bar.dart';
import '../../../../owner/data/padels/dto/padel.dto.dart';
import '../../../../owner/domain/padels/i.owner.padel.repository.dart';

class ApprovePadelCard extends StatefulWidget {
  const ApprovePadelCard({
    Key? key,
    this.padel,
    required this.onClick,
  }) : super(key: key);
  final PadelModel? padel;
  final Function(PadelModel) onClick;
  @override
  State<ApprovePadelCard> createState() => _ApprovePadelCardState();
}

class _ApprovePadelCardState extends State<ApprovePadelCard> {
  bool approved = false;
  @override
  void initState() {
    approved = widget.padel?.approved ?? false;
    super.initState();
  }

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
          if (widget.padel != null) widget.onClick(widget.padel!);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomShimmer(
                show: widget.padel == null,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.padel == null ? 24 : 20, vertical: 20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Colors.amber),
                  child: Image.asset(
                    'assets/icons/briefcase.png',
                    width: 32,
                    height: 32,
                    color: Colors.white,
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
                            show: widget.padel == null,
                            child: Text(
                              widget.padel == null
                                  ? "...................."
                                  : widget.padel!.getUser().fullName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Colors.black,
                                      backgroundColor: widget.padel == null
                                          ? Colors.grey
                                          : null,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomShimmer(
                            show: widget.padel == null,
                            child: Text(
                              widget.padel?.name ?? '............',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.amber,
                                      backgroundColor: widget.padel == null
                                          ? Colors.grey
                                          : null,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomShimmer(
                            show: widget.padel == null,
                            child: Text(
                              widget.padel == null
                                  ? "......................................."
                                  : (widget.padel!.getUser().emailAddress ??
                                      ''),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      backgroundColor: widget.padel == null
                                          ? Colors.grey
                                          : null,
                                      color: Colors.grey.shade500),
                            ),
                          ),
                        ],
                      ),
                      if (widget.padel != null)
                        InkWell(
                          onTap: () {
                            if (widget.padel != null) {
                              approve(padel: widget.padel!);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 2,
                                    color: approved
                                        ? Colors.amber
                                        : Colors.grey.shade400)),
                            child: Icon(Icons.check,
                                size: 16,
                                color: approved
                                    ? Colors.amber
                                    : Colors.grey.shade400),
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

  void approve({required PadelModel padel}) async {
    PadelDto dto = PadelDto.fromPadelModel(padel);
    dto.approved = !(approved);
    dto.padelFeatureDto = [];
    dto.padelSchedules = [];
    final result =
        await getIt<IOwnerPadelRepository>().editPadel(padelDto: dto);
    if (result == null) {
      return;
    }
    result.fold((l) {
      AppSnackBar.failure(failure: l);
    }, (r) {
      setState(() {
        approved = r.approved;
      });
      AppSnackBar.success(
          message: 'Court ${approved ? 'Approved' : 'Not Approved'}');
    });
  }
}
