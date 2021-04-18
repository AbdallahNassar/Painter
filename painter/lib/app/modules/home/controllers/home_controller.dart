import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //================================ Properties ================================
  // this will hold the different lists of points, will be used to have
  // different styles for each list .. so create a new list in the [Big List]
  // is created where the new changes will be applied
  // e.g. if I changed the font color I only want that to affect
  // the next points that I draw not the previous ones
  var _bigList = [<Offset>[].obs].obs;

  // this will hold the deleted points, for later redoing.
  // this was made into [obs] to allow the 'isRedoActive' to update
  // automagically when the [trashlist] length change
  var _trashList = [<Offset>[].obs].obs;

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
    _bigList.close();
    _trashList.close();
  }

  //================================ Getters ===================================
  // this will give the entire big list back, for redrawing all the small
  // lists in that list, each with its syle
  List<List<Offset>> get bigList => _bigList.toList();
  // these will be reactive as they will automagically change when the
  // lists lengths change.
  // I used 'First' as This will be the last thing to change
  bool get isUndoActive => _bigList.first.isNotEmpty;
  bool get isRedoActive => _trashList.first.isNotEmpty;
  bool get isRestoreActive => (_bigList.last.isEmpty && _trashList.isNotEmpty);
  //============================================================================
  void addPoint(Offset point) {
    // to only draw in it's specified area [respect appbar and bottom]
    if (point.direction <= 0.0) return;
    _bigList.last.add(point);
    print('$point' + ', length = ${_bigList.last.length}');
  }

  //========================================================================l====
  void clearPoints() {
    // put all s  list into a trash list
    // using this method to only take the values from [_bigList]
    // into [trashList], otherwise the two become one and If I clear one,
    // I clear the other.
    _trashList.value = List.from(_bigList);
    // clear the big list, now bigList = []
    _bigList.clear();
    // insert a new list into the bigList, this will be my 'biglist.last'
    _bigList.add(<Offset>[].obs);
  }

  //============================================================================
  void erase(Offset point, double minDeleteDistance) {
    var tempIndex = _bigList.last.indexWhere(
      (element) {
        return _calcuateDistance(point, element) <= minDeleteDistance;
      },
    );
    // [IndexWhere] returns [-1] if it didn't find anything
    if (tempIndex != -1)
      _trashList.last.add(
        _bigList.last.removeAt(tempIndex),
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
    print('@undo @ home controller, ${_bigList.length}');
    // If I reach the end of the list inside the [bigList] I remove it and go
    // onto the list before it in the [BigList] , bigList[2] ==> bigList[1]
    if (_bigList.last.isEmpty && _bigList.length > 1) {
      _bigList.removeLast();
      return;
    }
    _trashList.last.add(_bigList.last.removeLast());
  }

  //============================================================================
  //TODO: handle this with big list
  void redo() {
    if (_trashList.last.isEmpty && _trashList.length > 1) {
      _bigList.removeLast();
      return;
    }
    _bigList.last.add(_trashList.last.removeLast());
  }

  //============================================================================
  void restore() {
    // points list will now = trashlist
    _bigList.value = List.from(_trashList);
    // remove trash list
    _trashList.clear();
    // insert a new list into the trashList, this will be my 'trashList.last'
    _trashList.add(<Offset>[].obs);
  }

  //============================================================================
  // will be used to
  // 1) increment the active index counter
  // 2) create a new list in the [Big List]
  void makeNewList() {
    if (_bigList.last.isNotEmpty) {
      _bigList.add(<Offset>[].obs);
    }
  }
  //============================================================================
}
