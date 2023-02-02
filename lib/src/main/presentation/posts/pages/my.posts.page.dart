import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/domain/posts/entities/post.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/show.error.dart';
import '../controllers/my.posts.controller.dart';
import '../widget/my.post.card.dart';
import '../widget/post.card.dart';
import 'add.post.page.dart';

class MyPostPage extends StatefulWidget {
  const MyPostPage({Key? key}) : super(key: key);

  @override
  State<MyPostPage> createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPage> {
  MyPostController controller = Get.put(MyPostController());

  @override
  void initState() {
    controller = Get.put(MyPostController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<MyPostController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.grey.shade100,
                  floating: true,
                  iconTheme: const IconThemeData(size: 0),
                  leadingWidth: 0,
                  leading: null,
                  collapsedHeight: 70,
                  expandedHeight: 120,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    title: addNewButton(),
                    titlePadding: EdgeInsets.zero,
                    expandedTitleScale: 1,
                    background: _appBar(),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
              child: Column(
                children: [
                  _body(),
                ],
              ),
            )));
  }

  Widget addNewButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
      child: InkWell(
        onTap: () async {
          final x = await Navigator.of(context).push(PageRouteBuilder(
              opaque: false, // set to false
              pageBuilder: (_, __, ___) => const AddPostPage()));
          if (x != null && (x as String) == 'saved') {
            controller.postPagingController.refresh();
          }
        },
        child: Container(
          height: 50,
          width: Get.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          controller.postPagingController.refresh();
        },
        child: PagedGridView<int, PostModel>(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 100 / 120,
            crossAxisSpacing: 5,
            mainAxisSpacing: 0,
            crossAxisCount: 2,
          ),
          pagingController: controller.postPagingController,
          builderDelegate: PagedChildBuilderDelegate<PostModel>(
              noItemsFoundIndicatorBuilder: (context) => Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: ShowError(
                      failure: Failure.noDataFailure(
                          message: 'All of Your Ads will be showen here!'),
                      errorShowType: ErrorShowType.vertical,
                    ),
                  ),
              firstPageErrorIndicatorBuilder: (_) => Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: ShowError(
                      failure: controller.postPagingController.error as Failure,
                      errorShowType: ErrorShowType.vertical,
                    ),
                  ),
              firstPageProgressIndicatorBuilder: (_) => GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 20,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return const PostCard();
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 100 / 120,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 0,
                      crossAxisCount: 2,
                    ),
                  ),
              itemBuilder: (context, post, index) => getCard(post: post)),
        ),
      ),
    );
  }

  Widget getCard({required PostModel post}) {
    return MyPostCard(
      post: post,
      onDelete: (_) {
        Get.dialog(Container(
          margin:
              EdgeInsets.symmetric(horizontal: 40, vertical: Get.height / 3),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are You sure?',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'This will delete this post permanently!',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'No.',
                        style: Theme.of(context).textTheme.bodyText1,
                      )),
                  TextButton(
                      onPressed: () {
                        Get.back();

                        controller.deletePost(post);
                      },
                      child: Text(
                        'Yes, I am sure.',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      )),
                ],
              )
            ],
          ),
        ));
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
          width: double.maxFinite,
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
