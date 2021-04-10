import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //================================ Properties ================================
  var _pointsList = <Offset>[].obs;
  // this will hold the deleted points, for later redoing.
  // this was made into [obs] to allow the 'isRedoActive' to update
  // automagically when the [trashlist] length change
  var _trashList = <Offset>[].obs;
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
  //============================================================================
  void addPoint({required Offset point, required DateTime entryTime}) {
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
  void erase() {}
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

}
