import 'package:get/get.dart';

class PaintingController extends GetxController {
  //================================ Parameters ================================
  // this will be used to figure out on which [painting] am I currently
  // working on, instead of passing it around in widgets that don't use it
  int currentActivePaintingIndex = 0;
  //================================= Methods ==================================
  //! This section is for the Controller related Methods [init, close, etc..]
  //============================================================================
  @override
  void onInit() {
    super.onInit();
  }

  //============================================================================
  @override
  void onReady() {
    super.onReady();
  }

  //============================================================================
  @override
  void onClose() {}
  //================================= Methods ==================================
  //! This section is for differnt other methods
  //============================================================================
  set setCurrentActivePaintingIndex(int index) {
    currentActivePaintingIndex = index;
  }
  //============================================================================
}
