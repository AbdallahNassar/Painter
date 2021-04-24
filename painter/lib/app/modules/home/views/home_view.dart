import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:painter/app/core/theme/app_colors.dart';
import 'package:painter/app/core/theme/app_theme.dart';
import 'package:painter/app/modules/home/widgets/page_view.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  //================================ Parameters ===============================
  final _settingsController = Get.find<SettingsController>();
  //==========================================================================
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    controller.setSettingsController = (_settingsController);
    //==========================================================================
    return Scaffold(
      backgroundColor: AppColors.scaffoldDarkBackgroundColor,
      body: Column(
        children: [
          Spacer(
            flex: 2,
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'home_view_title'.tr,
                style: AppTheme.appTheme.textTheme.headline3,
              ),
            ),
          ),
          Expanded(
            flex: 11,
            child: Padding(
              padding: EdgeInsets.only(
                top: Get.height * 0.035,
              ),
              child: MyPageView(),
            ),
          ),
          Spacer(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // this will add a new slide in the home page
        onPressed: controller.addNewPaintingSlide,
      ),
    );
  }
}
