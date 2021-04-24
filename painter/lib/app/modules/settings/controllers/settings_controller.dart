import 'dart:ui';

import 'package:get/get.dart';
import 'package:painter/app/data/models/my_color.dart';
import 'package:painter/app/modules/home/controllers/home_controller.dart';

class SettingsController extends GetxController {
  //================================ Properties ================================
  // this will be distance to check against for deletion, [the eraser size]
  var _deleteDistance = 20.0.obs;
  // this will be used to communicate with home controller, for example
  // to increment the index of active list, to tell the [Big List] that
  // a change has happened
  final homeController = Get.find<HomeController>();

  // var to hold the value while it's being changed by the
  // slider, [Obs] to rebuild the widget.
  var _strokeColor = MyColor(0xffffffff).obs;
  var _pointsMode = PointMode.points.obs;
  var _strokeWitdth = 5.0.obs;
  //================================= Methods ==================================
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  //================================= Getters ==================================

  PointMode get pointsMode => _pointsMode.value;
  double get strokeWidth => _strokeWitdth.value;
  MyColor get strokeColor => _strokeColor.value;
  double get eraserSize => _deleteDistance.value;
  double get minEraserSize => 20.0;
  double get maxEraserSize => 80.0;
  double get minPenSize => 3.0;
  double get maxPenSize => 20.0;

  //============================================================================
  void setStrokeWidth(int index, double newVal) {
    // the index of the [Painting] to make new list in
    // save the new value, to update the widget that observes this var
    _strokeWitdth.value = newVal;
    homeController.makeNewList();
  }

  //============================================================================
  void setColor(int index, int newColorVal) {
    _strokeColor.value = MyColor(newColorVal);

    homeController.makeNewList();
  }

  //============================================================================
  void setPointMode(int index, PointMode newVal) {
    _pointsMode.value = newVal;
    homeController.makeNewList();
  }

  //============================================================================
  set setEraserSize(double newVal) {
    _deleteDistance.value = newVal;
    _deleteDistance.value = newVal;
  }
  //============================================================================

}
