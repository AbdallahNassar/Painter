import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:painter/app/core/theme/app_colors.dart';
import 'package:painter/app/core/theme/app_theme.dart';
import 'package:painter/app/modules/home/widgets/custom_fab.dart';
import 'package:painter/app/modules/home/widgets/home_body.dart';
import 'package:painter/app/modules/home/widgets/page_view.dart';
import 'package:painter/app/modules/home/widgets/scaling_widget.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';
import 'package:painter/app/modules/settings/views/settings_view.dart';
import 'package:painter/app/widgets/custom_app_bar.dart';
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
      appBar: CustomAppBar(
        backgroundColor: AppColors.scaffoldDarkBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.save_outlined,
          ),
          onPressed: controller.save,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
              flex: 13,
              child: Padding(
                padding: EdgeInsets.all(
                  Get.height * 0.03,
                ),
                child: MyPageView(),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 30.0,
              ),
            ),
          ],
        ),
      ),
      // body: ScalingWidget(
      //   child: HomeBody(),
      //   height: 200,
      //   width: 300,
      // ),
      // floatingActionButton: Container(
      //   child: CustomFAB(),
      //   height: 50.0,
      // ),
    );
  }
}
