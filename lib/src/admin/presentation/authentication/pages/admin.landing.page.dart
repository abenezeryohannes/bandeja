import 'package:bandeja/src/admin/presentation/authentication/pages/admin.login.page.dart';
import 'package:bandeja/src/admin/presentation/authentication/pages/admin.signup.page.dart';
import 'package:bandeja/src/core/presentation/widgets/big.text.button.dart';
import 'package:bandeja/src/owner/presentation/authentication/pages/owner.login.page.dart';
import 'package:bandeja/src/owner/presentation/authentication/pages/owner.signup.page.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminLandingPage extends StatefulWidget {
  const AdminLandingPage({Key? key}) : super(key: key);

  @override
  State<AdminLandingPage> createState() => _AdminLandingPageState();
}

class _AdminLandingPageState extends State<AdminLandingPage> {
  late PageController _pageController;
  double _scrollAmount = 0.0;

  @override
  void initState() {
    _pageController = PageController(initialPage: _scrollAmount.toInt());
    _pageController.addListener(() {
      setState(() {
        _scrollAmount = _pageController.page!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            DotsIndicator(
              dotsCount: 3,
              position: _scrollAmount,
              decorator: DotsDecorator(
                  size: const Size(10, 10),
                  activeSize: const Size(40, 10),
                  activeShape: const StadiumBorder(),
                  color: Colors.grey.shade300,
                  activeColor: Theme.of(context).colorScheme.secondary),
            ),
            const SizedBox(
              height: 30,
            ),
            ExpandablePageView(controller: _pageController, children: [
              Image.asset(
                'assets/img/owner_landing_1.png',
                width: MediaQuery.of(context).size.width,
                height: 400,
              ),
              Image.asset(
                'assets/img/owner_landing_1.png',
                width: MediaQuery.of(context).size.width,
                height: 400,
              ),
              Image.asset(
                'assets/img/owner_landing_1.png',
                width: MediaQuery.of(context).size.width,
                height: 400,
              ),
            ])
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Text(
            'Find friends all over the world',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.grey.shade700),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BigTextButton(
              onClick: () {
                Get.to(() => const AdminLoginPage());
              },
              text: 'Sign in',
              textColor: Theme.of(context).colorScheme.secondary,
              horizontalMargin: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              backgroudColor: Colors.white,
              borderColor: Theme.of(context).colorScheme.secondary,
              borderWidth: 2,
              cornerRadius: 12,
            ),
            BigTextButton(
              onClick: () {
                Get.to(() => const AdminSignupPage());
              },
              text: 'Create new account?',
              horizontalMargin:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 12),
              cornerRadius: 12,
            )
          ],
        )
      ],
    )));
  }
}
