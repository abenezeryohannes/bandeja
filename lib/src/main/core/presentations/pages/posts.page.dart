import 'package:feekpadel/src/core/widgets/tab.bar.dart';
import 'package:feekpadel/src/core/widgets/toggle.form.dart';
import 'package:feekpadel/src/main/core/presentations/controllers/posts.controller.dart';
import 'package:feekpadel/src/main/domain/posts/entities/post.dart';
import 'package:feekpadel/src/main/domain/posts/entities/post.group.dart';
import 'package:feekpadel/src/main/presentation/posts/pages/add.post.page.dart';
import 'package:feekpadel/src/main/presentation/posts/pages/my.posts.page.dart';
import 'package:feekpadel/src/main/presentation/posts/widget/post.card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/widgets/show.error.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);
  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final c = Get.put(PostsController());

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
                  collapsedHeight: 60,
                  expandedHeight: 100,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    title: _tabBar(context),
                    titlePadding: EdgeInsets.zero,
                    expandedTitleScale: 1,
                    background: _appBar(),
                  ),
                ),
              ];
            },
            body: _body(context)));
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'What you looking for',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  Widget _tabBar(BuildContext context) {
    return Obx(() => c.postsGroup.value.when(emptyState: () {
          return const SizedBox();
        }, errorState: (failure) {
          return Column(
            children: [
              Expanded(child: Center(child: ShowError(failure: failure))),
            ],
          );
        }, loadedState: (value) {
          return Container(
              color: Colors.white,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: _tabs(context, value),
              ));
        }, loadingState: (_) {
          return const CircularProgressIndicator();
        }));
  }

  Widget _tabs(BuildContext context, List<PostGroupModel> postGroups) {
    return CircularTabBar(
        tabs: postGroups.map((e) => CircularTab(text: e.name)).toList(),
        onItemClick: (index) {
          c.selectedTab.value = index;
        },
        value: c.selectedTab.value);
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 10, left: 16.0, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Newest',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Card(
                color: Theme.of(context).colorScheme.secondary,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false, // set to false
                        pageBuilder: (_, __, ___) => const MyPostPage()));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: PagedGridView<int, PostModel>(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 100 / 120,
                crossAxisSpacing: 5,
                mainAxisSpacing: 0,
                crossAxisCount: 2,
              ),
              pagingController: c.adsPagingController,
              builderDelegate: PagedChildBuilderDelegate<PostModel>(
                  itemBuilder: (context, post, index) => PostCard(
                        post: post,
                      )),
            ),
          ),
        ),
      ],
    );
  }
}
