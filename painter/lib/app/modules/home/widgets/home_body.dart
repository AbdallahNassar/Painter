import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:painter/app/modules/home/controllers/home_controller.dart';
import 'package:painter/app/modules/home/widgets/springy_widget.dart';
import 'package:painter/app/core/theme/app_colors.dart';
import 'package:painter/app/modules/home/widgets/my_painter.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';

class HomeBody extends StatelessWidget {
  //================================ Properties ================================
  // this will be used to access the correct list from the slidesList.
  final int index;
  //================================ Constructor ===============================
  const HomeBody(this.index);

  //============================================================================
  @override
  Widget build(BuildContext context) {
    print('home body index is $index');
    //================================ Parameters ==============================
    final _homeController = Get.find<HomeController>();
    final _settingsController = Get.find<SettingsController>();
    //==========================================================================
    return Stack(
      children: [
        GestureDetector(
          onPanStart: (details) {
            // takes the point to add, and the index of the [bigList] or
            // [Painting] to add into
            _homeController.addPoint(
              index,
              details.localPosition,
            );
          },
          onPanUpdate: (details) {
            _homeController.addPoint(
              index,
              details.localPosition,
            );
          },
          child: Obx(
            () => CustomPaint(
              painter: MyPainter(
                bigList: _homeController.bigList[index],
                // this will be used to force the widget to rebuild .. it
                // doesn't rebuild without it as I want to pass the entire
                // big list to the painter, and a change in the biglist is
                // only considered when I insert another list intoit
                dummyValue:
                    _homeController.bigList[index].last.value.pointsList.length,
              ),
              // take all the available space
              size: Size.infinite,
              isComplex: true,
              willChange: true,
            ),
          ),
        ),
        if (Get.mediaQuery.orientation == Orientation.portrait)
          GestureDetector(
            child: SpringyWidget(
              index: index,
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
