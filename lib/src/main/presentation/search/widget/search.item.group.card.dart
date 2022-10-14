import 'package:flutter/material.dart';

class SearchItemGroupCard extends StatefulWidget {
  const SearchItemGroupCard(
      {Key? key,
      required this.icon,
      required this.title,
      required this.active,
      required this.onClick})
      : super(key: key);

  final String icon;
  final String title;
  final bool active;
  final Function onClick;

  @override
  State<SearchItemGroupCard> createState() => _SearchItemGroupCardState();
}

class _SearchItemGroupCardState extends State<SearchItemGroupCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              widget.onClick();
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey.shade400),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: widget.active
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).cardColor),
                child: Image.asset(
                  "assets/img/ball.png",
                  height: 42,
                  width: 42,
                  color: (widget.active) ? Colors.white : Colors.grey.shade600,
                )
                //  CachedImage(
                //   imageLink: icon,
                //   height: 42,
                //   width: 32,
                // ),
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          )
        ],
      ),
    );
  }
}
