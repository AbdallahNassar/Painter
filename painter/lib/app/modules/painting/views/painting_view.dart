import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:painter/app/core/theme/app_colors.dart';
import 'package:painter/app/modules/home/controllers/home_controller.dart';
import 'package:painter/app/modules/home/widgets/home_body.dart';
import 'package:painter/app/modules/home/widgets/scaling_widget.dart';
import 'package:painter/app/modules/settings/views/settings_view.dart';
import 'package:painter/app/widgets/custom_app_bar.dart';

import '../controllers/painting_controller.dart';

class PaintingView extends GetView<PaintingController> {
  //================================ Properties ================================
  final homeController = Get.find<HomeController>();
  //================================ Constructor ===============================

  //================================= Methods ==================================

  //============================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldDarkBackgroundColor,
      appBar: CustomAppBar(
        backgroundColor: AppColors.scaffoldDarkBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.save_outlined,
          ),
          onPressed: homeController.save,
        ),
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
        elevation: 0.0,
      ),
      body: SafeArea(
        child: ScalingWidget(
          child: HomeBody(),
          height: Get.height,
          width: Get.width,
        ),
      ),
    );
  }
}
