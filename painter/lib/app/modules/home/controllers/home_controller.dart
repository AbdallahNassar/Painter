import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/app/data/models/my_paint.dart';

class HomeController extends GetxController {
  //================================ Properties ================================
  // this will hold the different [MyPaint][] Structures, will be used
  // to have different styles for each list .. so create a new list in the
  // [Big List] is created where the new changes will be applied
  // e.g. if I changed the font color I only want that to affect
  // the next points that I draw not the previous ones
  //
  // the bigList itself is [.obs] as when i clear the list and re-insert a
  // new [MyPaint] in it, it doesn't update automatically
  //
  // the [MyPaint] is [.obs] as I want to redraw everything once a new point
  // is inserted in the list
  var _bigList = [
    MyPaint([]).obs,
  ].obs;

  // this will hold the deleted points, for later redoing.
  // this was made into [obs] to allow the 'isRedoActive' to update
  // automagically when the [trashlist] length change
  var _trashList = [
    MyPaint([]).obs,
  ].obs;

  // this will be the temp variable to hold the distance between two points
  // [drawn point and eraser]
  var distance = 0.0;
  //================================ Getters ===================================
  // this will give the entire big list back, for redrawing all the small
  // lists in that list, each with its syle
  List<Rx<MyPaint>> get bigList => _bigList;
  // these will be reactive as they will automagically change when the
  // lists lengths change.
  // I used 'First' as This will be the last thing to change
  bool get isUndoActive => _bigList.first.value.pointsList.isNotEmpty;
  bool get isRedoActive => _trashList.first.value.pointsList.isNotEmpty;
  bool get isRestoreActive => (_bigList.last.value.pointsList.isEmpty &&
      _trashList.last.value.pointsList.isNotEmpty);
  //================================= Methods ==================================
  void addPoint(Offset point) {
    // to only draw in it's specified area [respect appbar and bottom]
    if (point.direction <= 0.0) return;
    // [.obs] classes have a unique ways of updating
    _bigList.last.update((val) {
      val!.pointsList.add(point);
    });
  }

  //============================================================================
  void erase(Offset point, double minDeleteDistance) {
    //the [GetX] way of updating an [.obs] object
    _bigList.forEach((myPaint) {
      myPaint.update(
        (val) {
          // this will remove the object if the function returns true
          val!.pointsList.removeWhere((element) {
            // check the condition for deletion
            if (_calcuateDistance(point, element) <= minDeleteDistance) {
              // update the trashlist and add that element before it's deleted
              _trashList.last.update((trashVal) {
                trashVal!.pointsList.add(element);
              });
              return true;
            }
            return false;
          });
        },
      );
    });
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
    // If I reach the end of the list inside the [bigList] I remove it and go
    // onto the list before it in the [BigList] , bigList[2] ==> bigList[1]
    if (_bigList.last.value.pointsList.isEmpty && _bigList.length > 1) {
      _bigList.removeLast();
      return;
    }
    // update the bigList's Last element [MyPaint] by removing it's last elem
    _bigList.last.update((bigVal) {
      // update the trashlist by adding the element I just removed from the
      // big List
      _trashList.last.update((val) {
        val!.pointsList.add(
          bigVal!.pointsList.removeLast(),
        );
      });
    });
  }

  //============================================================================
  void redo() {
    if (_trashList.last.value.pointsList.isEmpty && _trashList.length > 1) {
      _bigList.removeLast();
      return;
    }
    // update the bigList's Last element [MyPaint] by removing it's last elem
    _trashList.last.update((trashVal) {
      // update the trashlist by adding the element I just removed from the
      // big List
      _bigList.last.update((val) {
        val!.pointsList.add(
          trashVal!.pointsList.removeLast(),
        );
      });
    });
  }

  //============================================================================
  void clearPoints() {
    // put all s  list into a trash list
    // using this method to only take the values from [_bigList]
    // into [trashList], otherwise the two become one and If I clear one,
    // I clear the other.
    _trashList.value = List.from(_bigList);
    // clear the big list, now bigList = []
    _bigList.clear();
    // insert a new list into the bigList, this will be my 'biglist.last'
    _bigList.add(MyPaint([]).obs);
  }

  //============================================================================
  void restore() {
    // points list will now = trashlist
    _bigList.value = List.from(_trashList);
    // remove trash list
    _trashList.clear();
    // insert a new list into the trashList, this will be my 'trashList.last'
    _trashList.add(MyPaint([]).obs);
  }

  //============================================================================
  // will be used to
  // 1) increment the active index counter
  // 2) create a new list in the [Big List]
  void makeNewList(MyPaint? myPaint) {
    if (_bigList.last.value.pointsList.isNotEmpty) {
      _bigList.add(
        myPaint != null ? myPaint.obs : MyPaint([]).obs,
      );
    }
  }
  //============================================================================
}
