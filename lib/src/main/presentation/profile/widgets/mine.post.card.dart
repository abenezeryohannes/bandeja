import 'package:feekpadel/src/core/widgets/cached.image.dart';
import 'package:flutter/material.dart';

class MinePostCard extends StatefulWidget {
  const MinePostCard({Key? key}) : super(key: key);

  @override
  State<MinePostCard> createState() => _MinePostCardState();
}

class _MinePostCardState extends State<MinePostCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 120,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.all(14),
              child: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CachedImage(
                        radius: 10,
                        imageLink:
                            "https://images.unsplash.com/photo-1533450718592-29d45635f0a9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
                        height: 90,
                        width: 100,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 8, top: 10, right: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "For sale Panel Racket Black and white colo..",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "20 KD",
                                  style: TextStyle(
                                      color: Theme.of(context).backgroundColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20)),
                                    child: const Text(
                                      "Court",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment(1, -1),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              color: Colors.red,
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
