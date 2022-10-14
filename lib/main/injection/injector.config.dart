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
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../../src/core/data/authentication/source/auth.local.data.source.dart'
    as _i12;
import '../../src/core/data/authentication/source/auth.remote.datasource.dart'
    as _i13;
import '../../src/core/data/authentication/user.repository.dart' as _i16;
import '../../src/core/data/padel/repositories/padel.group.repository.dart'
    as _i24;
import '../../src/core/data/padel/sources/padel_group/padel.group.local.data.source.dart'
    as _i17;
import '../../src/core/data/padel/sources/padel_group/padel.group.remote.data.source.dart'
    as _i5;
import '../../src/core/data/posts/post_group/post.group.local.data.source.dart'
    as _i19;
import '../../src/core/data/posts/post_group/post.group.remote.data.source.dart'
    as _i7;
import '../../src/core/data/posts/repositories/post.group.repository.dart'
    as _i28;
import '../../src/core/domain/authentication/repositories/i.user.repository.dart'
    as _i15;
import '../../src/core/domain/padels/repositories/i.padel.group.repository.dart'
    as _i23;
import '../../src/core/domain/posts/repositories/i.post.group.repository.dart'
    as _i27;
import '../../src/core/network/network.info.dart' as _i14;
import '../../src/main/data/core/repositories/address.repository.dart' as _i22;
import '../../src/main/data/core/source/address.local.data.source.dart' as _i10;
import '../../src/main/data/core/source/address.remote.data.source.dart'
    as _i11;
import '../../src/main/data/padel/repositories/padel.repository.dart' as _i26;
import '../../src/main/data/padel/sources/padel/padel.local.data.source.dart'
    as _i18;
import '../../src/main/data/padel/sources/padel/padel.remote.data.source.dart'
    as _i6;
import '../../src/main/data/posts/repositories/post.repository.dart' as _i30;
import '../../src/main/data/posts/source/post/post.local.datasource.dart'
    as _i20;
import '../../src/main/data/posts/source/post/post.remote.datasource.dart'
    as _i8;
import '../../src/main/domain/core/repositories/i.address.repository.dart'
    as _i21;
import '../../src/main/domain/padels/repositories/i.padel.repository.dart'
    as _i25;
import '../../src/main/domain/posts/repositories/i.post.repository.dart'
    as _i29;
import 'external.injections.dart'
    as _i31; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i5.PadelGroupRemoteDataSource>(
      _i5.PadelGroupRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i6.PadelRemoteDataSource>(
      _i6.PadelRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i7.PostGroupRemoteDataSource>(
      _i7.PostGroupRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i8.PostRemoteDataSource>(
      _i8.PostRemoteDataSource(client: get<_i3.Client>()));
  await gh.singletonAsync<_i9.SharedPreferences>(
    () => externalInjections.prefs,
    preResolve: true,
  );
  gh.singleton<_i10.AddressLocalDataSource>(
      _i10.AddressLocalDataSource(cache: get<_i9.SharedPreferences>()));
  gh.singleton<_i11.AddressRemoteDataSource>(
      _i11.AddressRemoteDataSource(client: get<_i3.Client>()));
  gh.singleton<_i12.AuthLocalDataSource>(
      _i12.AuthLocalDataSource(cache: get<_i9.SharedPreferences>()));
  gh.singleton<_i13.AuthRemoteDataSource>(
      _i13.AuthRemoteDataSource(client: get<_i3.Client>()));
  gh.lazySingleton<_i14.INetworkInfo>(() => _i14.NetworkInfo(
      connectionChecker: get<_i4.InternetConnectionChecker>()));
  gh.singleton<_i15.IUserRepository>(_i16.UserRepository(
    networkInfo: get<_i14.INetworkInfo>(),
    remoteDataSource: get<_i13.AuthRemoteDataSource>(),
    localDataSource: get<_i12.AuthLocalDataSource>(),
  ));
  gh.singleton<_i17.PadelGroupLocalDataSource>(
      _i17.PadelGroupLocalDataSource(cache: get<_i9.SharedPreferences>()));
  gh.singleton<_i18.PadelLocalDataSource>(
      _i18.PadelLocalDataSource(cache: get<_i9.SharedPreferences>()));
  gh.singleton<_i19.PostGroupLocalDataSource>(
      _i19.PostGroupLocalDataSource(cache: get<_i9.SharedPreferences>()));
  gh.singleton<_i20.PostLocalDataSource>(
      _i20.PostLocalDataSource(cache: get<_i9.SharedPreferences>()));
  gh.singleton<_i21.IAddressRepository>(_i22.AddressRepository(
    networkInfo: get<_i14.INetworkInfo>(),
    remoteDataSource: get<_i11.AddressRemoteDataSource>(),
    localDataSource: get<_i10.AddressLocalDataSource>(),
  ));
  gh.singleton<_i23.IPadelGroupRepository>(_i24.PadelGroupRepository(
    networkInfo: get<_i14.INetworkInfo>(),
    localDataSource: get<_i17.PadelGroupLocalDataSource>(),
    remoteDataSource: get<_i5.PadelGroupRemoteDataSource>(),
  ));
  gh.singleton<_i25.IPadelRepository>(_i26.PadelRepository(
    networkInfo: get<_i14.INetworkInfo>(),
    remoteDataSource: get<_i6.PadelRemoteDataSource>(),
    localDataSource: get<_i18.PadelLocalDataSource>(),
  ));
  gh.singleton<_i27.IPostGroupRepository>(_i28.PostGroupRepository(
    networkInfo: get<_i14.INetworkInfo>(),
    localDataSource: get<_i19.PostGroupLocalDataSource>(),
    remoteDataSource: get<_i7.PostGroupRemoteDataSource>(),
  ));
  gh.singleton<_i29.IPostRepository>(_i30.PostRepository(
    networkInfo: get<_i14.INetworkInfo>(),
    remoteDataSource: get<_i8.PostRemoteDataSource>(),
    localDataSource: get<_i20.PostLocalDataSource>(),
  ));
  return get;
}

class _$ExternalInjections extends _i31.ExternalInjections {}
