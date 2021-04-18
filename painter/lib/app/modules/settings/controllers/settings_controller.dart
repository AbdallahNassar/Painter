import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/app/modules/home/controllers/home_controller.dart';

class SettingsController extends GetxController {
  //================================ Properties ================================
  var _strokeColor = Color(0xff000000).obs;
  var _pointsMode = PointMode.points.obs;
  var _strokeWitdth = 3.0.obs;
  // this will be distance to check against for deletion, [the eraser size]
  var _deleteDistance = 20.0.obs;
  // this will be used to communicate with home controller, for example
  // to increment the index of active list, to tell the [Big List] that
  // a change has happened
  var homeController = Get.find<HomeController>();
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
  Color get strokeColor => _strokeColor.value;
  double get eraserSize => _deleteDistance.value;
  double get minEraserSize => 20.0;
  double get maxEraserSize => 80.0;
  double get minPenSize => 3.0;
  double get maxPenSize => 20.0;
  //============================================================================
  set setStrokeWidth(double val) {
    _strokeWitdth.value = val;
    homeController.makeNewList();
  }

  //============================================================================
  set setColor(Color val) {
    _strokeColor.value = val;
    homeController.makeNewList();
  }

  //============================================================================
  set setPointMode(PointMode newVal) {
    _pointsMode.value = newVal;
    homeController.makeNewList();
  }

  //============================================================================
  set setEraserSize(double val) {
    _deleteDistance.value = val;
    homeController.makeNewList();
  }
  //============================================================================

}
