import 'dart:ui';

import 'package:bandeja/main/injection/injector.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:bandeja/src/core/presentation/widgets/big.text.button.dart';
import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:bandeja/src/owner/data/padels/dto/padel.dto.dart';
import 'package:bandeja/src/owner/domain/padels/i.owner.padel.repository.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/api.dart';

class RecentOwnerPadelCard extends StatefulWidget {
  const RecentOwnerPadelCard(
      {Key? key,
      this.padel,
      required this.height,
      this.scrollAmount = 1,
      this.length = 1,
      required this.index,
      required this.onClick,
      required this.onPowerClick,
      required this.onEditClick})
      : super(key: key);
  final PadelModel? padel;
  final Function onClick;
  final Function onPowerClick;
  final Function onEditClick;
  final double height;
  final int index;
  final int length;
  final double scrollAmount;
  @override
  State<RecentOwnerPadelCard> createState() => _RecentOwnerPadelCardState();
}

class _RecentOwnerPadelCardState extends State<RecentOwnerPadelCard> {
  late double scale;
  late Offset offset;
  late double clampedDifference;
  late PadelModel? _padel;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _padel = widget.padel;
    clampedDifference = (widget.scrollAmount - widget.index).clamp(-1, 1);

    // offset = Offset(0.0, 128.0 * clampedDifference);

    scale =
        lerpDouble(1, widget.length > 1 ? 0.8 : 1, clampedDifference.abs())!;

    return Transform.scale(
      scaleY: scale,
      child: InkWell(
        onTap: () {
          widget.onClick();
        },
        child: SizedBox(
          height: widget.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Stack(
              children: [
                Container(
                  height: widget.height,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey.shade200,
                      image: _padel == null
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(Api.getMedia(
                                  _padel?.banner ?? "img/placeholder.jpg")))),
                ),
                CustomShimmer(
                  show: _padel == null,
                  child: Container(
                      height: widget.height,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        gradient: RadialGradient(
                          radius: 0.8,
                          colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              _padel?.name ?? ' ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_padel != null)
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                _padel == null
                                    ? '   '
                                    : _padel!.getAddress().name,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_padel != null)
                                const Icon(
                                  Icons.watch_later,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                _padel == null
                                    ? '   '
                                    : _padel!.getAddress().name,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              color: (_padel?.enabled ?? false)
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Text(
                            (_padel?.enabled ?? false)
                                ? 'Live'
                                : 'Out of service',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ))
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BigTextButton(
                          onClick: () => widget.onEditClick(),
                          isExpanded: false,
                          textWidget: Text(
                            'Edit the court',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                          padding: const EdgeInsets.only(
                              left: 45, right: 45, top: 10, bottom: 10),
                          horizontalMargin:
                              const EdgeInsets.only(left: 0, right: 0),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        BigTextButton(
                            isExpanded: false,
                            isLoading: loading,
                            onClick: () async {
                              setState(() {
                                loading = true;
                              });
                              if (_padel == null) return;
                              final repo = getIt<IOwnerPadelRepository>();
                              PadelDto dto = PadelDto.fromPadelModel(_padel!);
                              dto.padelFeatureDto = [];
                              dto.padelSchedules = [];
                              dto.enabled = !dto.enabled;
                              final result =
                                  await repo.editPadel(padelDto: dto);

                              setState(() {
                                loading = false;
                              });
                              if (result == null) {
                                AppSnackBar.failure(
                                    failure: UnExpectedFailure());
                              }
                              result?.fold(
                                  (l) => AppSnackBar.failure(failure: l),
                                  (r) => setState(() {
                                        _padel = r;
                                      }));
                            },
                            cornerRadius: 10,
                            textWidget: const Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.power_settings_new,
                                color: Colors.white,
                                size: 32,
                              ),
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
