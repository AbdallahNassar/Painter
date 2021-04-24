import 'package:get/get.dart';

import '../controllers/painting_controller.dart';

class PaintingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaintingController>(
      () => PaintingController(),
    );
  }
}
