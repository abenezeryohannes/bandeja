import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/domain/padels/entities/padel.group.dart';
import '../../../../core/domain/posts/entities/post.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/domain/padels/repositories/i.padel.group.repository.dart';
import '../../../domain/padels/repositories/i.padel.repository.dart';
import '../../../domain/posts/repositories/i.post.repository.dart';

class HomeController extends GetxController {
  final itemGroupRepository = getIt<IPadelGroupRepository>();
  final padelRepository = getIt<IPadelRepository>();
  final advertRepository = getIt<IPostRepository>();
  var featuredPedalItems = Rx<WrapperDto<List<PadelModel>>>(EmptyState());
  var itemsGroup = Rx<WrapperDto<List<PadelGroupModel>>>(EmptyState());
  var featuredAds = Rx<WrapperDto<List<PostModel>>>(EmptyState());

  @override
  void onInit() {
    getFeaturedPadelItems();
    getFeaturedAds();
    getItemGroup();
    super.onInit();
  }

  getFeaturedPadelItems({int? page}) async {
    featuredPedalItems.value = WrapperDto<List<PadelModel>>.loadingState();
    final result = await padelRepository.getFeaturedPadels();
    if (result == null) {
      featuredPedalItems.value =
          WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold(
          (l) => featuredPedalItems.value = WrapperDto.errorState(failure: l),
          (r) => featuredPedalItems.value =
              WrapperDto<List<PadelModel>>.loadedState(value: r));
    }
  }

  getItemGroup() async {
    itemsGroup.value = WrapperDto<List<PadelGroupModel>>.loadingState();
    final result = await itemGroupRepository.getPadelGroups();
    if (result == null) {
      itemsGroup.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold(
          (l) => itemsGroup.value = WrapperDto.errorState(failure: l),
          (r) => itemsGroup.value =
              WrapperDto<List<PadelGroupModel>>.loadedState(value: r));
    }
  }

  getFeaturedAds({int? page}) async {
    featuredAds.value = WrapperDto<List<PostModel>>.loadingState();

    final result = await advertRepository.getFeaturedPosts(
        page: page, location: null, address: null);
    if (result == null) {
      featuredAds.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold(
          (l) => featuredAds.value = WrapperDto.errorState(failure: l),
          (r) => featuredAds.value =
              WrapperDto<List<PostModel>>.loadedState(value: r));
    }
  }
}

class PadelItems {}
