import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/posts/entities/post.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/posts/repositories/i.post.repository.dart';

class MyPostController extends GetxController {
  IPostRepository postRepository = getIt<IPostRepository>();
  Rx<WrapperDto<List<PostModel>>> myPosts =
      Rx<WrapperDto<List<PostModel>>>(EmptyState());
  int postPageSize = 25;
  final PagingController<int, PostModel> postPagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() {
    postPagingController.addPageRequestListener((pageKey) {
      loadMyPosts(page: pageKey);
    });
    super.onInit();
  }

  loadMyPosts({int? page}) async {
    myPosts.value = WrapperDto.loadingState();
    final result =
        await postRepository.getMyPosts(page: page, limit: postPageSize);
    if (result == null) {
      myPosts.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        myPosts.value = WrapperDto.errorState(failure: l);
        postPagingController.error = l;
      }, (r) {
        myPosts.value = WrapperDto<List<PostModel>>.loadedState(value: r);
        if (r.length < postPageSize) {
          postPagingController.appendLastPage(r);
        } else {
          postPagingController.appendPage(r, (page ?? 0) + 1);
        }
      });
    }
  }

  void deletePost(PostModel post) async {
    final result = await postRepository.deletePost(id: post.id);
    if (result == null) {
      myPosts.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        Get.showSnackbar(GetSnackBar(
          title: 'Error',
          message: l.message,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
        ));
      }, (r) {
        postPagingController.refresh();
      });
    }
  }
}
