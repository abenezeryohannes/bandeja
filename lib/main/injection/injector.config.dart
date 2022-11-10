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

import '../../src/admin/data/booking/admin.booking.repostory.dart' as _i40;
import '../../src/admin/data/booking/source/admin.booking.local.data.source.dart'
    as _i15;
import '../../src/admin/data/booking/source/admin.booking.remote.data.source.dart'
    as _i16;
import '../../src/admin/data/notification/admin.notification.repository.dart'
    as _i42;
import '../../src/admin/data/notification/source/admin.notification.local.data.source.dart'
    as _i17;
import '../../src/admin/data/notification/source/admin.notification.remote.data.source.dart'
    as _i18;
import '../../src/admin/data/padel/admin.padel.repository.dart' as _i44;
import '../../src/admin/data/padel/source/admin.padel.local.data.source.dart'
    as _i19;
import '../../src/admin/data/padel/source/admin.padel.remote.data.source.dart'
    as _i20;
import '../../src/admin/data/users/admin.users.repository.dart' as _i46;
import '../../src/admin/data/users/source/admin.users.local.data.source.dart'
    as _i21;
import '../../src/admin/data/users/source/admin.users.remote.data.source.dart'
    as _i22;
import '../../src/admin/domain/booking/i.admin.booking.repository.dart' as _i39;
import '../../src/admin/domain/notification/i.admin.notification.repository.dart'
    as _i41;
import '../../src/admin/domain/padel/i.admin.padel.repository.dart' as _i43;
import '../../src/admin/domain/users/i.admin.users.repository.dart' as _i45;
import '../../src/core/data/authentication/repositories/user.repository.dart'
    as _i29;
import '../../src/core/data/authentication/source/auth.local.data.source.dart'
    as _i23;
import '../../src/core/data/authentication/source/auth.remote.datasource.dart'
    as _i24;
import '../../src/core/data/notification/respositories/notification.repositories.dart'
    as _i50;
import '../../src/core/data/notification/source/notification.local.data.source.dart'
    as _i30;
import '../../src/core/data/notification/source/notification.remote.data.source.dart'
    as _i5;
import '../../src/core/data/padel/repositories/padel.group.repository.dart'
    as _i56;
import '../../src/core/data/padel/sources/padel_group/padel.group.local.data.source.dart'
    as _i33;
import '../../src/core/data/padel/sources/padel_group/padel.group.remote.data.source.dart'
    as _i8;
import '../../src/core/data/posts/post_group/post.group.local.data.source.dart'
    as _i35;
import '../../src/core/data/posts/post_group/post.group.remote.data.source.dart'
    as _i10;
import '../../src/core/data/posts/repositories/post.group.repository.dart'
    as _i60;
import '../../src/core/domain/authentication/repositories/i.user.repository.dart'
    as _i28;
import '../../src/core/domain/notifications/repositories/i.notification.repository.dart'
    as _i49;
import '../../src/core/domain/padels/repositories/i.padel.group.repository.dart'
    as _i55;
import '../../src/core/domain/posts/repositories/i.post.group.repository.dart'
    as _i59;
import '../../src/core/network/network.info.dart' as _i27;
import '../../src/main/data/booking/booking.repository.dart' as _i48;
import '../../src/main/data/booking/source/booking.local.data.source.dart'
    as _i25;
import '../../src/main/data/booking/source/booking.remote.data.source.dart'
    as _i26;
import '../../src/main/data/core/repositories/address.repository.dart' as _i38;
import '../../src/main/data/core/source/address.local.data.source.dart' as _i13;
import '../../src/main/data/core/source/address.remote.data.source.dart'
    as _i14;
import '../../src/main/data/padel/repositories/padel.repository.dart' as _i58;
import '../../src/main/data/padel/sources/padel/padel.local.data.source.dart'
    as _i34;
import '../../src/main/data/padel/sources/padel/padel.remote.data.source.dart'
    as _i9;
import '../../src/main/data/posts/repositories/post.repository.dart' as _i62;
import '../../src/main/data/posts/source/post/post.local.datasource.dart'
    as _i36;
import '../../src/main/data/posts/source/post/post.remote.datasource.dart'
    as _i11;
import '../../src/main/domain/booking/repositories/i.booking.repository.dart'
    as _i47;
import '../../src/main/domain/core/repositories/i.address.repository.dart'
    as _i37;
import '../../src/main/domain/padels/repositories/i.padel.repository.dart'
    as _i57;
import '../../src/main/domain/posts/repositories/i.post.repository.dart'
    as _i61;
import '../../src/owner/data/bookings/owner.booking.repository.dart' as _i52;
import '../../src/owner/data/bookings/source/owner.booking.local.data.source.dart'
    as _i31;
import '../../src/owner/data/bookings/source/owner.booking.remote.data.source.dart'
    as _i6;
import '../../src/owner/data/padels/owner.padel.repository.dart' as _i54;
import '../../src/owner/data/padels/source/owner.padel.local.data.source.dart'
    as _i32;
import '../../src/owner/data/padels/source/owner.padel.remote.data.source.dart'
    as _i7;
import '../../src/owner/domain/booking/i.owner.booking.repository.dart' as _i51;
import '../../src/owner/domain/padels/i.owner.padel.repository.dart' as _i53;
import 'external.injections.dart'
    as _i63; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i13.AddressLocalDataSource>(
      _i13.AddressLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i14.AddressRemoteDataSource>(
      _i14.AddressRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i15.AdminBookingLocalDataSource>(
      _i15.AdminBookingLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i16.AdminBookingRemoteDataSource>(
      _i16.AdminBookingRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i17.AdminNotificationLocalDataSource>(
      _i17.AdminNotificationLocalDataSource(
          cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i18.AdminNotificationRemoteDataSource>(
      _i18.AdminNotificationRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i19.AdminPadelLocalDataSource>(
      _i19.AdminPadelLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i20.AdminPadelRemoteDataSource>(
      _i20.AdminPadelRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i21.AdminUsersLocalDataSource>(
      _i21.AdminUsersLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i22.AdminUsersRemoteDataSource>(
      _i22.AdminUsersRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i23.AuthLocalDataSource>(
      _i23.AuthLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i24.AuthRemoteDataSource>(
      _i24.AuthRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i25.BookingLocalDataSource>(
      _i25.BookingLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i26.BookingRemoteDataSource>(
      _i26.BookingRemoteDataSource(client: get<_i3.Client>()));
  gh.lazySingleton<_i27.INetworkInfo>(() => _i27.NetworkInfo(
      connectionChecker: get<_i4.InternetConnectionChecker>()));
  gh.singleton<_i28.IUserRepository>(_i29.UserRepository(
    networkInfo: get<_i27.INetworkInfo>(),
    remoteDataSource: get<_i24.AuthRemoteDataSource>(),
    localDataSource: get<_i23.AuthLocalDataSource>(),
  ));
  gh.singleton<_i30.NotificationLocalDataSource>(
      _i30.NotificationLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i31.OwnerBookingLocalDataSource>(
      _i31.OwnerBookingLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i32.OwnerPadelLocalDataSource>(
      _i32.OwnerPadelLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i33.PadelGroupLocalDataSource>(
      _i33.PadelGroupLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i34.PadelLocalDataSource>(
      _i34.PadelLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i35.PostGroupLocalDataSource>(
      _i35.PostGroupLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i36.PostLocalDataSource>(
      _i36.PostLocalDataSource(cache: get<_i12.SharedPreferences>()));
  gh.singleton<_i37.IAddressRepository>(_i38.AddressRepository(
    networkInfo: get<_i27.INetworkInfo>(),
    remoteDataSource: get<_i14.AddressRemoteDataSource>(),
    localDataSource: get<_i13.AddressLocalDataSource>(),
  ));
  gh.singleton<_i39.IAdminBookingRepository>(_i40.AdminBookingRepository(
    networkInfo: get<_i27.INetworkInfo>(),
    remoteDataSource: get<_i16.AdminBookingRemoteDataSource>(),
    localDataSource: get<_i15.AdminBookingLocalDataSource>(),
  ));
  gh.singleton<_i41.IAdminNotificationRepository>(
      _i42.AdminNotificationRepository(
    networkInfo: get<_i27.INetworkInfo>(),
    remoteDataSource: get<_i18.AdminNotificationRemoteDataSource>(),
    localDataSource: get<_i17.AdminNotificationLocalDataSource>(),
  ));
  gh.singleton<_i43.IAdminPadelRepository>(_i44.AdminPadelsRepository(
    networkInfo: get<_i27.INetworkInfo>(),
    remoteDataSource: get<_i20.AdminPadelRemoteDataSource>(),
    localDataSource: get<_i19.AdminPadelLocalDataSource>(),
  ));
  gh.singleton<_i45.IAdminUsersRepository>(_i46.AdminUsersRepository(
    networkInfo: get<_i27.INetworkInfo>(),
    remoteDataSource: get<_i22.AdminUsersRemoteDataSource>(),
    localDataSource: get<_i21.AdminUsersLocalDataSource>(),
  ));
  gh.singleton<_i47.IBookingRepository>(_i48.BookingRepository(
    networkInfo: get<_i27.INetworkInfo>(),
    localDataSource: get<_i25.BookingLocalDataSource>(),
    remoteDataSource: get<_i26.BookingRemoteDataSource>(),
  ));
  gh.singleton<_i49.INotificationRepository>(_i50.NotificationRepsotory(
    networkInfo: get<_i27.INetworkInfo>(),
    localDataSource: get<_i30.NotificationLocalDataSource>(),
    remoteDataSource: get<_i5.NotificationRemoteDataSource>(),
  ));
  gh.singleton<_i51.IOwnerBookingRepository>(_i52.OwnerBookingRepository(
    get<_i27.INetworkInfo>(),
    get<_i31.OwnerBookingLocalDataSource>(),
    get<_i6.OwnerBookingRemoteDataSource>(),
  ));
  gh.singleton<_i53.IOwnerPadelRepository>(_i54.OwnerPadelRepository(
    get<_i32.OwnerPadelLocalDataSource>(),
    get<_i7.OwnerPadelRemoteDataSource>(),
    get<_i27.INetworkInfo>(),
  ));
  gh.singleton<_i55.IPadelGroupRepository>(_i56.PadelGroupRepository(
    networkInfo: get<_i27.INetworkInfo>(),
    localDataSource: get<_i33.PadelGroupLocalDataSource>(),
    remoteDataSource: get<_i8.PadelGroupRemoteDataSource>(),
  ));
  gh.singleton<_i57.IPadelRepository>(_i58.PadelRepository(
    networkInfo: get<_i27.INetworkInfo>(),
    remoteDataSource: get<_i9.PadelRemoteDataSource>(),
    localDataSource: get<_i34.PadelLocalDataSource>(),
  ));
  gh.singleton<_i59.IPostGroupRepository>(_i60.PostGroupRepository(
    networkInfo: get<_i27.INetworkInfo>(),
    localDataSource: get<_i35.PostGroupLocalDataSource>(),
    remoteDataSource: get<_i10.PostGroupRemoteDataSource>(),
  ));
  gh.singleton<_i61.IPostRepository>(_i62.PostRepository(
    networkInfo: get<_i27.INetworkInfo>(),
    remoteDataSource: get<_i11.PostRemoteDataSource>(),
    localDataSource: get<_i36.PostLocalDataSource>(),
  ));
  return get;
}

class _$ExternalInjections extends _i63.ExternalInjections {}
