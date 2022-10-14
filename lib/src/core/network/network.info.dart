import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
  static const String hostURL = "";
}

@LazySingleton(as: INetworkInfo)
class NetworkInfo implements INetworkInfo {
  late InternetConnectionChecker connectionChecker;
  NetworkInfo({required this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
