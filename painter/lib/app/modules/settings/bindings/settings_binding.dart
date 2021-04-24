import 'package:get/get.dart';
import 'package:painter/app/modules/painting/controllers/painting_controller.dart';

import '../controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
    Get.lazyPut<PaintingController>(
      () => PaintingController(),
    );
  }
}
