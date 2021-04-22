import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/app/modules/home/controllers/home_controller.dart';

import 'home_body.dart';
import 'scaling_widget.dart';

class MyPageView extends StatelessWidget {
  //================================ Properties ================================
  final homeController = Get.find<HomeController>();
  //================================ Constructor ===============================

  //================================= Methods ==================================

  //============================================================================
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: homeController.pageViewController,
      children: [
        Padding(
          padding: EdgeInsets.all(Get.height * 0.015),
          child: PaintingBoard(),
        ),
        Padding(
          padding: EdgeInsets.all(Get.height * 0.015),
          child: PaintingBoard(),
        ),
      ],
    );
  }
}

class PaintingBoard extends StatelessWidget {
  //================================ Properties ================================
  //
  //================================ Constructor ===============================

  //================================= Methods ==================================

  //============================================================================
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (_, closed) => ScalingWidget(
        child: HomeBody(),
        height: 450,
        width: 450,
      ),
      openBuilder: (_, open) => ScalingWidget(
        child: HomeBody(),
        height: Get.height,
        width: Get.width,
      ),
      closedColor: Colors.transparent,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      transitionDuration: Duration(milliseconds: 500),
    );
  }
}
