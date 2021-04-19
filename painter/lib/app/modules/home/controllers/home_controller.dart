import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/app/data/models/my_paint.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';

class HomeController extends GetxController {
  //================================ Properties ================================
  // this will hold an instance of [settingController], I can't use [Get.find]
  // as it would enter an infitie loop as I'm also calling [Get.find] for the
  // [HomeController] in the [SettingController]
  var settingsController;
  //============================================================================
  //
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
  //TODO: handle this
  bool get isRedoActive => _trashList.isNotEmpty;
  // _trashList.first.value.pointsList.isNotEmpty ||
  // _trashList.last.value.pointsList.isNotEmpty;
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
    // check to see the style of [MyPaint] [color.. width.. etc] of the
    // [bigList] matches the style of [MyPaint] for the trashList
    if (!_isSamePaint(
      _bigList.last.value.paint,
      _trashList.last.value.paint,
    ))
      // if so, take the style of [MyPaint] of the points in the trash list
      _trashList.add(
        MyPaint(
          [],
          color: _bigList.last.value.color,
          strokeWidth: _bigList.last.value.strokeWidth,
          pointMode: _bigList.last.value.pointMode,
        ).obs,
      );

    // If I reach the end of the list inside the [bigList], I remove it and go
    // onto the list before it in the [BigList] , bigList[2] ==> bigList[1]
    if (_bigList.last.value.pointsList.isEmpty && _bigList.length > 1) {
      _bigList.removeLast();
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
    print('undo is done');
  }

  //============================================================================
  void redo() {
    // check to see the style of [MyPaint] [color.. width.. etc] of the
    // [bigList] matches the style of [MyPaint] for the trashList
    if (!_isSamePaint(
      _bigList.last.value.paint,
      _trashList.last.value.paint,
    ))
      // if so, take the style of [MyPaint] of the points in the big list
      _bigList.add(
        MyPaint(
          [],
          color: _trashList.last.value.color,
          strokeWidth: _trashList.last.value.strokeWidth,
          pointMode: _trashList.last.value.pointMode,
        ).obs,
      );

    if (_trashList.last.value.pointsList.isEmpty && _trashList.length > 1) {
      _bigList.removeLast();
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
    print('redo is done');
  }
  //============================================================================

  //checks to see if two paints are the same
  bool _isSamePaint(Paint paint1, Paint paint2) {
    return (paint1 == paint2);
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
    // start from my last prefrences [preferred settings]
    _bigList.add(
      _getNewPaint().obs,
    );
  }

  //============================================================================
  void restore() {
    // points list will now = trashlist
    _bigList.value = List.from(_trashList);
    // remove trash list
    _trashList.clear();
    // insert a new list into the trashList, this will be my 'trashList.last'
    _trashList.add(
      _getNewPaint().obs,
    );
  }

  //============================================================================
  // will be used to
  // 1) increment the active index counter
  // 2) create a new list in the [Big List]
  void makeNewList() {
    if (_bigList.last.value.pointsList.isNotEmpty) {
      _bigList.add(
        _getNewPaint().obs,
      );
    }
  }

  //============================================================================
  set setSettingsController(SettingsController inputSettingsController) =>
      settingsController = inputSettingsController;
  //============================================================================
  // will be called when I clear the [bigList]/[trashList] and this will be
  // my List.last
  MyPaint _getNewPaint() => MyPaint(
        [],
        color: settingsController.strokeColor,
        pointMode: settingsController.pointsMode,
        strokeWidth: settingsController.strokeWidth,
      );
  //============================================================================

}
