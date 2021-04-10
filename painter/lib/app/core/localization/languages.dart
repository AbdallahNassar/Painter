import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:painter/app/core/localization/ar-eg.dart';
import 'package:painter/app/core/localization/en-us.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': englishDictionary,
        'ar_EG': arabicDictionary,
      };
}
