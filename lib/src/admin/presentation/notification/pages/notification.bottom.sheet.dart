import 'package:bandeja/src/core/domain/authentication/entities/user.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/core/presentation/widgets/big.text.button.dart';
import 'package:bandeja/src/core/presentation/widgets/drop.down.form.dart';
import 'package:bandeja/src/core/presentation/widgets/show.error.dart';
import 'package:bandeja/src/core/presentation/widgets/text.input.form.dart';
import 'package:bandeja/src/core/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/widgets/suggest.text.form.dart';
import '../controllers/notification.bottom.sheet.controller.dart';

class NotificationBottomSheet extends StatefulWidget {
  const NotificationBottomSheet({Key? key}) : super(key: key);

  @override
  State<NotificationBottomSheet> createState() =>
      _NotificationBottomSheetState();
}

class _NotificationBottomSheetState extends State<NotificationBottomSheet> {
  final controller = Get.put(NotificationBottomSheetController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Theme.of(context).scaffoldBackgroundColor),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 0),
                      color: Theme.of(context).dividerColor,
                      width: 60,
                      height: 6,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Send Notification",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        'Send Notification for the the courts owner or the app users.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Material(
                        elevation: 1,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Autocomplete<UserModel>(
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted) {
                            return TextFormField(
                              controller: textEditingController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'For ?',
                                hintText: 'The message for who ?',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.bold),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3,
                                        color: Colors.grey.shade300),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.grey.shade400),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3,
                                        color: Colors.grey.shade300),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3,
                                        color: Colors.grey.shade300),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                              ),
                              focusNode: focusNode,
                              onFieldSubmitted: (String value) {
                                onFieldSubmitted();
                              },
                            );
                          },
                          displayStringForOption: ((option) => option.fullName),
                          initialValue: TextEditingValue(
                              text: controller.user.value?.fullName ?? ''),
                          optionsBuilder:
                              (TextEditingValue textEditingValue) async {
                            if (textEditingValue.text == '') {
                              return const Iterable<UserModel>.empty();
                            }
                            return ((await controller
                                        .searchUsers(textEditingValue.text)) ??
                                    [])
                                .where((UserModel option) {
                              return option.toString().contains(
                                  textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (UserModel selection) {
                            controller.user.value = selection;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(() => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: TextInputForm(
                              label: 'Message title',
                              placeholder: 'Write the Message title here.',
                              error: null,
                              elevation: 1,
                              radius: 12,
                              validator: (_) => Util.validateNoEmpty(
                                  controller.notificationDto.value.title),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              initialValue:
                                  (controller.notificationDto.value.title),
                              onChanged: (change) {
                                controller.notificationDto.value.title = change;
                              }),
                        )),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    Obx(() => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: TextInputForm(
                              label: 'Message body',
                              placeholder: 'Write the message body here.',
                              error: null,
                              elevation: 1,
                              radius: 12,
                              maxLines: 6,
                              minLines: 4,
                              validator: (_) => Util.validateNoEmpty(
                                  controller.notificationDto.value.desc),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              initialValue:
                                  (controller.notificationDto.value.desc),
                              onChanged: (change) {
                                controller.notificationDto.value.desc = change;
                              }),
                        )),
                    const SizedBox(height: 20),
                    // if (MediaQuery.of(context).viewInsets.bottom == 0)
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30, bottom: 10),
                        child: Obx(() => BigTextButton(
                              onClick: () {
                                controller.sendNotification();
                              },
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              isLoading: controller.loading.value,
                              text: 'Send',
                            )))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
