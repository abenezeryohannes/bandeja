import 'package:http/retry.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

@module
abstract class ExternalInjections {
  @singleton
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  http.Client get client => RetryClient(http.Client());

  @lazySingleton
  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker();
}
