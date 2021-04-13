import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  //================================ Properties ================================
  var _strokeColor = Color(0xff000000);
  var _pointsMode = PointMode.points.obs;
  var _strokeWitdth = 5.0.obs;
  // this will be distance to check against for deletion, [the eraser size]
  var _deleteDistance = 10.5.obs;

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
  Color get strokeColor => _strokeColor;
  double get minDeleteDistance => _deleteDistance.value;
  //============================================================================
  set setStrokeWidth(double val) {
    _strokeWitdth.value = val;
  }

  //============================================================================
  set setColor(Color val) {
    _strokeColor = val;
  }

  //============================================================================
  set setPointMode(PointMode newVal) {
    _pointsMode.value = newVal;
  }

  //============================================================================

}
