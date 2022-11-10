import 'package:bandeja/src/main/presentation/search/widget/search.item.group.card.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/padels/entities/padel.group.dart';

class LookingForSearchCard extends StatefulWidget {
  const LookingForSearchCard(
      {Key? key,
      required this.active,
      this.value,
      required this.onChange,
      required this.items,
      required this.activate})
      : super(key: key);
  final bool active;
  final List<PadelGroupModel?> items;
  final PadelGroupModel? value;
  final Function(PadelGroupModel item) onChange;
  final Function() activate;

  @override
  State<LookingForSearchCard> createState() => _LookingForSearchCardState();
}

class _LookingForSearchCardState extends State<LookingForSearchCard>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  ); //..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.active) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    return AnimatedSize(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 300),
      child: Container(
          margin: const EdgeInsets.only(left: 20, top: 16, right: 20),
          padding:
              const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 15.0,
                spreadRadius: 5.0,
                offset: const Offset(5.0, 5.0),
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InkWell(
              onTap: () {
                widget.activate();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Looking for ?",
                        style: TextStyle(
                            color: (widget.active)
                                ? Colors.black
                                : Colors.grey.shade700,
                            fontSize: (widget.active) ? 24 : 18,
                            fontWeight: (widget.active)
                                ? FontWeight.bold
                                : FontWeight.w500)),
                    Text((widget.value == null) ? '' : widget.value!.name,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: widget.active
                  ? ((100 * ((widget.items.length / 3))) + 100)
                  : 0,
              child: AnimatedOpacity(
                opacity: widget.active ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 30,
                    runSpacing: 10,
                    alignment: WrapAlignment.end,
                    children: widget.items
                        .map((e) => SearchItemGroupCard(
                              active: e == widget.value,
                              title: e?.name,
                              icon: e?.icon,
                              onClick: () {
                                if (e == null) return;
                                widget.onChange(e);
                              },
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ])),
    );
  }
}
