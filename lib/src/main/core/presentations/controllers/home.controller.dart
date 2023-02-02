import 'package:bandeja/src/core/domain/ads/entities/ad.dart';
import 'package:bandeja/src/core/domain/authentication/entities/user.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/authentication/repositories/i.user.repository.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/domain/padels/entities/padel.group.dart';
import '../../../../core/domain/posts/entities/post.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/domain/padels/repositories/i.padel.group.repository.dart';
import '../../../domain/ads/i.ads.repository.dart';
import '../../../domain/padels/repositories/i.padel.repository.dart';
import '../../../domain/posts/repositories/i.post.repository.dart';

class HomeController extends GetxController {
  final itemGroupRepository = getIt<IPadelGroupRepository>();
  final padelRepository = getIt<IPadelRepository>();
  final advertRepository = getIt<IPostRepository>();
  final adsRepository = getIt<IAdRepository>();
  final userRepository = getIt<IUserRepository>();
  var featuredPedalItems = Rx<WrapperDto<List<PadelModel>>>(EmptyState());
  var itemsGroup = Rx<WrapperDto<List<PadelGroupModel>>>(EmptyState());
  var ads = Rx<WrapperDto<List<AdModel>>>(EmptyState());
  var featuredAds = Rx<WrapperDto<List<PostModel>>>(EmptyState());
  var pickedPadelGroup = Rxn<PadelGroupModel>();
  var itemsGroups = Rx<List<PadelGroupModel>>([]);
  var user = Rxn<UserModel>();
  @override
  void onInit() {
    loadUser();
    getFeaturedPadelItems();
    getAds();
    getItemGroup();
    debounce(pickedPadelGroup, (_) => getFeaturedPadelItems(),
        time: const Duration(microseconds: 500));
    super.onInit();
  }

  getFeaturedPadelItems({int? page}) async {
    featuredPedalItems.value = WrapperDto<List<PadelModel>>.loadingState();
    final result = await padelRepository.getFeaturedPadels(
        padelGroup: pickedPadelGroup.value, location: user.value?.Location);
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
      result.fold((l) => itemsGroup.value = WrapperDto.errorState(failure: l),
          (r) {
        itemsGroups.value = r;
        List<PadelGroupModel> temp = r;
        temp.insert(0, PadelGroupModel(name: "All", icon: "icons/all.png"));
        itemsGroup.value =
            WrapperDto<List<PadelGroupModel>>.loadedState(value: r);
      });
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

  getAds({int? page}) async {
    ads.value = WrapperDto<List<AdModel>>.loadingState();
    final result = await adsRepository.getAds(page: page);
    if (result == null) {
      ads.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) => ads.value = WrapperDto.errorState(failure: l),
          (r) => ads.value = WrapperDto<List<AdModel>>.loadedState(value: r));
    }
  }

  void loadUser() async {
    final result = await userRepository.loadUser();
    if (result == null) {
      return;
    }
    result.fold((_) {}, (r) {
      user.value = r;
    });
  }
}

class PadelItems {}
