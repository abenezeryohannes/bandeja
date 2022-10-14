import 'package:flutter/widgets.dart';

class SizablePageView extends StatefulWidget {
  const SizablePageView(
      {Key? key, required this.bodies, required this.viewFraction})
      : super(key: key);
  final List<Widget> bodies;
  final double viewFraction;

  @override
  State<SizablePageView> createState() => _SizablePageViewState();
}

class _SizablePageViewState extends State<SizablePageView> {
  late PageController _pageController;
  double _scrollAmount = 0.0;

  @override
  void initState() {
    _scrollAmount = (widget.bodies.length) / 2;
    _pageController = PageController(
        viewportFraction: widget.viewFraction,
        initialPage: _scrollAmount.toInt());
    _pageController.addListener(() {
      setState(() {
        _scrollAmount = _pageController.page!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        // to make it uncentered
        padEnds: false,
        scrollDirection: Axis.horizontal,
        itemCount: widget.bodies.length,
        controller: _pageController,
        itemBuilder: (context, index) {
          return widget.bodies[index];
        });
  }
}
