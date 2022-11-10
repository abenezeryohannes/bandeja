import 'package:bandeja/src/owner/core/presentation/pages/owner.main.page.dart';
import 'package:bandeja/src/owner/presentation/authentication/pages/owner.login.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class OwnerWaitingPage extends StatefulWidget {
  const OwnerWaitingPage({Key? key}) : super(key: key);

  @override
  State<OwnerWaitingPage> createState() => _OwnerWaitingPageState();
}

class _OwnerWaitingPageState extends State<OwnerWaitingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: () => Get.to(() => const OwnerMainPage()),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'We will contact you shortly to activate your business account.!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.grey.shade400, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
