import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:painter/app/core/theme/app_theme.dart';

import 'package:painter/app/modules/home/widgets/custom_fab.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';
import 'package:painter/app/modules/settings/views/settings_view.dart';
import 'package:painter/app/modules/home/widgets/my_painter.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  //================================ Parameters ===============================
  final _settingsController = Get.find<SettingsController>();
  //==========================================================================
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    //==========================================================================
    print('rebuilding home');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appTheme.appBarTheme.backgroundColor,
        centerTitle: true,
        title: Text(
          'home_view_title'.tr,
          style: AppTheme.appTheme.appBarTheme.titleTextStyle,
        ),
        actionsIconTheme: AppTheme.appTheme.appBarTheme.actionsIconTheme,
        elevation: 1.0,
        actions: [
          IconButton(
            icon: Icon(Icons.face),
            onPressed: () =>
                _settingsController.setPointMode = PointMode.points,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async => await Get.to(
              () => SettingsView(),
              transition: Transition.cupertino,
              duration: Duration(milliseconds: 400),
            ),
          ),
          IconButton(
            icon: Icon(Icons.phonelink_erase),
            onPressed: controller.erase,
          ),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onPanStart: (details) {
            // to only draw in it's specified area [respect appbar and bottom]
            if (details.localPosition.direction > 0.0) {
              controller.addPoint(
                  entryTime: DateTime.now(), point: details.localPosition);
            }
          },
          onPanUpdate: (details) {
            if (details.localPosition.direction > 0.0) {
              controller.addPoint(
                  entryTime: DateTime.now(), point: details.localPosition);
            }
          },
          // onPanEnd: (_) => controller.addEqualizingPoint(),
          child: Obx(
            () => CustomPaint(
              painter: MyPainter(
                pointsList: controller.pointsList,
                pointMode: _settingsController.pointsMode,
                strokeWidth: _settingsController.strokeWidth,
                color: _settingsController.strokeColor,
              ),
              // take all the available space
              size: Size.infinite,
              isComplex: true,
              willChange: true,
            ),
          ),
        ),
      ),
      // 'Container' is used to enable [rotated custom fab], If i try to
      // put it in a FAB it does not work,
      floatingActionButton: Container(
        height: _mediaQuery.orientation == Orientation.portrait
            ? _mediaQuery.size.height * 0.06
            : _mediaQuery.size.width * 0.06,
        width: double.infinity,
        alignment: Alignment.bottomRight,
        child: CustomFAB(),
      ),
    );
  }
}
