import 'package:bandeja/main/injection/injector.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:bandeja/src/core/presentation/widgets/big.text.button.dart';
import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:bandeja/src/main/presentation/home/widget/padel.avatar.dart';
import 'package:bandeja/src/owner/data/padels/dto/padel.dto.dart';
import 'package:bandeja/src/owner/domain/padels/i.owner.padel.repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/network/api.dart';
import '../../../../core/utils/util.dart';

class AdminPadelCard extends StatefulWidget {
  const AdminPadelCard(
      {Key? key,
      this.padel,
      required this.height,
      required this.index,
      required this.onClick,
      required this.onPowerClick,
      required this.onPhoneClick})
      : super(key: key);
  final PadelModel? padel;
  final Function onClick;
  final Function onPowerClick;
  final Function onPhoneClick;
  final double height;
  final int index;
  @override
  State<AdminPadelCard> createState() => _AdminPadelCardState();
}

class _AdminPadelCardState extends State<AdminPadelCard> {
  late PadelModel? _padel;
  bool loading = false;
  @override
  void initState() {
    _padel = widget.padel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                padding: const EdgeInsets.only(
                    bottom: 10.0, top: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PadelAvatar(
                            borderColor: Colors.white,
                            radius: 30,
                            item: widget.padel,
                            margins: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            onClick: () {}),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            _padel?.name ?? ' ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                          ),
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
                                  .copyWith(color: Colors.white, fontSize: 14),
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
                                  : " ${Util.getDurationIn(_padel!.getDuration().minute)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    CustomShimmer(
                      show: widget.padel == null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  color: (_padel?.enabled ?? false)
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Text(
                                (_padel?.enabled ?? false)
                                    ? 'Active'
                                    : 'Out of service',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigTextButton(
                                    isExpanded: false,
                                    onClick: () async {},
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 6),
                                    cornerRadius: 10,
                                    textWidget: const Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Icon(
                                        Icons.call,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                BigTextButton(
                                    isExpanded: false,
                                    isLoading: loading,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 6),
                                    onClick: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (_padel == null) return;
                                      final repo =
                                          getIt<IOwnerPadelRepository>();
                                      PadelDto dto =
                                          PadelDto.fromPadelModel(_padel!);
                                      dto.enabled = !dto.enabled;
                                      dto.padelFeatureDto = [];
                                      dto.padelSchedules = [];
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
                                          (l) =>
                                              AppSnackBar.failure(failure: l),
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
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
