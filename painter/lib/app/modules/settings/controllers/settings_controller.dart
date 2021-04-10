import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  //================================ Properties ================================
  var _strokeColor = Color(0xff000000);
  var _pointsMode = PointMode.lines.obs;
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
  Color get strokeColor => _strokeColor;
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
