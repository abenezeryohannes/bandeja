import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../../../../core/domain/padels/entities/padel.group.dart';
import '../../../../core/network/api.dart';
import '../../../../core/presentation/widgets/custom.shimmer.dart';

class ItemGroupsTab extends StatefulWidget {
  const ItemGroupsTab(
      {Key? key, required this.itemGroups, required this.onItemClick})
      : super(key: key);
  final List<PadelGroupModel?> itemGroups;
  final Function(PadelGroupModel itemGroup) onItemClick;
  @override
  State<ItemGroupsTab> createState() => _ItemGroupsTabState();
}

class _ItemGroupsTabState extends State<ItemGroupsTab> {
  PageController controller =
      PageController(initialPage: 0, viewportFraction: 0.5);
  @override
  Widget build(BuildContext context) {
    return ScrollSnapList(
      onItemFocus: (x) {
        print(x);
      },
      // dynamicItemSize: true,
      selectedItemAnchor: SelectedItemAnchor.START,
      itemBuilder: (context, index) {
        return CustomShimmer(
          show: widget.itemGroups[index] == null,
          child: SizedBox(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Image.network(
                Api.getMedia(widget.itemGroups[index] == null
                    ? 'img/placeholder.png'
                    : widget.itemGroups[index]!.icon),
                width: 24,
                height: 24,
              ),
              const SizedBox(
                height: 8,
              ),
              Flexible(
                child: Text(
                  widget.itemGroups[index] == null
                      ? '-'
                      : widget.itemGroups[index]!.name,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ]),
          ),
        );
      },
      itemCount: widget.itemGroups.length,
      reverse: true,
      itemSize: 100,
    );
    // return PageView.builder(
    //     itemCount: widget.itemGroups.length,
    //     controller: controller,
    //     // padEnds: false,
    //     itemBuilder: (context, index) {
    //       return SizedBox(
    //         width: 50,
    //         child: Column(mainAxisSize: MainAxisSize.min, children: [
    //           Image.network(
    //             Api.getMedia(widget.itemGroups[index].icon),
    //             width: 24,
    //             height: 24,
    //           ),
    //           const SizedBox(
    //             height: 8,
    //           ),
    //           Flexible(
    //             child: Text(
    //               widget.itemGroups[index].name,
    //               style: Theme.of(context).textTheme.bodySmall,
    //             ),
    //           ),
    //         ]),
    //       );
    //     });
    // return DefaultTabController(
    //     length: widget.itemGroups.length,
    //     child: TabBar(
    //       indicatorPadding: const EdgeInsets.only(top: 5),
    //       indicatorColor: Theme.of(context).indicatorColor,
    //       onTap: (index) {
    //         widget.onItemClick(widget.itemGroups[index]);
    //       },
    //       isScrollable: true,
    //       tabs: widget.itemGroups
    //           .map((e) => Tab(
    //                 child: Column(children: [
    //                   Image.network(
    //                     Api.getMedia(e.icon),
    //                     width: 24,
    //                     height: 24,
    //                   ),
    //                   const SizedBox(
    //                     height: 8,
    //                   ),
    //                   Flexible(
    //                     child: Text(
    //                       e.name,
    //                       style: Theme.of(context).textTheme.bodySmall,
    //                     ),
    //                   ),
    //                 ]),
    //               ))
    //           .toList(),
    //     ));
  }
}
