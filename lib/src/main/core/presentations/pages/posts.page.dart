import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/domain/posts/entities/post.dart';
import '../../../../core/domain/posts/entities/post.group.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/presentation/widgets/show.error.dart';
import '../../../../core/presentation/widgets/tab.bar.dart';
import '../../../presentation/posts/pages/my.posts.page.dart';
import '../../../presentation/posts/widget/post.card.dart';
import '../controllers/posts.controller.dart';

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
                  floating: true,
                  iconTheme: const IconThemeData(size: 0),
                  leadingWidth: 0,
                  elevation: 1,
                  leading: null,
                  backgroundColor: Colors.transparent,
                  collapsedHeight: 61,
                  expandedHeight: 101,
                  forceElevated: true,
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
        'What are you looking for?',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      centerTitle: true,
      backgroundColor: Colors.grey.shade50,
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
              color: Colors.grey.shade50,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: _tabs(context, value),
              ));
        }, loadingState: (_) {
          return Container(
              color: Colors.grey.shade50,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child:
                    _tabs(context, [null, null, null, null, null, null, null]),
              ));
        }));
  }

  Widget _tabs(BuildContext context, List<PostGroupModel?> postGroups) {
    return CircularTabBar(
        tabs: postGroups.map((e) => CircularTab(text: e?.name)).toList(),
        onItemClick: (index) {
          c.selectedTab.value = index;
          c.selectedPostGroup.value = index == 0 ? null : postGroups[index];
          c.adsPagingController.refresh();
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
            child: RefreshIndicator(
              onRefresh: () async => c.adsPagingController.refresh(),
              child: PagedGridView<int, PostModel>(
                padding: const EdgeInsets.only(bottom: 100),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 100 / 120,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 0,
                  crossAxisCount: 2,
                ),
                pagingController: c.adsPagingController,
                builderDelegate: PagedChildBuilderDelegate<PostModel>(
                    noItemsFoundIndicatorBuilder: (context) => Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: ShowError(
                            failure: Failure.noDataFailure(
                                message: 'No Ads here yet!'),
                            errorShowType: ErrorShowType.vertical,
                          ),
                        ),
                    firstPageErrorIndicatorBuilder: (_) => Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: ShowError(
                            failure: c.adsPagingController.error as Failure,
                            errorShowType: ErrorShowType.vertical,
                          ),
                        ),
                    firstPageProgressIndicatorBuilder: (_) => GridView.builder(
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
                    itemBuilder: (context, post, index) => PostCard(
                          post: post,
                        )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
