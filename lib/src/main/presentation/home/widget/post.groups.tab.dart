import 'package:flutter/material.dart';

import '../../../../core/domain/posts/entities/post.group.dart';

class ItemGroupsTab extends StatefulWidget {
  const ItemGroupsTab(
      {Key? key, required this.itemGroups, required this.onItemClick})
      : super(key: key);
  final List<PostGroupModel> itemGroups;
  final Function(PostGroupModel itemGroup) onItemClick;
  @override
  State<ItemGroupsTab> createState() => _ItemGroupsTabState();
}

class _ItemGroupsTabState extends State<ItemGroupsTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.itemGroups.length,
        child: TabBar(
          indicatorPadding: const EdgeInsets.only(top: 5),
          indicatorColor: Theme.of(context).indicatorColor,
          onTap: (index) {
            widget.onItemClick(widget.itemGroups[index]);
          },
          isScrollable: true,
          tabs: widget.itemGroups
              .map((e) => Tab(
                    child: Column(children: [
                      if (e.icon != null)
                        Image.asset(
                          e.icon!,
                          width: 24,
                          height: 24,
                        ),
                      const SizedBox(
                        height: 8,
                      ),
                      Flexible(
                        child: Text(
                          e.name,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ]),
                  ))
              .toList(),
        ));
  }
}
