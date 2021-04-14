import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';

class HomeController extends GetxController {
  //================================ Properties ================================
  // this will hold the different lists of points, will be used to have
  // different styles for each list .. so create a new list in the [Big List]
  // is created where the new changes will be applied
  // e.g. if I changed the font color I only want that to affect
  // the next points that I draw not the previous ones
  var _bigList = [<Offset>[].obs];

  // this will hold the deleted points, for later redoing.
  // this was made into [obs] to allow the 'isRedoActive' to update
  // automagically when the [trashlist] length change
  var _trashList = <Offset>[].obs;

  // this will be the temp variable to hold the distance between two points
  // [drawn point and eraser]
  var distance = 0.0;

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
    _bigList.clear();
    _trashList.close();
  }

  //================================ Getters ===================================
  // Kinda not necessary, but to abstract the 'GetX .value' syntax in the
  // widgets and UI.
  List<Offset> get pointsList => _bigList.last.toList();
  // these will be reactive as they will automagically change when the
  // lists lengths change.
  bool get isUndoActive => _bigList.last.isNotEmpty;
  bool get isRedoActive => _trashList.isNotEmpty;
  bool get isRestoreActive => (_bigList.last.isEmpty && _trashList.isNotEmpty);
  //============================================================================
  void addPoint(Offset point) {
    // to only draw in it's specified area [respect appbar and bottom]
    if (point.direction <= 0.0) return;
    _bigList.last.add(point);
    print('$point' + ', length = ${_bigList.last.length}');
  }

  //============================================================================
  void clearPoints() {
    print('is trash empty ? ${_trashList.isEmpty}');
    _trashList.value = List.from(_bigList.last);
    _bigList.last.clear();
    print('is trash empty ? ${_trashList.isEmpty}');
  }

  //============================================================================
  void erase(Offset point, double minDeleteDistance) {
    _bigList.last.removeWhere(
      (element) {
        return _calcuateDistance(point, element) <= minDeleteDistance;
      },
    );
  }

  //============================================================================
  double _calcuateDistance(Offset point1, Offset point2) {
    return math.sqrt(
      math.pow((point1.dx - point2.dx), 2) +
          math.pow((point1.dy - point2.dy), 2),
    );
  }

  //============================================================================
  void undo() {
    _trashList.add(_bigList.last.removeLast());
  }

  //============================================================================
  void redo() {
    _bigList.last.add(_trashList.removeLast());
  }

  //============================================================================
  void restore() {
    // points list will now = trashlist
    _bigList.last.value = List.from(_trashList);
    // remove trash list
    _trashList.clear();
  }

  //============================================================================
  // will be used to
  // 1) increment the active index counter
  // 2) create a new list in the [Big List]
  void makeNewList() {
    if (_bigList.last.isNotEmpty) {
      print('now on list with index = ${_bigList.length - 1}');
      _bigList.add(<Offset>[].obs);
    }
  }
  //============================================================================

}
