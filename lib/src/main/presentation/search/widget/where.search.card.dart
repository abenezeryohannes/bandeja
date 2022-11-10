import 'package:bandeja/src/main/domain/core/entities/address.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/tab.bar.dart';

class WhereSearchCard extends StatefulWidget {
  const WhereSearchCard(
      {Key? key,
      required this.active,
      this.value,
      required this.activate,
      required this.onChange,
      required this.items})
      : super(key: key);
  final bool active;
  final AddressModel? value;
  final List<AddressModel?> items;
  final Function(AddressModel val) onChange;
  final Function() activate;
  @override
  State<WhereSearchCard> createState() => _WhereSearchCardState();
}

class _WhereSearchCardState extends State<WhereSearchCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      child: Container(
          margin: const EdgeInsets.only(left: 20, top: 16, right: 20),
          padding:
              const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 15.0, // soften the shadow
                spreadRadius: 5.0, //extend the shadow
                offset: const Offset(
                  5.0, // Move to right 5  horizontally
                  5.0, // Move to bottom 5 Vertically
                ),
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  widget.activate();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Where",
                          style: TextStyle(
                              color: (widget.active)
                                  ? Colors.black
                                  : Colors.grey.shade700,
                              fontSize: (widget.active) ? 24 : 18,
                              fontWeight: FontWeight.bold)),
                      Text(widget.value == null ? 'Nearby' : widget.value!.name,
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
                height: widget.active ? 70 : 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: widget.active ? 1 : 0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: SizedBox(
                      height: 40,
                      child: CircularTabBar(
                        onItemClick: (int index) {
                          if (widget.items[index] == null) return;
                          widget.onChange(widget.items[index]!);
                        },
                        tabs: widget.items
                            .map((e) => CircularTab(text: e?.name, radius: 100))
                            .toList(),
                        value: widget.value != null
                            ? widget.items.indexOf(widget.value!)
                            : -1,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
