// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i12;

import '../../src/admin/data/booking/admin.booking.repostory.dart' as _i44;
import '../../src/admin/data/booking/source/admin.booking.local.data.source.dart'
    as _i17;
import '../../src/admin/data/booking/source/admin.booking.remote.data.source.dart'
    as _i18;
import '../../src/admin/data/notification/admin.notification.repository.dart'
    as _i46;
import '../../src/admin/data/notification/source/admin.notification.local.data.source.dart'
    as _i19;
import '../../src/admin/data/notification/source/admin.notification.remote.data.source.dart'
    as _i20;
import '../../src/admin/data/padel/admin.padel.repository.dart' as _i48;
import '../../src/admin/data/padel/source/admin.padel.local.data.source.dart'
    as _i21;
import '../../src/admin/data/padel/source/admin.padel.remote.data.source.dart'
    as _i22;
import '../../src/admin/data/users/admin.users.repository.dart' as _i50;
import '../../src/admin/data/users/source/admin.users.local.data.source.dart'
    as _i23;
import '../../src/admin/data/users/source/admin.users.remote.data.source.dart'
    as _i24;
import '../../src/admin/domain/booking/i.admin.booking.repository.dart' as _i43;
import '../../src/admin/domain/notification/i.admin.notification.repository.dart'
    as _i45;
import '../../src/admin/domain/padel/i.admin.padel.repository.dart' as _i47;
import '../../src/admin/domain/users/i.admin.users.repository.dart' as _i49;
import '../../src/core/data/authentication/repositories/user.repository.dart'
    as _i31;
import '../../src/core/data/authentication/source/auth.local.data.source.dart'
    as _i25;
import '../../src/core/data/authentication/source/auth.remote.datasource.dart'
    as _i26;
import '../../src/core/data/notification/respositories/notification.repositories.dart'
    as _i54;
import '../../src/core/data/notification/source/notification.local.data.source.dart'
    as _i32;
import '../../src/core/data/notification/source/notification.remote.data.source.dart'
    as _i5;
import '../../src/core/data/padel/repositories/padel.group.repository.dart'
    as _i60;
import '../../src/core/data/padel/sources/padel_group/padel.group.local.data.source.dart'
    as _i35;
import '../../src/core/data/padel/sources/padel_group/padel.group.remote.data.source.dart'
    as _i8;
import '../../src/core/data/posts/post_group/post.group.local.data.source.dart'
    as _i37;
import '../../src/core/data/posts/post_group/post.group.remote.data.source.dart'
    as _i10;
import '../../src/core/data/posts/repositories/post.group.repository.dart'
    as _i64;
import '../../src/core/domain/authentication/repositories/i.user.repository.dart'
    as _i30;
import '../../src/core/domain/notifications/repositories/i.notification.repository.dart'
    as _i53;
import '../../src/core/domain/padels/repositories/i.padel.group.repository.dart'
    as _i59;
import '../../src/core/domain/posts/repositories/i.post.group.repository.dart'
    as _i63;
import '../../src/core/network/network.info.dart' as _i29;
import '../../src/main/data/ads/ads.repository.dart' as _i40;
import '../../src/main/data/ads/source/ads.local.data.source.dart' as _i13;
import '../../src/main/data/ads/source/ads.local.remote.source.dart' as _i14;
import '../../src/main/data/booking/booking.repository.dart' as _i52;
import '../../src/main/data/booking/source/booking.local.data.source.dart'
    as _i27;
import '../../src/main/data/booking/source/booking.remote.data.source.dart'
    as _i28;
import '../../src/main/data/core/repositories/address.repository.dart' as _i42;
import '../../src/main/data/core/source/address.local.data.source.dart' as _i15;
import '../../src/main/data/core/source/address.remote.data.source.dart'
    as _i16;
import '../../src/main/data/padel/repositories/padel.repository.dart' as _i62;
import '../../src/main/data/padel/sources/padel/padel.local.data.source.dart'
    as _i36;
import '../../src/main/data/padel/sources/padel/padel.remote.data.source.dart'
    as _i9;
import '../../src/main/data/posts/repositories/post.repository.dart' as _i66;
import '../../src/main/data/posts/source/post/post.local.datasource.dart'
    as _i38;
import '../../src/main/data/posts/source/post/post.remote.datasource.dart'
    as _i11;
import '../../src/main/domain/ads/i.ads.repository.dart' as _i39;
import '../../src/main/domain/booking/repositories/i.booking.repository.dart'
    as _i51;
import '../../src/main/domain/core/repositories/i.address.repository.dart'
    as _i41;
import '../../src/main/domain/padels/repositories/i.padel.repository.dart'
    as _i61;
import '../../src/main/domain/posts/repositories/i.post.repository.dart'
    as _i65;
import '../../src/owner/data/bookings/owner.booking.repository.dart' as _i56;
import '../../src/owner/data/bookings/source/owner.booking.local.data.source.dart'
    as _i33;
import '../../src/owner/data/bookings/source/owner.booking.remote.data.source.dart'
    as _i6;
import '../../src/owner/data/padels/owner.padel.repository.dart' as _i58;
import '../../src/owner/data/padels/source/owner.padel.local.data.source.dart'
    as _i34;
import '../../src/owner/data/padels/source/owner.padel.remote.data.source.dart'
    as _i7;
import '../../src/owner/domain/booking/i.owner.booking.repository.dart' as _i55;
import '../../src/owner/domain/padels/i.owner.padel.repository.dart' as _i57;
import 'external.injections.dart'
    as _i67; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final externalInjections = _$ExternalInjections();
  gh.lazySingleton<_i3.Client>(() => externalInjections.client);
  gh.lazySingleton<_i4.InternetConnectionChecker>(
      () => externalInjections.connectionChecker);
  gh.singleton<_i5.NotificationRemoteDataSource>(
      _i5.NotificationRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i6.OwnerBookingRemoteDataSource>(
      _i6.OwnerBookingRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i7.OwnerPadelRemoteDataSource>(
      _i7.OwnerPadelRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i8.PadelGroupRemoteDataSource>(
      _i8.PadelGroupRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i9.PadelRemoteDataSource>(
      _i9.PadelRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i10.PostGroupRemoteDataSource>(
      _i10.PostGroupRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i11.PostRemoteDataSource>(
      _i11.PostRemoteDataSource(client: get<_i3.Client>()));
  await gh.singletonAsync<_i12.SharedPreferences>(
    () => externalInjections.prefs,
    preResolve: true,
  );
  gh.singleton<_i13.AdLocalDataSource>(
      _i13.AdLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i14.AdRemoteDataSource>(
      _i14.AdRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i15.AddressLocalDataSource>(
      _i15.AddressLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i16.AddressRemoteDataSource>(
      _i16.AddressRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i17.AdminBookingLocalDataSource>(
      _i17.AdminBookingLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i18.AdminBookingRemoteDataSource>(
      _i18.AdminBookingRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i19.AdminNotificationLocalDataSource>(
      _i19.AdminNotificationLocalDataSource(
          cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i20.AdminNotificationRemoteDataSource>(
      _i20.AdminNotificationRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i21.AdminPadelLocalDataSource>(
      _i21.AdminPadelLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i22.AdminPadelRemoteDataSource>(
      _i22.AdminPadelRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i23.AdminUsersLocalDataSource>(
      _i23.AdminUsersLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i24.AdminUsersRemoteDataSource>(
      _i24.AdminUsersRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i25.AuthLocalDataSource>(
      _i25.AuthLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i26.AuthRemoteDataSource>(
      _i26.AuthRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i27.BookingLocalDataSource>(
      _i27.BookingLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i28.BookingRemoteDataSource>(
      _i28.BookingRemoteDataSource(client: get<_i3.Client>()));
  gh.lazySingleton<_i29.INetworkInfo>(() => _i29.NetworkInfo(
      connectionChecker: get<_i4.InternetConnectionChecker>()));
  gh.singleton<_i30.IUserRepository>(_i31.UserRepository(
    networkInfo: get<_i29.INetworkInfo>(),
    remoteDataSource: get<_i26.AuthRemoteDataSource>(),
    localDataSource: get<_i25.AuthLocalDataSource>(),
  ));
  gh.singleton<_i32.NotificationLocalDataSource>(
      _i32.NotificationLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i33.OwnerBookingLocalDataSource>(
      _i33.OwnerBookingLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i34.OwnerPadelLocalDataSource>(
      _i34.OwnerPadelLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i35.PadelGroupLocalDataSource>(
      _i35.PadelGroupLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i36.PadelLocalDataSource>(
      _i36.PadelLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i37.PostGroupLocalDataSource>(
      _i37.PostGroupLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i38.PostLocalDataSource>(
      _i38.PostLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i39.IAdRepository>(_i40.AdRepository(
    networkInfo: get<_i29.INetworkInfo>(),
    localDataSource: get<_i13.AdLocalDataSource>(),
    remoteDataSource: get<_i14.AdRemoteDataSource>(),
  ));
  gh.singleton<_i41.IAddressRepository>(_i42.AddressRepository(
    networkInfo: get<_i29.INetworkInfo>(),
    remoteDataSource: get<_i16.AddressRemoteDataSource>(),
    localDataSource: get<_i15.AddressLocalDataSource>(),
  ));
  gh.singleton<_i43.IAdminBookingRepository>(_i44.AdminBookingRepository(
    networkInfo: get<_i29.INetworkInfo>(),
    remoteDataSource: get<_i18.AdminBookingRemoteDataSource>(),
    localDataSource: get<_i17.AdminBookingLocalDataSource>(),
  ));
  gh.singleton<_i45.IAdminNotificationRepository>(
      _i46.AdminNotificationRepository(
    networkInfo: get<_i29.INetworkInfo>(),
    remoteDataSource: get<_i20.AdminNotificationRemoteDataSource>(),
    localDataSource: get<_i19.AdminNotificationLocalDataSource>(),
  ));
  gh.singleton<_i47.IAdminPadelRepository>(_i48.AdminPadelsRepository(
    networkInfo: get<_i29.INetworkInfo>(),
    remoteDataSource: get<_i22.AdminPadelRemoteDataSource>(),
    localDataSource: get<_i21.AdminPadelLocalDataSource>(),
  ));
  gh.singleton<_i49.IAdminUsersRepository>(_i50.AdminUsersRepository(
    networkInfo: get<_i29.INetworkInfo>(),
    remoteDataSource: get<_i24.AdminUsersRemoteDataSource>(),
    localDataSource: get<_i23.AdminUsersLocalDataSource>(),
  ));
  gh.singleton<_i51.IBookingRepository>(_i52.BookingRepository(
    networkInfo: get<_i29.INetworkInfo>(),
    localDataSource: get<_i27.BookingLocalDataSource>(),
    remoteDataSource: get<_i28.BookingRemoteDataSource>(),
  ));
  gh.singleton<_i53.INotificationRepository>(_i54.NotificationRepsotory(
    networkInfo: get<_i29.INetworkInfo>(),
    localDataSource: get<_i32.NotificationLocalDataSource>(),
    remoteDataSource: get<_i5.NotificationRemoteDataSource>(),
  ));
  gh.singleton<_i55.IOwnerBookingRepository>(_i56.OwnerBookingRepository(
    get<_i29.INetworkInfo>(),
    get<_i33.OwnerBookingLocalDataSource>(),
    get<_i6.OwnerBookingRemoteDataSource>(),
  ));
  gh.singleton<_i57.IOwnerPadelRepository>(_i58.OwnerPadelRepository(
    get<_i34.OwnerPadelLocalDataSource>(),
    get<_i7.OwnerPadelRemoteDataSource>(),
    get<_i29.INetworkInfo>(),
  ));
  gh.singleton<_i59.IPadelGroupRepository>(_i60.PadelGroupRepository(
    networkInfo: get<_i29.INetworkInfo>(),
    localDataSource: get<_i35.PadelGroupLocalDataSource>(),
    remoteDataSource: get<_i8.PadelGroupRemoteDataSource>(),
  ));
  gh.singleton<_i61.IPadelRepository>(_i62.PadelRepository(
    networkInfo: get<_i29.INetworkInfo>(),
    remoteDataSource: get<_i9.PadelRemoteDataSource>(),
    localDataSource: get<_i36.PadelLocalDataSource>(),
  ));
  gh.singleton<_i63.IPostGroupRepository>(_i64.PostGroupRepository(
    networkInfo: get<_i29.INetworkInfo>(),
    localDataSource: get<_i37.PostGroupLocalDataSource>(),
    remoteDataSource: get<_i10.PostGroupRemoteDataSource>(),
  ));
  gh.singleton<_i65.IPostRepository>(_i66.PostRepository(
    networkInfo: get<_i29.INetworkInfo>(),
    remoteDataSource: get<_i11.PostRemoteDataSource>(),
    localDataSource: get<_i38.PostLocalDataSource>(),
  ));
  return get;
}

class _$ExternalInjections extends _i67.ExternalInjections {}
