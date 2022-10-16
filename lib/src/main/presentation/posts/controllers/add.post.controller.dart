import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/data/posts/dto/post.dto.dart';
import '../../../../core/data/posts/dto/post.image.dto.dart';
import '../../../../core/domain/posts/entities/post.dart';
import '../../../../core/domain/posts/entities/post.group.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/domain/posts/repositories/i.post.group.repository.dart';
import '../../../domain/posts/repositories/i.post.repository.dart';

class AddPostController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<PostDto> postDto =
      Rx<PostDto>(PostDto(id: -1, enabled: true, featured: false));
  Rx<List<PostImageDto>> postImages = Rx<List<PostImageDto>>([]);
  RxInt selectedPostGroup = 0.obs;
  final postGroupRepository = getIt<IPostGroupRepository>();
  final postRepository = getIt<IPostRepository>();
  var postsGroup = Rx<WrapperDto<List<PostGroupModel>>>(EmptyState());

  Rx<WrapperDto<PostModel>> post = Rx<WrapperDto<PostModel>>(
      WrapperDto.loadedState(value: PostModel(postGroupId: -1, userId: -1)));

  @override
  void onInit() {
    getPostssGroup();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void uploadImage(String imagePath) {
    postImages.value.add(PostImageDto(localImg: imagePath));
    postImages.refresh();
  }

  void getPostssGroup({int? page}) async {
    postsGroup.value = WrapperDto.loadingState();
    final result = await postGroupRepository.getPostGroups();
    if (result == null) {
      postsGroup.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) => postsGroup.value = WrapperDto.errorState(failure: l),
          (r) {
        postsGroup.value =
            WrapperDto<List<PostGroupModel>>.loadedState(value: r);
        if (r.isNotEmpty) {
          postDto.value.postGroupId = r.first.id;
        }
      });
    }
  }

  void addPost(BuildContext context) async {
    List<String> images = postImages.value
        .where((element) => element.localImg != null)
        .map((e) => e.localImg!)
        .toList();
    postDto.value.id = -1;
    postDto.value.featured = false;
    postDto.value.enabled = true;
    final result =
        await postRepository.addPost(imagePaths: images, post: postDto.value);

    if (result == null) {}
    result?.fold((l) {
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
      post.value = WrapperDto<PostModel>.errorState(failure: l);
    }, (r) {
      Navigator.maybePop(context, 'saved');
      Get.showSnackbar(const GetSnackBar(
        title: 'Successful',
        message: 'Ad created successfuly!',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 1),
        icon: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ));
    });
  }
}
