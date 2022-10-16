import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/address.dart';

abstract class IAddressRepository {
  Future<Either<Failure, List<AddressModel>>?>? getAddresses(
      {int? page, int? limit});
  Future<Either<Failure, AddressModel>?>? getAddress(int id);
}
