import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //================================ Properties ================================
  var _pointsList = <Offset>[].obs;
  // this will hold the deleted points, for later redoing.
  var _trashList = <Offset>[];
  // these are '.obs' to rebuild the entire UI from the settings menu
  var _pointsMode = PointMode.lines.obs;
  var _strokeWitdth = 5.0.obs;
  var _color = Colors.black.obs;
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
  void onClose() {
    _pointsList.close();
    _pointsMode.close();
    _strokeWitdth.close();
    _color.close();
  }

  //================================ Getters ===================================
  // Kinda not necessary, but to abstract the 'GetX .value' syntax in the
  // widgets and UI.
  List<Offset> get pointsList => _pointsList.toList();
  PointMode get pointsMode => _pointsMode.value;
  double get strokeWidth => _strokeWitdth.value;
  Color get color => _color.value;
  //============================================================================
  set addPoint(Offset point) {
    print(point);
    _pointsList.add(point);
  }

  //============================================================================
  set setStrokeWidth(double val) {
    _strokeWitdth.value = val;
  }

  //============================================================================
  set setColor(Color val) {
    _color.value = val;
  }

  //============================================================================
  void clearPoints() {
    _pointsList.clear();
  }

  //============================================================================
  void undo() {
    if (_pointsList.length == 0) return;
    _trashList.add(_pointsList.removeLast());
  }

  //============================================================================
  void redo() {
    if (_trashList.length == 0) return;
    _pointsList.add(_trashList.removeLast());
  }
  //============================================================================

}
