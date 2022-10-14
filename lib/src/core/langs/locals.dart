import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'english.dart';

class Locals extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en-US': English().call(),
      };
}
