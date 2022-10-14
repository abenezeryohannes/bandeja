import 'package:feekpadel/src/main/presentation/padels/widgets/padel.page.body.dart';
import 'package:flutter/material.dart';

import '../../../domain/padels/entities/padel.dart';
import '../../home/widget/padel.avatar.dart';

class PadelPage extends StatefulWidget {
  const PadelPage({Key? key, required this.padel}) : super(key: key);
  final PadelModel padel;
  @override
  State<PadelPage> createState() => _PadelPageState();
}

class _PadelPageState extends State<PadelPage> {
  bool isFloating = true;
  double offset = 0;
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        offset = _controller.offset.toDouble();
        // isFloating = false;
      });
      // if (_controller.offset >= _controller.position.maxScrollExtent &&
      //     !_controller.position.outOfRange) {
      //   setState(() {
      //     offset = _controller.offset.abs();
      //     // isFloating = false;
      //   });
      // }
      // if (_controller.offset <= _controller.position.minScrollExtent &&
      //     !_controller.position.outOfRange) {
      //   setState(() {
      //     offset = _controller.offset.abs();
      //     // isFloating = true;
      //   });
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: offset < 120
            ? Align(
                alignment: Alignment(0.5, -0.72 - (offset / 800)),
                child: AnimatedOpacity(
                    duration: const Duration(microseconds: 300),
                    opacity: ((120 - offset) / 120),
                    child: _floatingCard()),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        body: NestedScrollView(
            controller: _controller,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: _appBar(),
                  pinned: true,
                  floating: true,
                  iconTheme: const IconThemeData(size: 0),
                  leadingWidth: 0,
                  leading: null,
                  expandedHeight: 250,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 3,
                    background: SizedBox(
                      height: 260,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Container(
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                image: DecorationImage(
                                    image: NetworkImage(widget.padel.banner))),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 150),
                          //   child: _floatingCard(),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
                child: PadelPageBody(padel: widget.padel))));
  }

  Widget _floatingCard() {
    return Container(
      height: 200,
      child: Stack(
        alignment: const Alignment(0, 0),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding:
                const EdgeInsets.only(left: 24, right: 20, top: 10, bottom: 20),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.4)),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            widget.padel.getAddress().name,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.location_on,
                            size: 16,
                          )
                        ]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.padel.getUser().fullName,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 8),
                  Text(widget.padel.name,
                      style: Theme.of(context).textTheme.caption),
                ]),
          ),
          Align(
            alignment: const Alignment(-0.8, -1.1),
            child: PadelAvatar(
              borderColor: Colors.white,
              hero: '',
              item: widget.padel,
              margins: const EdgeInsets.only(left: 20),
              onClick: () {},
              radius: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: Colors.white)),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                size: 24,
                color: Colors.black,
              ),
            )),
        IconButton(
            onPressed: () {},
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.add_location_alt,
                  size: 20,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 2,
                ),
                Flexible(
                  child: Text('Location',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.white, fontSize: 11)),
                )
              ],
            ))
      ],
    );
  }
}
