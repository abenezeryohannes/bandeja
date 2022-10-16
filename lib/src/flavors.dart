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
        return 'feekpadel';
      case Flavor.admin:
        return 'feekpadel Admin';
      case Flavor.owner:
        return 'feekpadel Owner';
      default:
        return 'title';
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
