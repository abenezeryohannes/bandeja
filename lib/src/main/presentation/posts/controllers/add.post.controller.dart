import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
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
  RxnString validated = RxnString();
  Rx<PostDto> postDto =
      Rx<PostDto>(PostDto(id: -1, enabled: true, featured: false));
  Rx<List<PostImageDto>> postImages = Rx<List<PostImageDto>>([]);
  RxInt selectedPostGroup = 0.obs;
  final postGroupRepository = getIt<IPostGroupRepository>();
  final postRepository = getIt<IPostRepository>();
  var postsGroup = Rx<WrapperDto<List<PostGroupModel>>>(EmptyState());
  final formKey = GlobalKey<FormState>();

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
    validated.value = postImages.value.isNotEmpty ? null : "Required Field!";
    if ((formKey.currentState != null && !formKey.currentState!.validate()) ||
        postImages.value.isEmpty) {
      postImages.refresh();
      return;
    }
    List<String> images = postImages.value
        .where((element) => element.localImg != null)
        .map((e) => e.localImg!)
        .toList();
    postDto.value.id = -1;
    postDto.value.featured = false;
    postDto.value.enabled = true;

    postDto.value.phoneNumber =
        ('+965${postDto.value.phoneNumber?.substring((postDto.value.phoneNumber?.length ?? 0) - 8, postDto.value.phoneNumber?.length)}');

    postDto.value.whatsApp =
        ('+965${postDto.value.whatsApp?.substring((postDto.value.whatsApp?.length ?? 0) - 8, postDto.value.whatsApp?.length)}');

    final result =
        await postRepository.addPost(imagePaths: images, post: postDto.value);

    if (result == null) {
      AppSnackBar.failure(failure: UnExpectedFailure());
      return;
    }
    result.fold((l) {
      AppSnackBar.failure(failure: l);
      post.value = WrapperDto<PostModel>.errorState(failure: l);
    }, (r) {
      Navigator.maybePop(context, 'saved');
      AppSnackBar.success(message: 'New Ad have added.');
    });
  }

  String? phoneValidation(String? input) {
    if (input == null) return null;
    if (input.length < 8) return 'Not valid phone number!';

    String? validation = GetUtils.isPhoneNumber(
            ('+965${input.substring(input.length - 8, input.length)}'))
        ? null
        : 'Not valid phone number!';
    return validation;
  }

  String? validateNoEmpty(String? input) {
    if (input == null || input.trim().isEmpty) return 'Required Field!';
    return null;
  }

  String? validateMedia(String? input) {
    if (input == null || input.trim().isEmpty) return 'Required Field!';
    return null;
  }
}
