import 'package:bandeja/src/main/presentation/profile/controllers/contact.us.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/widgets/text.input.form.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final controller = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Contact Us",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "No page design for this yet !",
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.red),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   // width: MediaQuery.of(context).size.width / 2 - 30,
          //   child: Material(
          //     elevation: 1,
          //     shape: const RoundedRectangleBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(12))),
          //     child: TextInputForm(
          //         label: 'Whatsapp',
          //         placeholder: 'Add your number',
          //         error: null,
          //         floatingLabelBehavior: FloatingLabelBehavior.always,
          //         initialValue: controller.postDto.value.whatsApp ?? '',
          //         onChanged: (change) {
          //           controller.user.value. = change;
          //         }),
          //   ),
          // ),
          // SizedBox(
          //   // width: MediaQuery.of(context).size.width / 2 - 30,
          //   child: Material(
          //     elevation: 1,
          //     shape: const RoundedRectangleBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(12))),
          //     child: TextInputForm(
          //         label: 'Call',
          //         placeholder: 'Add your number',
          //         error: null,
          //         floatingLabelBehavior: FloatingLabelBehavior.always,
          //         initialValue: controller.postDto.value.phoneNumber ?? '',
          //         onChanged: (change) {
          //           controller.postDto.value.phoneNumber = change;
          //         }),
          //   ),
          // ),
        ]),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leadingWidth: 56,
      elevation: 0,
      leading: Container(
          margin: const EdgeInsets.only(top: 14, bottom: 14, left: 20),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 1, color: Colors.grey.shade600)),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.chevron_left,
              size: 24,
              color: Colors.black,
            ),
          )),
    );
  }
}
