import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/app/modules/home/controllers/home_controller.dart';
import 'package:painter/app/modules/painting/views/painting_view.dart';

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
    return Obx(
      () => PageView.builder(
        itemCount: homeController.bigList.length,
        controller: homeController.pageViewController,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.all(Get.height * 0.015),
          child: PaintingSlide(index),
        ),
      ),
    );
  }
}

class PaintingSlide extends StatelessWidget {
  //================================ Properties ================================
  // this will be used to access the correct list for each slide
  final int index;
  //================================ Constructor ===============================
  const PaintingSlide(this.index);
  //================================= Methods ==================================

  //============================================================================
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (_, closed) => ScalingWidget(
        child: HomeBody(index),
        height: 200,
        width: 200,
      ),
      openBuilder: (_, open) => PaintingView(
        index: index,
      ),
      closedColor: Colors.transparent,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      transitionDuration: Duration(milliseconds: 500),
    );
  }
}
