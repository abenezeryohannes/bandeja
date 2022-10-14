import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/fixtures/fixture.reader.dart';
import '../../../domain/core/entities/address.dart';

@singleton
class AddressLocalDataSource {
  late SharedPreferences cache;

  AddressLocalDataSource({required this.cache});
  static const String addressesKey = "addressesKey";

  Future<List<AddressModel>>? loadAddresses(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(addressesKey);
    if (data == null) throw CacheFailure();
    return loadAddressesFromJson(await fixture("addresses.json"));
  }

  Future<bool>? saveAddresses(int? page, List<AddressModel> addresses) async {
    if (page != null && page > 1) return false;
    return await cache.setString(addressesKey, json.encode(addresses));
  }

  Future<List<AddressModel>> loadAddressesFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<AddressModel>.from(
        l.map((model) => AddressModel.fromJson(model)));
  }
}
