import 'package:bandeja/src/core/presentation/widgets/cached.image.dart';
import 'package:bandeja/src/core/presentation/widgets/custom.shimmer.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/api.dart';

class SearchItemGroupCard extends StatefulWidget {
  const SearchItemGroupCard(
      {Key? key,
      this.icon,
      this.title,
      required this.active,
      required this.onClick})
      : super(key: key);

  final String? icon;
  final String? title;
  final bool active;
  final Function onClick;

  @override
  State<SearchItemGroupCard> createState() => _SearchItemGroupCardState();
}

class _SearchItemGroupCardState extends State<SearchItemGroupCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              widget.onClick();
            },
            child: CustomShimmer(
              show: widget.icon == null,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: widget.title == null
                          ? Colors.grey.shade300
                          : widget.active
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).cardColor),
                  child: CachedImage(
                    height: 42,
                    width: 42,
                    imageLink: Api.getMedia(widget.icon == null
                        ? 'img/placeholder.jpg'
                        : widget.icon!),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CustomShimmer(
              show: widget.title == null,
              child: Text(
                widget.title == null
                    ? '.............................'
                    : widget.title!,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
