import 'package:bandeja/src/admin/core/presentations/pages/admin.main.page.dart';
import 'package:bandeja/src/admin/presentation/authentication/controllers/waiting.page.controller.dart';
import 'package:bandeja/src/main/core/presentations/pages/main.page.dart';
import 'package:bandeja/src/owner/core/presentation/pages/owner.main.page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../flavors.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({Key? key}) : super(key: key);

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  final controller = Get.put(WaitingPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  switch (FF.appFlavor) {
                    case Flavor.admin:
                      Get.off(const AdminMainPage());
                      break;
                    case Flavor.owner:
                      Get.off(const OwnerMainPage());
                      break;
                    default:
                      Get.off(const MainPage());
                      break;
                  }
                },
                child: Image.asset('assets/icons/waiting.png', height: 160)),
            const SizedBox(height: 40),
            Text(
              'Done!',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.black),
            ),
            const SizedBox(height: 20),
            Obx(() => controller.loading.value
                ? Text(
                    'Checking for updates ...',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      'We will contact you shortly to activate your business account.!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
