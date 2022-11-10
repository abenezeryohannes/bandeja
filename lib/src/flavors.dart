import 'package:injectable/injectable.dart';

import '../main/injection/injector.dart';

enum Flavor {
  main,
  admin,
  owner,
}

class FF {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.main:
        return 'Bandeja';
      case Flavor.admin:
        return 'Bandeja Admin';
      case Flavor.owner:
        return 'Bandeja Owner';
      default:
        return 'Bandeja';
    }
  }

  static Environment get env {
    switch (appFlavor) {
      case Flavor.admin:
        return admin;
      case Flavor.owner:
        return owner;
      default:
        return mmain;
    }
  }
}
