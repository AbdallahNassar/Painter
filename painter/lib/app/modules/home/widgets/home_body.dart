import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:painter/app/modules/home/controllers/home_controller.dart';
import 'package:painter/app/modules/home/widgets/my_painter.dart';

class HomeBody extends StatelessWidget {
  //================================ Properties ================================
  final HomeController controller;
  //================================ Constructor ===============================
  const HomeBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        // to only draw in it's specified area [respect appbar and bottom]
        if (details.localPosition.direction > 0.0)
          controller.addPoint = details.localPosition;
      },
      onPanUpdate: (details) {
        if (details.localPosition.direction > 0.0)
          controller.addPoint = details.localPosition;
      },
      onPanDown: (details) {
        if (details.localPosition.direction > 0.0)
          controller.addPoint = details.localPosition;
      },
      child: Obx(
        () => CustomPaint(
          painter: MyPainter(
            pointsList: controller.pointsList,
            pointMode: controller.pointsMode,
            strokeWidth: controller.strokeWidth,
            color: controller.color,
          ),
          // take all the available space
          size: Size.infinite,
          isComplex: true,
          willChange: true,
        ),
      ),
    );
  }
}
