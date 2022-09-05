import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:app/features/authentication/data/datasource/user.local.data.source.dart';
import 'package:app/features/authentication/data/datasource/user.remote.data.source.dart';
import 'package:app/features/authentication/data/repository/user.repository.imp.dart';
import 'package:app/features/authentication/domain/repositories/user.repository.dart';
import 'package:app/features/authentication/domain/usecases/get.user.dart';
import 'package:app/features/authentication/domain/usecases/load.user.dart';
import 'package:app/features/authentication/domain/usecases/set.user.dart';
import 'package:app/features/authentication/presentation/bloc/sign_up/sign.up.bloc.dart';
import 'package:app/features/authentication/presentation/bloc/user/user.bloc.dart';
import 'package:app/features/candidate/domain/usecases/get,candidate.dart';
import 'package:app/features/candidate/presentation/bloc/candidate_categories/candidate.categories.bloc.dart';
import 'package:app/features/candidate/presentation/bloc/candidates_under_category/candidates.under.category.bloc.dart';
import 'package:app/features/candidate/presentation/bloc/featured_candidates/featured.candidates.bloc.dart';
import 'package:app/features/setting/data/datasources/setting.local.data.source%20copy.dart';
import 'package:app/features/setting/data/datasources/setting.remote.data.source.dart';
import 'package:app/features/setting/data/repositories/setting.repository.imp.dart';
import 'package:app/features/setting/domain/repositories/setting.repository.dart';
import 'package:app/features/setting/domain/usercases/load.setting.dart';
import 'package:app/features/setting/domain/usercases/set.setting.dart';
import 'package:app/features/setting/presentation/bloc/bloc/setting.bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network.info.dart';
import 'features/authentication/domain/usecases/register.user.dart';
import 'features/authentication/domain/usecases/set.user.vote.dart';
import 'features/candidate/data/datasource/candidate.local.data.source.dart';
import 'features/candidate/data/datasource/candidate.remote.data.source.dart';
import 'features/candidate/data/repository/candidate.repository.imp.dart';
import 'features/candidate/domain/repositories/candidate.repository.dart';
import 'features/candidate/domain/usecases/get.candidate.categories.dart';
import 'features/candidate/domain/usecases/get.candidates.under.category.dart';
import 'features/candidate/domain/usecases/get.featured.candidates.dart';
import 'features/candidate/domain/usecases/get.top.voted.candidates.dart';
import 'features/candidate/domain/usecases/load.candidate.categories.dart';
import 'features/candidate/domain/usecases/load.featured.candidates.dart';
import 'features/candidate/domain/usecases/load.top.voted.candidates.dart';
import 'features/candidate/presentation/bloc/Candidate/candidate.bloc.dart';
import 'features/candidate/presentation/bloc/top_voted_candidates/top.voted.candidates.bloc.dart';
import 'features/setting/domain/usercases/get.setting.dart';

final sl = GetIt.instance;

Future<void> injectDependencies() async {
  //? External

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  sl.registerLazySingleton<http.Client>(() => http.Client());

  //? Features

  sl.registerLazySingleton<CandidateRemoteDataSource>(
      () => CandidateRemoteDataSource(client: sl()));

  sl.registerLazySingleton<CandidateLocalDataSource>(
      () => CandidateLocalDataSource(sharedPreferences: sl()));

  sl.registerLazySingleton<SettingLocalDataSource>(
      () => SettingLocalDataSource(sharedPreferences: sl()));

  sl.registerLazySingleton<SettingRemoteDataSource>(
      () => SettingRemoteDataSource(client: sl()));

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(connectionChecker: sl()));

  sl.registerLazySingleton<SettingRepository>(() => SettingRepositoryImp(
      networkInfo: sl(), localDataSource: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton<CandidateRepository>(() => CandidateRepositoryImp(
      networkInfo: sl(), localDataSource: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton<UserRepositoy>(() => UserRepositoyImp(
      networkInfo: sl(), localDataSource: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSource(client: sl()));

  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSource(sharedPreferences: sl()));

  sl.registerLazySingleton<SetSetting>(
      () => SetSetting(settingRepository: sl()));
  sl.registerLazySingleton<GetSetting>(
      () => GetSetting(settingRepository: sl()));
  sl.registerLazySingleton<LoadSetting>(
      () => LoadSetting(settingRepository: sl()));

  sl.registerLazySingleton<GetUser>(() => GetUser(userRepositoy: sl()));

  sl.registerLazySingleton<LoadUser>(() => LoadUser(userRepositoy: sl()));

  sl.registerLazySingleton<SetUser>(() => SetUser(userRepositoy: sl()));
  sl.registerLazySingleton<RegisterUser>(
      () => RegisterUser(userRepositoy: sl()));
  sl.registerLazySingleton<SetUserVote>(() => SetUserVote(userRepositoy: sl()));

  sl.registerLazySingleton<GetCandidate>(() => GetCandidate(repository: sl()));

  sl.registerLazySingleton<GetFeaturedCandidates>(
      () => GetFeaturedCandidates(repository: sl()));

  sl.registerLazySingleton<GetCandidateCategories>(
      () => GetCandidateCategories(repository: sl()));

  sl.registerLazySingleton<GetCandidatesUnderCategory>(
      () => GetCandidatesUnderCategory(repository: sl()));

  sl.registerLazySingleton<GetTopVotedCandidates>(
      () => GetTopVotedCandidates(repository: sl()));

  sl.registerLazySingleton<LoadFeaturedCandidates>(
      () => LoadFeaturedCandidates(repository: sl()));

  sl.registerLazySingleton<LoadCandidateCategories>(
      () => LoadCandidateCategories(repository: sl()));

  sl.registerLazySingleton<LoadTopVotedCandidates>(
      () => LoadTopVotedCandidates(repository: sl()));

  //? Core
  sl.registerFactory<TopVotedCandidatesBloc>(
      () => TopVotedCandidatesBloc(getTopVotes: sl(), LoadTopVotes: sl()));

  sl.registerFactory<CandidatesUnderCategoryBloc>(
      () => CandidatesUnderCategoryBloc(getCandidatesUnderCategory: sl()));

  sl.registerFactory<CandidateBloc>(() => CandidateBloc(getCandidate: sl()));

  sl.registerFactory<CandidateCategoriesBloc>(() => CandidateCategoriesBloc(
      getCandidateCategories: sl(), loadCandidateCategories: sl()));
  sl.registerFactory<FeaturedCandidatesBloc>(() => FeaturedCandidatesBloc(
      getFeaturedCandidates: sl(), loadFeaturedCandidates: sl()));
  sl.registerFactory<UserBloc>(() => UserBloc(
      getUser: sl(), setUserVote: sl(), setUser: sl(), loadUser: sl()));
  sl.registerFactory<SignUpBloc>(() => SignUpBloc(registerUser: sl()));
  sl.registerFactory<SettingBloc>(
      () => SettingBloc(setSetting: sl(), getSetting: sl(), loadSetting: sl()));
}
