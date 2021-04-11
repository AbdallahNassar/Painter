import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DrawingMode { PAINT, ERASE }

class HomeController extends GetxController {
  //================================ Properties ================================
  var _pointsList = <Offset>[].obs;
  // this will hold the deleted points, for later redoing.
  // this was made into [obs] to allow the 'isRedoActive' to update
  // automagically when the [trashlist] length change
  var _trashList = <Offset>[].obs;
  // this will switch between drawing modes [draw or erase] to allow different
  // functionalities on the [on pan upadate]
  var _drawingMode = DrawingMode.PAINT.obs;
  // this will be the temp variable to hold the distance between two points
  // [drawn point and eraser]
  var distance = 0.0;
  // this will be distance to check against for deletion, [the eraser size]
  var deleteDistance = 100.5.obs;
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
    _trashList.close();
  }

  //================================ Getters ===================================
  // Kinda not necessary, but to abstract the 'GetX .value' syntax in the
  // widgets and UI.
  List<Offset> get pointsList => _pointsList.toList();
  // these will be reactive as they will automagically change when the
  // lists lengths change.
  bool get isUndoActive => _pointsList.isNotEmpty;
  bool get isRedoActive => _trashList.isNotEmpty;
  bool get isRestoreActive => (_pointsList.isEmpty && _trashList.isNotEmpty);
  DrawingMode get drawingMode => _drawingMode.value;
  //============================================================================
  void addPoint(Offset point) {
    // to only draw in it's specified area [respect appbar and bottom]
    if (point.direction <= 0.0) return;
    _pointsList.add(point);
    print('$point' + ', length = ${_pointsList.length}');
  }

  //============================================================================
  void clearPoints() {
    print('is trash empty ? ${_trashList.isEmpty}');
    _trashList.value = List.from(_pointsList);
    _pointsList.clear();
    print('is trash empty ? ${_trashList.isEmpty}');
  }

  //============================================================================
  void erase(Offset point) {
    _pointsList.removeWhere((element) {
      distance = _calcuateDistance(point, element);
      print(distance);
      return distance <= deleteDistance.value;
    });
  }

  //============================================================================
  double _calcuateDistance(Offset point1, Offset point2) {
    return math.sqrt(math.pow((point1.dx - point2.dx), 2) +
        math.pow((point1.dy - point2.dy), 2));
  }

  //============================================================================
  void undo() {
    _trashList.add(_pointsList.removeLast());
  }

  //============================================================================
  void redo() {
    _pointsList.add(_trashList.removeLast());
  }

  //============================================================================
  void restore() {
    _pointsList.value = List.from(_trashList);
    _trashList.clear();
  }

  //============================================================================
  set setDrawingMode(DrawingMode newMode) {
    _drawingMode.value = newMode;
    print(
        'Now in ${newMode == DrawingMode.PAINT ? 'Painting' : 'Erasing'} Mode');
  }
  //============================================================================

}
