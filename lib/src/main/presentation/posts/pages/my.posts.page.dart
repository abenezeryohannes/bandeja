import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/domain/posts/entities/post.dart';
import '../controllers/my.posts.controller.dart';
import '../widget/my.post.card.dart';
import 'add.post.page.dart';

class MyPostPage extends StatefulWidget {
  const MyPostPage({Key? key}) : super(key: key);

  @override
  State<MyPostPage> createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPage> {
  final controller = Get.put(MyPostController());

  @override
  void dispose() {
    Get.delete<MyPostController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        backgroundColor: Colors.grey.shade50,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false, // set to false
                        pageBuilder: (_, __, ___) => const AddPostPage()));
                  },
                  child: Container(
                    height: 50,
                    width: Get.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("Add new Ads",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: PagedGridView<int, PostModel>(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 100 / 120,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 0,
                      crossAxisCount: 2,
                    ),
                    pagingController: controller.postPagingController,
                    builderDelegate: PagedChildBuilderDelegate<PostModel>(
                        itemBuilder: (context, post, index) => getCard(
                              post: post,
                            )),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget getCard({required PostModel post}) {
    return MyPostCard(
      post: post,
      onDelete: () {
        controller.deletePost(post);
      },
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text("My Ads", style: Theme.of(context).textTheme.titleMedium),
      centerTitle: true,
      leadingWidth: 56,
      backgroundColor: Colors.grey.shade50,
      elevation: 0,
      leading: Container(
          margin: const EdgeInsets.only(top: 14, bottom: 14, left: 25),
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
