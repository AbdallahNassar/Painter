import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:painter/app/core/theme/app_colors.dart';
import 'package:painter/app/modules/home/controllers/home_controller.dart';

class CustomFAB extends GetView<HomeController> {
  //================================ Properties ================================
  // the index where the [FAB] is being shown, to perfom it's operation on
  // the correct [Paintinr]
  final int index;
  //============================== Constructor =================================
  CustomFAB(this.index);
  //================================= Methods ==================================
  TextStyle _fabTextStyle() => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Nunito',
      );

  //============================================================================
  @override
  Widget build(BuildContext context) {
    // [RotatedBox] to make the [FAB] open horizontaly.
    return RotatedBox(
      quarterTurns: 3,
      child: SpeedDial(
        closeManually: true,
        shape: StadiumBorder(),
        backgroundColor: Colors.deepPurple.shade900,
        animatedIcon: AnimatedIcons.menu_close,
        child: Icon(Icons.ac_unit),
        animatedIconTheme: IconThemeData(color: Colors.white),
        animationSpeed: 250,
        curve: Curves.fastLinearToSlowEaseIn,
        tooltip: 'Tools',
        children: [
          SpeedDialChild(
            backgroundColor: AppColors.scaffoldBackgroundColor,
            labelStyle: _fabTextStyle(),
            child: RotatedBox(
              quarterTurns: 1,
              child: Obx(
                () => IconButton(
                  icon: Icon(
                    Icons.undo,
                    size: 30.0,
                  ),
                  onPressed: controller.isUndoActive ? controller.undo : null,
                  highlightColor: Colors.transparent,
                ),
              ),
            ),
          ),
          SpeedDialChild(
            backgroundColor: AppColors.scaffoldBackgroundColor,
            labelStyle: _fabTextStyle(),
            child: RotatedBox(
              quarterTurns: 1,
              child: Obx(
                () => IconButton(
                  icon: Icon(
                    Icons.redo,
                    size: 30.0,
                  ),
                  onPressed: controller.isRedoActive ? controller.redo : null,
                  highlightColor: Colors.transparent,
                ),
              ),
            ),
          ),
          SpeedDialChild(
            backgroundColor: AppColors.scaffoldBackgroundColor,
            labelStyle: _fabTextStyle(),
            child: RotatedBox(
              quarterTurns: 1,
              child: Obx(
                () => IconButton(
                  icon: Icon(
                    Icons.cleaning_services,
                  ),
                  onPressed:
                      controller.isUndoActive ? controller.clearPoints : null,
                  highlightColor: Colors.transparent,
                ),
              ),
            ),
          ),
          SpeedDialChild(
            backgroundColor: AppColors.scaffoldBackgroundColor,
            labelStyle: _fabTextStyle(),
            child: RotatedBox(
              quarterTurns: 1,
              child: Obx(
                () => IconButton(
                  icon: Icon(Icons.restore),
                  onPressed:
                      controller.isRestoreActive ? controller.restore : null,
                  highlightColor: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
