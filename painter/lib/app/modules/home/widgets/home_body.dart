import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/app/modules/home/controllers/home_controller.dart';
import 'package:painter/app/modules/home/widgets/springy_widget.dart';
import 'package:painter/app/core/theme/app_colors.dart';
import 'package:painter/app/modules/home/widgets/my_painter.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final _mediaQuery = MediaQuery.of(context);
    final _homeController = Get.find<HomeController>();
    final _settingsController = Get.find<SettingsController>();
    //==========================================================================
    return Stack(
      children: [
        GestureDetector(
          onPanStart: (details) {
            _homeController.addPoint(details.localPosition);
          },
          onPanUpdate: (details) {
            _homeController.addPoint(details.localPosition);
          },
          child: Obx(
            () => CustomPaint(
              painter: MyPainter(
                bigList: _homeController.bigList,
                // this will be used to force the widget to rebuild .. it
                // doesn't rebuild without it as I want to pass the entire
                // big list to the painter, and a change in the biglist is
                // only considered when I insert another list intoit
                dummyValue:
                    _homeController.bigList.last.value.pointsList.length,
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
    );
  }
}
