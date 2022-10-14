import 'package:feekpadel/src/core/langs/english.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

class Locals extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en-US': English().call(),
      };
}
