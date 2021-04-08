import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:painter/app/modules/home/controllers/home_controller.dart';

class CustomFAB extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: Colors.deepPurple.shade900,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(color: Colors.white),
      animationSpeed: 350,
      closeManually: true,
      curve: Curves.fastLinearToSlowEaseIn,
      tooltip: 'Tools',
      children: [
        SpeedDialChild(
          label: 'UNDO',
          labelStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito',
          ),
          child: Obx(
            () => IconButton(
              icon: Icon(
                Icons.undo,
                size: 30.0,
              ),
              onPressed: controller.isUndoActive ? controller.undo : null,
            ),
          ),
        ),
        SpeedDialChild(
          label: 'Redo',
          labelStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito',
          ),
          child: Obx(
            () => IconButton(
              icon: Icon(
                Icons.redo,
                size: 30.0,
              ),
              onPressed: controller.isRedoActive ? controller.redo : null,
            ),
          ),
        ),
        SpeedDialChild(
          label: 'Clear',
          labelStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito',
          ),
          child: Obx(
            () => IconButton(
              icon: Icon(
                Icons.cleaning_services,
              ),
              onPressed:
                  controller.isUndoActive ? controller.clearPoints : null,
            ),
          ),
        ),
        SpeedDialChild(
          label: 'Restore',
          labelStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito',
          ),
          child: Obx(
            () => IconButton(
              icon: Icon(Icons.restore),
              onPressed: controller.isRestoreActive ? controller.restore : null,
            ),
          ),
        ),
      ],
    );
  }
}
