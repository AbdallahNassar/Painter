import 'package:get/get.dart';
import 'package:painter/app/modules/painting/controllers/painting_controller.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  // here I put all the controllers I'm gonna need for the 'HomeView'.
  // they will only be created/initialized when needed [called upon]
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
    Get.lazyPut<PaintingController>(
      () => PaintingController(),
    );
  }
}
