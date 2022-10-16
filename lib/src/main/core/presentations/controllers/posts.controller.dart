import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/posts/entities/post.dart';
import '../../../../core/domain/posts/entities/post.group.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/domain/posts/repositories/i.post.group.repository.dart';
import '../../../domain/posts/repositories/i.post.repository.dart';

class PostsController extends GetxController {
  RxBool offers = true.obs;
  RxInt selectedTab = (-1).obs;
  static const adsPageSize = 20;
  Rxn<PostGroupModel> selectedPostGroup = Rxn<PostGroupModel>();

  final PagingController<int, PostModel> adsPagingController =
      PagingController(firstPageKey: 1);

  final itemRepository = getIt<IPostRepository>();
  final postGroupRepository = getIt<IPostGroupRepository>();
  var postsGroup = Rx<WrapperDto<List<PostGroupModel>>>(EmptyState());
  var advertItems = Rx<WrapperDto<List<PostModel>>>(EmptyState());

  @override
  void onInit() {
    super.onInit();
    adsPagingController.addPageRequestListener((pageKey) {
      getPosts(page: pageKey);
    });
    getPostssGroup();
  }

  @override
  void dispose() {
    adsPagingController.dispose();
    super.dispose();
  }

  void getPostssGroup({int? page}) async {
    postsGroup.value = WrapperDto.loadingState();
    selectedTab.value = (-1);
    final result = await postGroupRepository.getPostGroups();
    if (result == null) {
      postsGroup.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) => postsGroup.value = WrapperDto.errorState(failure: l),
          (r) {
        r.insert(0, PostGroupModel().all());
        selectedTab.value = 0;
        postsGroup.value =
            WrapperDto<List<PostGroupModel>>.loadedState(value: r);
      });
    }
  }

  void getPosts({int? page, PostGroupModel? itemGroup, bool? offer}) async {
    advertItems.value = WrapperDto.loadingState();
    final result = await itemRepository.getPosts(
        page: page,
        limit: 25,
        itemGroup: selectedPostGroup.value,
        offers: offer);
    if (result == null) {
      advertItems.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        advertItems.value = WrapperDto.errorState(failure: l);
        adsPagingController.error = l;
      }, (r) async {
        advertItems.value = WrapperDto<List<PostModel>>.loadedState(value: r);
        if (r.length < adsPageSize) {
          adsPagingController.appendLastPage(r);
        } else {
          adsPagingController.appendPage(r, (page ?? 1) + 1);
        }
      });
    }
  }
}
