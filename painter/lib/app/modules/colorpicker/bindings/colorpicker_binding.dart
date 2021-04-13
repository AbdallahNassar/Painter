import 'package:get/get.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';

class ColorpickerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
  }
}
