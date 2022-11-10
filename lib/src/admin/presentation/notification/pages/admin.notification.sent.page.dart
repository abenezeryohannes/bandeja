import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/big.text.button.dart';

class AdminNotificationSentPage extends StatefulWidget {
  const AdminNotificationSentPage({super.key});

  @override
  State<AdminNotificationSentPage> createState() =>
      Admin_NotificationSentPageState();
}

class Admin_NotificationSentPageState extends State<AdminNotificationSentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/waiting.png', height: 160),
                const SizedBox(height: 40),
                Text(
                  'Done!',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'The message has been sent successfully 👏🏼',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.grey.shade700, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BigTextButton(
              onClick: () async {
                Navigator.of(context).maybePop();
              },
              isExpanded: true,
              cornerRadius: 10,
              borderWidth: 2,
              horizontalMargin:
                  const EdgeInsets.only(bottom: 10, left: 40, right: 40),
              borderColor: Theme.of(context).colorScheme.secondary,
              backgroudColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
              textWidget: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const Icon(Icons.cancel, color: Colors.red),
                  // const SizedBox(width: 10),
                  Text("Ok",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary)),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
