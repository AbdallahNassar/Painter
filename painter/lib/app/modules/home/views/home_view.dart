import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:painter/app/core/theme/app_colors.dart';
import 'package:painter/app/modules/home/widgets/custom_fab.dart';
import 'package:painter/app/modules/home/widgets/my_painter.dart';
import 'package:painter/app/modules/home/widgets/springy_widget.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';
import 'package:painter/app/modules/settings/views/settings_view.dart';
import 'package:painter/app/widgets/custom_app_bar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  //================================ Parameters ===============================
  final _settingsController = Get.find<SettingsController>();
  //==========================================================================
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    controller.setSettingsController = (_settingsController);
    //==========================================================================
    return Scaffold(
      appBar: CustomAppBar(
        text: 'home_view_title'.tr,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async => await Get.to(
              () => SettingsView(),
              transition: Transition.cupertino,
              duration: Duration(milliseconds: 400),
              popGesture: true,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          GestureDetector(
            onPanStart: (details) => controller.addPoint(details.localPosition),
            onPanUpdate: (details) =>
                controller.addPoint(details.localPosition),
            child: Obx(
              () => CustomPaint(
                painter: MyPainter(
                  bigList: controller.bigList,
                  // this will be used to force the widget to rebuild .. it
                  // doesn't rebuild without it as I want to pass the entire
                  // big list to the painter, and a change in the biglist is
                  // only considered when I insert another list intoit
                  dummyValue: controller.bigList.last.value.pointsList.length,
                ),
                // take all the available space
                size: Size.infinite,
                isComplex: true,
                willChange: true,
              ),
            ),
          ),
          if (_mediaQuery.orientation == Orientation.portrait)
            GestureDetector(
              child: SpringyWidget(
                alignment: Alignment(0.89, 0.78),
                duration: Duration(milliseconds: 800),
                child: Obx(
                  () => Container(
                    // to dynamically change the size of the eraser when
                    // I change pen size
                    padding: EdgeInsets.all(
                      _settingsController.eraserSize / 22,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(220.0),
                      border: Border.all(
                        width: 2.0,
                        color: AppColors.primaryColor,
                      ),
                      color: AppColors.grey,
                    ),
                    child: Image.asset(
                      'assets/icons/eraserIcon.png',
                      // to dynamically change the size of the eraser when
                      // I change pen size
                      height: _settingsController.eraserSize * 2,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: Container(
        child: CustomFAB(),
        height: 50.0,
      ),
    );
  }
}
