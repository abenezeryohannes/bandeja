import 'package:flutter/material.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/presentation/widgets/cached.image.dart';
import '../../../presentation/home/widget/padel.avatar.dart';
import 'feature.card.dart';

class PadelCard extends StatefulWidget {
  const PadelCard({Key? key, this.item}) : super(key: key);
  final PadelModel? item;
  @override
  State<PadelCard> createState() => _PadelCardState();
}

class _PadelCardState extends State<PadelCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                const CachedImage(
                  radius: 20,
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black],
                      begin: Alignment.center,
                      end: Alignment.bottomCenter),
                  imageLink:
                      "https://images.unsplash.com/photo-1533450718592-29d45635f0a9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
                  width: double.infinity,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark,
                      size: 32,
                      color: Colors.white,
                    )),
                Align(
                  alignment: const Alignment(0.9, -0.9),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.85)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        widget.item == null
                            ? " "
                            : widget.item!.getAddress().name,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.location_on,
                        size: 20,
                      )
                    ]),
                  ),
                ),
                Align(
                  alignment: const Alignment(-1, 1.9),
                  child: PadelAvatar(
                    borderColor: Colors.white,
                    hero: '',
                    item: widget.item,
                    margins: const EdgeInsets.only(left: 20),
                    onClick: () {},
                    radius: 40,
                  ),
                ),
                Align(
                  alignment: const Alignment(0.9, 0.9),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "20 KD",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.secondary),
                          children: [
                            TextSpan(
                                text: "/ 1 Hour",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.grey.shade400))
                          ])),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 10),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                  children: (widget.item == null
                          ? [null, null, null]
                          : widget.item!.getFeatures())
                      .map((f) => Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: FeatureCard(feature: f),
                          ))
                      .toList()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 10),
            child: Text(
              widget.item == null ? '' : widget.item!.getUser().fullName,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 5, left: 10),
              child: Text(
                widget.item == null ? '' : widget.item!.name,
                style: Theme.of(context).textTheme.bodyText2,
              )),
        ],
      ),
    );
  }
}
