import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:painter/app/core/theme/app_colors.dart';
import 'package:painter/app/core/theme/app_theme.dart';

import 'package:painter/app/modules/home/widgets/custom_fab.dart';
import 'package:painter/app/modules/home/widgets/my_painter.dart';
import 'package:painter/app/modules/home/widgets/springy_widget.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';
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
    //==========================================================================
    print('rebuilding home');
    return Scaffold(
      appBar: CustomAppBar(
        text: 'home_view_title'.tr,
      ),
      // actions: [
      //   IconButton(
      //     icon: Icon(Icons.face),
      //     onPressed: () =>
      //         _settingsController.setPointMode = PointMode.points,
      //   ),
      //   IconButton(
      //     icon: Icon(Icons.settings),
      //     onPressed: () async => await Get.to(
      //       () => SettingsView(),
      //       transition: Transition.cupertino,
      //       duration: Duration(milliseconds: 400),
      //     ),
      //   ),
      //   IconButton(
      //     icon: Icon(Icons.phonelink_erase),
      //     onPressed: controller.erase,
      //   ),
      // ],

      body: Stack(
        children: [
          GestureDetector(
            onPanStart: (details) {
              controller.drawingMode == DrawingMode.PAINT
                  ? controller.addPoint(details.localPosition)
                  : controller.erase(details.localPosition);
            },
            onPanUpdate: (details) {
              controller.drawingMode == DrawingMode.PAINT
                  ? controller.addPoint(details.localPosition)
                  : controller.erase(details.localPosition);
            },
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
          if (_mediaQuery.orientation == Orientation.portrait)
            GestureDetector(
              child: SpringyWidget(
                alignment: Alignment(0.88, 0.78),
                duration: Duration(milliseconds: 800),
                child: Container(
                  padding: const EdgeInsets.all(2.0),
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
                    // color: Colors.black,
                    height: _mediaQuery.orientation == Orientation.portrait
                        ? _mediaQuery.size.height * 0.045
                        : _mediaQuery.size.width * 0.045,
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
