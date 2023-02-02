import 'package:bandeja/src/core/presentation/widgets/big.text.button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/domain/posts/entities/post.group.dart';
import '../../../../core/presentation/widgets/show.error.dart';
import '../../../../core/presentation/widgets/tab.bar.dart';
import '../../../../core/presentation/widgets/text.input.form.dart';
import '../controllers/add.post.controller.dart';
import '../widget/post.images.form.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final controller = Get.put(AddPostController());
  final descFocus = FocusNode();
  final priceFocus = FocusNode();
  final whatsAppFocus = FocusNode();
  final callFocus = FocusNode();
  @override
  void dispose() {
    Get.delete<AddPostController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.grey.shade50,
      floatingActionButton: (descFocus.hasFocus ||
                  priceFocus.hasFocus ||
                  whatsAppFocus.hasFocus ||
                  callFocus.hasFocus) &&
              MediaQuery.of(context).viewInsets.bottom > 10
          ? FloatingActionButton(
              backgroundColor: Colors.grey.shade100,
              mini: true,
              onPressed: () {
                if (descFocus.hasFocus) {
                  descFocus.nextFocus();
                } else if (priceFocus.hasFocus) {
                  priceFocus.nextFocus();
                } else if (whatsAppFocus.hasFocus) {
                  whatsAppFocus.nextFocus();
                } else if (callFocus.hasFocus) {
                  callFocus.nextFocus();
                }
              },
              child: const Icon(Icons.keyboard_arrow_down),
            )
          : null,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(() => Center(
                            child: PostImagesFrom(
                          onLoadingChanged: (isLoading) {
                            controller.isLoading.value = isLoading;
                          },
                          validator: () => controller.validated.value,
                          placeholder: 'assets/img/add_img.png',
                          postImages: controller.postImages.value,
                          uploadImage: (String imgPath) {
                            controller.uploadImage(imgPath);
                          },
                        ))),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextInputForm(
                          label: 'Description',
                          minLines: 4,
                          focusNode: descFocus,
                          maxLines: 5,
                          placeholder: 'Write the Ads Title',
                          elevation: 0,
                          radius: 12,
                          validator: (value) =>
                              controller.validateNoEmpty(value),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          initialValue: controller.postDto.value.desc,
                          onChanged: (change) {
                            controller.postDto.value.desc = change;
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextInputForm(
                          label: 'Booking Price',
                          placeholder: '00',
                          error: null,
                          focusNode: priceFocus,
                          elevation: 0,
                          keybardType: TextInputType.number,
                          radius: 12,
                          suffixText: 'KD',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          initialValue: controller.postDto.value.price,
                          onChanged: (change) {
                            controller.postDto.value.price = change;
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2 - 30,
                              child: TextInputForm(
                                  label: 'Whatsapp',
                                  placeholder: 'Add your number',
                                  focusNode: whatsAppFocus,
                                  validator: (value) =>
                                      controller.phoneValidation(value),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  elevation: 0,
                                  radius: 12,
                                  keybardType: TextInputType.phone,
                                  initialValue:
                                      controller.postDto.value.whatsApp ?? '',
                                  onChanged: (change) {
                                    controller.postDto.value.whatsApp = change;
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 30,
                          child: TextInputForm(
                              label: 'Call',
                              placeholder: 'Add your number',
                              focusNode: callFocus,
                              validator: (value) =>
                                  controller.phoneValidation(value),
                              elevation: 0,
                              radius: 12,
                              keybardType: TextInputType.phone,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              initialValue:
                                  controller.postDto.value.phoneNumber ?? '',
                              onChanged: (change) {
                                controller.postDto.value.phoneNumber = change;
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Ads Category',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    _postCategory(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Type to ads',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    _postType()
                  ],
                ),
              ),
            ),
            if (MediaQuery.of(context).viewInsets.bottom < 10)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border(
                        top:
                            BorderSide(width: 0.5, color: Colors.grey.shade400),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, bottom: 10, top: 20),
                    child: Obx(
                      () => BigTextButton(
                        onClick: () {
                          controller.addPost(context);
                        },
                        padding: const EdgeInsets.only(top: 14, bottom: 14),
                        isLoading: controller.isLoading.value,
                        textWidget: const Text('Save'),
                      ),
                    )),
              )
          ],
        ),
      ),
    );
  }

  Widget _postCategory() {
    return Obx(() => controller.postsGroup.value.when(emptyState: () {
          return const SizedBox();
        }, errorState: (failure) {
          return Column(
            children: [
              Expanded(child: Center(child: ShowError(failure: failure))),
            ],
          );
        }, loadedState: (value) {
          return Container(
              height: 60,
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 10),
              child: _tabs(value));
        }, loadingState: (_) {
          return Container(
              height: 60,
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 10),
              child: _tabs([null, null, null, null, null]));
        }));
  }

  Widget _postType() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
      height: 60,
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              setState(() {
                controller.postDto.value.offer = false;
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: !controller.postDto.value.offer ? 0 : 1.2),
                  color: !controller.postDto.value.offer
                      ? Colors.red
                      : Colors.transparent),
              child: Text('Wanted',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: controller.postDto.value.offer
                          ? FontWeight.bold
                          : FontWeight.w400,
                      color: !controller.postDto.value.offer
                          ? Colors.white
                          : Theme.of(context).colorScheme.shadow)),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              setState(() {
                controller.postDto.value.offer = true;
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: controller.postDto.value.offer ? 0 : 1.2),
                  color: controller.postDto.value.offer
                      ? const Color(0xFF109825)
                      : Colors.transparent),
              child: Text('Offered',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: controller.postDto.value.offer
                          ? FontWeight.bold
                          : FontWeight.w400,
                      color: controller.postDto.value.offer
                          ? Colors.white
                          : Theme.of(context).colorScheme.shadow)),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text("New Ads", style: Theme.of(context).textTheme.titleMedium),
      centerTitle: true,
      leadingWidth: 56,
      backgroundColor: Colors.grey.shade50,
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

  Widget _tabs(List<PostGroupModel?> postGroups) {
    return CircularTabBar(
        tabs: postGroups
            .map((e) => CircularTab(text: e?.name, radius: 50))
            .toList(),
        onItemClick: (index) {
          if (postGroups[index] == null) return;
          controller.selectedPostGroup.value = index;
          controller.postDto.value.postGroupId = postGroups[index]!.id;
        },
        value: controller.selectedPostGroup.value);
  }
}
