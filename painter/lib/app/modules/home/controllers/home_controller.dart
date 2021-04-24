import 'dart:convert';
import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:painter/app/core/theme/app_colors.dart';
import 'package:painter/app/data/models/my_offset.dart';
import 'package:painter/app/data/models/painting.dart';
import 'package:painter/app/modules/painting/controllers/painting_controller.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';

class HomeController extends GetxController {
  //================================ Properties ================================
  // this will hold an instance of [settingController], I can't use [Get.find]
  // as it would enter an infitie loop as I'm also calling [Get.find] for the
  // [HomeController] in the [SettingController]
  late SettingsController settingsController;
  PaintingController paintingController = Get.find<PaintingController>();
  late final PageController pageViewController;
  // this will be my interface with the device local storage
  final _storageDriver = GetStorage();

  //============================================================================
  // this will hold the different [Painting][] Structures, will be used
  // to have different styles for each list .. so create a new list in the
  // [Big List] is created where the new changes will be applied
  // e.g. if I changed the font color I only want that to affect
  // the next points that I draw not the previous ones
  //
  // the bigList itself is [.obs] as when i clear the list and re-insert a
  // new [Painting] in it, it doesn't update automatically
  //
  // the [Painting] is [.obs] as I want to redraw everything once a new point
  // is inserted in the list
  //
  // this will be empty, and then be populated with a method that fetches
  // data from stroage
  //
  // the will be a list of Paintings Slides, this will be used in the home
  // page slides, to add page views from it
  //
  // _trashList will hold the deleted points, for later redoing.
  // this was made into [obs] to allow the 'isRedoActive' to update
  // automagically when the [trashlist] length change
  var _bigList = <RxList<Rx<Painting>>>[<Rx<Painting>>[].obs].obs;
  var _trashList = <RxList<Rx<Painting>>>[
    <Rx<Painting>>[Painting([]).obs].obs
  ].obs;

  // this will be the temp variable to hold the distance between two points
  // [drawn point and eraser]
  var distance = 0.0;
  //================================ Getters ===================================
  // this will give the entire big list back, for redrawing all the small
  // lists in that list, each with its syle
  List<RxList<Rx<Painting>>> get bigList => _bigList;
  //================================= Methods ==================================
  //! This section is for the Controller related Methods [init, close, etc..]
  //============================================================================
  @override
  void onInit() {
    super.onInit();
    _fetchDataBaseFromStorage();
    pageViewController = PageController(
      viewportFraction: 0.8,
    );
  }

  //============================================================================
  @override
  void onClose() {
    pageViewController.dispose();
  }

  //============================================================================
  set setSettingsController(SettingsController inputSettingsController) =>
      settingsController = inputSettingsController;

  //============================================================================
  //! This section is for the Local Storage Methods.
  //============================================================================

  void _fetchDataBaseFromStorage() {
    try {
      // try to read the key[database] from the storage and if I didn't find
      // it, put [''] in the variable
      var jsonDataBase =
          ReadWriteValue('database', '', () => _storageDriver).val;
      //? Case1]  Nothing was found in the storage.
      if (jsonDataBase == '') {
        print(
            'No data was found in the storage .. strating with an empty list');
        _bigList = [
          <Rx<Painting>>[Painting([]).obs].obs
        ].obs;
      }
      //? Case2]  Found data in storage, decode it and parse it.
      else {
        //TODO: hande local storage
        // _bigList = _decodeDataBase(jsonDataBase);
      }
    } catch (e) {
      print('Error at [fetchPaintingsFromStorage Method], $e');
    }
  }

  //============================================================================
  RxList<Rx<Painting>> _decodeDataBase(String jsonDataBase) {
    try {
      // convert the 'Json string' into a list of jsonPaintings
      var temp = json.decode(jsonDataBase);
      var dynamicList =
          // create a Painting from each jsonPaintig
          // make it [.obs] for the widgets that listen to it to work properly
          temp
              .map((jsonPainting) => Painting.fromJson(jsonPainting).obs)
              .toList();
      // typecast it into a list.
      List<Rx<Painting>> paintingList = List.from(dynamicList);
      return paintingList.obs;
    } catch (e) {
      print('Error at [decodeDataBase Method], $e');
      return <Rx<Painting>>[Painting([]).obs].obs;
    }
  }

  //============================================================================
  // this will save my stuff into the local storage
  void save() {
    try {
      var jsonDataBase = _encodeDataBase();
      //? case1] something went wrong with encoding
      if (jsonDataBase == '') {
        print('Could\'t save into the storage, something went wrong.');
        return;
      }
      //? case2] all is good.
      _storageDriver.write('database', jsonDataBase);
      _showSnackBar(success: true);
    } catch (e) {
      print('Error at [save Method], $e');
      _showSnackBar(success: false);
    }
  }

  //============================================================================
  String _encodeDataBase() {
    try {
      return json.encode(_bigList);
    } catch (e) {
      print('Error at [encodeDataBase Method], $e');
      return '';
    }
  }

  //============================================================================
  //! This section is for the Painting Methods.
  //============================================================================
  // these will be reactive as they will automagically change when the
  // lists lengths change.
  // I used 'First' as This will be the last thing to change
  // bool  isUndoActive(paintingController.currentActivePaintingIndex) => _slidesList[paintingController.currentActivePaintingIndex].value.pointsList.isNotEmpty;
  bool get isUndoActive =>
      _bigList[paintingController.currentActivePaintingIndex]
          .first
          .value
          .pointsList
          .isNotEmpty;
  //============================================================================

  bool get isRedoActive =>
      (_trashList[paintingController.currentActivePaintingIndex]
              .first
              .value
              .pointsList
              .isNotEmpty ||
          _trashList[paintingController.currentActivePaintingIndex]
              .last
              .value
              .pointsList
              .isNotEmpty);
  // when there are points in trashList and there aren't in pointsList
  //============================================================================

  bool get isRestoreActive => (isRedoActive && !isUndoActive);
  //============================================================================

  void addPoint(Offset point) {
    // to only draw in it's specified area [respect appbar and bottom]
    if (point.direction <= 0.0) return;
    // [.obs] classes have a unique ways of updating
    _bigList[paintingController.currentActivePaintingIndex].last.update(
      (val) {
        val!.pointsList.add(
          MyOffset(point.dx, point.dy),
        );
      },
    );
  }

  //============================================================================
  void _showSnackBar({required bool success}) {
    try {
      var title = success ? 'Success!' : 'Failure!';
      var message = success
          ? 'Saved in Local Stroage Successfully.'
          : 'Counldn\'t save into storage.\nSomthing went wrong.';
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.scaffoldBackgroundColor,
        snackStyle: SnackStyle.FLOATING,
      );
    } catch (e) {
      print('Error @ method [showSnackBar] $e');
    }
  }

  //============================================================================
  void erase(Offset point, double minDeleteDistance) {
    //the [GetX] way of updating an [.obs] object
    _bigList[paintingController.currentActivePaintingIndex].forEach(
      (painting) {
        painting.update(
          (val) {
            // this will remove the object if the function returns true
            val!.pointsList.removeWhere((element) {
              // check the condition for deletion
              if (_calcuateDistance(point, element) <= minDeleteDistance) {
                // update the trashlist and add that element before it's deleted
                _trashList[paintingController.currentActivePaintingIndex]
                    .last
                    .update((trashVal) {
                  trashVal!.pointsList.add(element);
                });
                return true;
              }
              return false;
            });
          },
        );
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
    // check to see the style of [Painting] [color.. width.. etc] of the
    // [bigList] matches the style of [Painting] for the trashList
    if (!_isSamePaint(
      _bigList[paintingController.currentActivePaintingIndex].last.value,
      _trashList[paintingController.currentActivePaintingIndex].last.value,
    ))
      // if so, take the style of [Painting] of the points in the trash list
      _trashList[paintingController.currentActivePaintingIndex].add(
        Painting(
          [],
          color: _bigList[paintingController.currentActivePaintingIndex]
              .last
              .value
              .color,
          strokeWidth: _bigList[paintingController.currentActivePaintingIndex]
              .last
              .value
              .strokeWidth,
          pointMode: _bigList[paintingController.currentActivePaintingIndex]
              .last
              .value
              .pointMode,
        ).obs,
      );

    // update the bigList's Last element [Painting] by removing it's last elem
    _bigList[paintingController.currentActivePaintingIndex]
        .last
        .update((bigVal) {
      // update the trashlist by adding the element I just removed from the
      // big List
      _trashList[paintingController.currentActivePaintingIndex]
          .last
          .update((val) {
        val!.pointsList.add(
          bigVal!.pointsList.removeLast(),
        );
      });
    });

    // If I reach the end of the list inside the [bigList], I remove it and go
    // onto the list before it in the [BigList] , bigList[2] ==> bigList[1]
    if (_bigList[paintingController.currentActivePaintingIndex]
            .last
            .value
            .pointsList
            .isEmpty &&
        _bigList[paintingController.currentActivePaintingIndex].length > 1) {
      _bigList[paintingController.currentActivePaintingIndex].removeLast();
    }
  }

  //============================================================================
  void redo() {
    // check to see the style of [Painting] [color.. width.. etc] of the
    // [bigList] matches the style of [Painting] for the trashList
    if (!_isSamePaint(
      _bigList[paintingController.currentActivePaintingIndex].last.value,
      _trashList[paintingController.currentActivePaintingIndex].last.value,
    ))
      // if so, take the style of [Painting] of the points in the big list
      _bigList[paintingController.currentActivePaintingIndex].add(
        Painting(
          [],
          color: _trashList[paintingController.currentActivePaintingIndex]
              .last
              .value
              .color,
          strokeWidth: _trashList[paintingController.currentActivePaintingIndex]
              .last
              .value
              .strokeWidth,
          pointMode: _trashList[paintingController.currentActivePaintingIndex]
              .last
              .value
              .pointMode,
        ).obs,
      );

    // update the bigList's Last element [Painting] by removing it's last elem
    _trashList[paintingController.currentActivePaintingIndex]
        .last
        .update((trashVal) {
      // update the trashlist by adding the element I just removed from the
      // big List
      _bigList[paintingController.currentActivePaintingIndex]
          .last
          .update((val) {
        val!.pointsList.add(
          trashVal!.pointsList.removeLast(),
        );
      });
    });

    if (_trashList[paintingController.currentActivePaintingIndex]
            .last
            .value
            .pointsList
            .isEmpty &&
        _trashList[paintingController.currentActivePaintingIndex].length > 1) {
      _trashList[paintingController.currentActivePaintingIndex].removeLast();
    }
  }
  //============================================================================

  //checks to see if two paints are the same
  bool _isSamePaint(Painting paint1, Painting paint2) {
    return (paint1.color == paint2.color &&
        paint1.pointMode == paint2.pointMode &&
        paint1.strokeWidth == paint2.strokeWidth);
  }

  //============================================================================
  void clearPoints() {
    // put all s  list into a trash list
    // using this method to only take the values from [_bigList]
    // into [trashList], otherwise the two become one and If I clear one,
    // I clear the other.
    _trashList[paintingController.currentActivePaintingIndex].value =
        List.from(_bigList[paintingController.currentActivePaintingIndex]);
    // clear the big list, now bigList = []
    _bigList[paintingController.currentActivePaintingIndex].clear();
    // insert a new list into the bigList, this will be my 'biglist.last'
    // start from my last prefrences [preferred settings]
    _bigList[paintingController.currentActivePaintingIndex].add(
      newPaint.obs,
    );
  }

  //============================================================================
  void restore() {
    // points list will now = trashlist
    _bigList[paintingController.currentActivePaintingIndex].value =
        List.from(_trashList[paintingController.currentActivePaintingIndex]);
    // remove trash list
    _trashList[paintingController.currentActivePaintingIndex].clear();
    // insert a new list into the trashList, this will be my 'trashList.last'
    _trashList[paintingController.currentActivePaintingIndex].add(
      newPaint.obs,
    );
  }

  //============================================================================
  // will be used to
  // 1) increment the active paintingController.currentActivePaintingIndex counter
  // 2) create a new list in the [Big List]
  void makeNewList() {
    if (_bigList[paintingController.currentActivePaintingIndex]
        .last
        .value
        .pointsList
        .isNotEmpty) {
      _bigList[paintingController.currentActivePaintingIndex].add(
        newPaint.obs,
      );
    }
  }

  //============================================================================
  // will be called when I clear the [bigList]/[trashList] and this will be
  // my List.last
  Painting get newPaint => Painting(
        [],
        color: settingsController.strokeColor,
        pointMode: settingsController.pointsMode,
        strokeWidth: settingsController.strokeWidth,
      );
  //============================================================================
  //! This section is for the pageView related Methods
  //============================================================================
  Future<void> changePageView(
    int index, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.fastLinearToSlowEaseIn,
  }) async {
    await pageViewController.animateToPage(
      index,
      duration: duration,
      curve: curve,
    );
  }

  //============================================================================
  // this will add a new 'painting' to the home page view
  void addNewPaintingSlide() {
    _bigList.addIf(
      _bigList.last.last.value.pointsList.isNotEmpty,
      [newPaint.obs].obs,
    );
  }

  //============================================================================
  void testMethod() {
    try {
      var x = [1, 2].obs;
      x.addIf(x.isEmpty, 5);
      print(x);
    } catch (e) {
      print('Error @ method $e');
    }
  }
  //============================================================================
}
