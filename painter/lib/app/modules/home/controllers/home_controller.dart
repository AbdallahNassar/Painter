import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //================================ Properties ================================
  var _pointsList = <Offset>[].obs;
  var _pointsMode = PointMode.lines.obs;
  var _strokeWitdth = 5.0.obs;
  var _color = Colors.deepPurple.shade200.obs;
  //================================= Methods ==================================
  set addPoint(Offset point) {
    print(point);
    _pointsList.add(point);
  }

  set setStrokeWidth(double val) {
    _strokeWitdth.value = val;
  }

  set setColor(Color val) {
    _color.value = val;
  }

  void clearPoints() {
    _pointsList.clear();
  }

  List<Offset> get pointsList => _pointsList.toList();
  PointMode get pointsMode => _pointsMode.value;
  double get strokeWidth => _strokeWitdth.value;
  Color get color => _color.value;
  //============================================================================
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
}
//==============================================================================
